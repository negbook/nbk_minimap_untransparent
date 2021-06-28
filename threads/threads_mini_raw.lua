Threads = {}

Threads_OnceThread = {}
Threads.CreateThreadOnce = function(fn)
    if Threads_OnceThread[tostring(fn)] then 
        return 
    end 
    Threads_OnceThread[tostring(fn)] = true
    CreateThread(fn)
end 
Threads.ClearThreadOnce = function(name)
    Threads_OnceThread[name] = nil 
end 

--stable:
local function Threads_IsActionTableCreated(timer) return Threads_ActionTables[timer]  end 
Threads_Alive = {}
Threads_Timers = {}
Threads_Functions = {}
Threads_Once = {}
Threads_ActionTables = {}
Threads.loop = function()error("Outdated",2) end 
Threads.loop2 = function(_name,_timer,_func)
    if Threads_Once[_name] then return end 
    local name = _name or tostring(_func)
    local timer = _timer>=0 and _timer or 0
    local IsThreadCreated = Threads_IsActionTableCreated(timer) --Threads_ActionTables[timer] Exist
	if IsThreadCreated then  
        if Threads_Functions[name] then 
            print('[Warning]Threads'..name..' is doubly and replaced')  
        end 
        Threads_Alive[name] = true 
        Threads_Functions[name] = _func
        Threads_Timers[name] = timer 
        table.insert(Threads_ActionTables[timer],name ) -- 如果default此毫秒已存在 則添加到循環流程中
    else                                -- 否則新建一個default的毫秒表 以及新建一個循環線程
		if Threads_Functions[name] then 
            print('[Warning]Threads'..name..' is doubly and replaced')  
        end 
        Threads_Alive[name] = true 
        Threads_Functions[name] = _func
        Threads_Timers[name] = timer 
        Threads_ActionTables[timer] = {}	
		local actiontable = Threads_ActionTables[timer] 
        local vt = timer
		table.insert(Threads_ActionTables[timer] , name)
		CreateThread(function() 
			while true do
                
                
                if #actiontable == 0 then 
                    return 
                end 
                
				for i=1,#actiontable do 
                    local v = actiontable[i]
                    if Threads_Alive[v] and Threads_Functions[v] and Threads_Timers[v] == timer then 
                        Threads_Functions[v](v,#actiontable)
                    else 
                        
                        if actiontable and actiontable[i] then 
                            table.remove(actiontable ,i) 
                            if #actiontable == 0 then 
                                Threads.KillLoop(name,timer)
                                return 
                            end 
                        end 
                    end 
				end 
                Wait(vt)
            end 
            return 
		end)
	end 
end
Threads.CreateLoop = function(...) 
    local tbl = {...}
    local length = #tbl
    local func,timer,name
    if length == 3 then 
        name = tbl[1]
        timer = tbl[2]
        func = tbl[3]
    elseif  length == 2 then 
        name = GetCurrentResourceName()
        timer = tbl[1]
        func = tbl[2]
    elseif  length == 1 then 
        name = GetCurrentResourceName()
        timer = 0
        func = tbl[1]
    end 
    Threads.loop2(name,timer,func)
end
Threads.CreateLoopOnce = function(...) 
    local tbl = {...}
    local length = #tbl
    local func,timer,name
    if length == 3 then 
        name = tbl[1]
        timer = tbl[2]
        func = tbl[3]
    elseif  length == 2 then 
        name = GetCurrentResourceName()
        timer = tbl[1]
        func = tbl[2]
    elseif  length == 1 then 
        name = GetCurrentResourceName()
        timer = 0
        func = tbl[1]
    end 
    if not Threads_Once[name] then 
        Threads.loop2(name,timer,func)
        Threads_Once[name] = true 
    end 
end
Threads.IsActionOfLoopAlive = function(name)
    return Threads_Alive[name] and true or false
end 
Threads.IsLoopAlive = function(name)
    return Threads_Functions[name] and true or false
end 
Threads.KillLoop = function(name,timer)
    Threads_Alive[name] = nil 
    Threads_Functions[name] = nil
    Threads_Timers[name] = nil 
    Threads_ActionTables[timer] = nil	
    Threads_Once[name]  = nil
end 
Threads.KillActionOfLoop = function(name)
    for timer,_name in pairs (Threads_ActionTables) do 
        if _name == name then 
            for i=1,#Threads_ActionTables[timer] do 
                if Threads_ActionTables[timer][i] == name then 
                    table.remove(Threads_ActionTables[timer] ,i) 
                    if #Threads_ActionTables[timer] == 0 then 
                        Threads.KillLoop(name,timer)
                        return 
                    end 
                end 
            end 
        end 
    end 
    Threads_Alive[name] = nil 
    Threads_Once[name] = nil 
    Threads_Functions[name] = nil
end 
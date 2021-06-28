Scaleforms = {}
Scaleforms.init = {}
Scaleforms.init.temp_tasks = {}
Scaleforms.init.Tasks = {}
Scaleforms.init.Handles = {}
Scaleforms.init.Kill = {}
Scaleforms.init.ReleaseTimer = {}


SendScaleformValues = function (...)
    local tb = {...}
    for i=1,#tb do
        if type(tb[i]) == "number" then 
            if math.type(tb[i]) == "integer" then
                    ScaleformMovieMethodAddParamInt(tb[i])
            else
                    ScaleformMovieMethodAddParamFloat(tb[i])
            end
        elseif type(tb[i]) == "string" then ScaleformMovieMethodAddParamTextureNameString(tb[i])
        elseif type(tb[i]) == "boolean" then ScaleformMovieMethodAddParamBool(tb[i])
        end
    end 
end

--[=[
--  TriggerEvent('CallScaleformMovie','TALK_MESSAGE',function(run,send,stop)  -- or function(run,send,stop,handle)
            run('SayToAll')
                send(1,2,3,4,5)
            stop()
    end )
--]=]


exports('CallScaleformMovie', function (scaleformName,cb)
    if not Scaleforms.init.Handles[scaleformName] or not HasScaleformMovieLoaded(Scaleforms.init.Handles[scaleformName]) then 
        Threads.CreateLoad(scaleformName,RequestScaleformMovie,HasScaleformMovieLoaded,function(handle)
            Scaleforms.init.Handles[scaleformName] = handle
        end)
        local count = 0
        for i,v in pairs(Scaleforms.init.Handles) do 
            count = count + 1
        end 
        Scaleforms.init.counts = count
    end 
    local inputfunction = function(sfunc) PushScaleformMovieFunction(Scaleforms.init.Handles[scaleformName],sfunc) end
    cb(inputfunction,SendScaleformValues,PopScaleformMovieFunctionVoid,Scaleforms.init.Handles[scaleformName])
end)


exports('RequestScaleformCallbackString', function (scaleformName,SfunctionName,...) 
    if not Scaleforms.init.Handles[scaleformName] or not HasScaleformMovieLoaded(Scaleforms.init.Handles[scaleformName]) then 
        Threads.CreateLoad(scaleformName,RequestScaleformMovie,HasScaleformMovieLoaded,function(handle)
            Scaleforms.init.Handles[scaleformName] = handle
        end)
        local count = 0
        for i,v in pairs(Scaleforms.init.Handles) do 
            count = count + 1
        end 
        Scaleforms.init.counts = count
    end 
    BeginScaleformMovieMethod(Scaleforms.init.Handles[scaleformName],SfunctionName) --call function
    local ops = {...}
    local cb = ops[#ops]
    table.remove(ops,#ops)
    SendScaleformValues(...)
    local b = EndScaleformMovieMethodReturnValue()
    while true do 
    if IsScaleformMovieMethodReturnValueReady(b) then 
       local c = GetScaleformMovieMethodReturnValueString(b)  --output
       cb(c)
       break 
    end 
    Citizen.Wait(0)
    end
end )



exports('RequestScaleformCallbackInt', function(scaleformName,SfunctionName,...) 
    if not Scaleforms.init.Handles[scaleformName] or not HasScaleformMovieLoaded(Scaleforms.init.Handles[scaleformName]) then 
        Threads.CreateLoad(scaleformName,RequestScaleformMovie,HasScaleformMovieLoaded,function(handle)
            Scaleforms.init.Handles[scaleformName] = handle
        end)
        local count = 0
        for i,v in pairs(Scaleforms.init.Handles) do 
            count = count + 1
        end 
        Scaleforms.init.counts = count
    end 
    BeginScaleformMovieMethod(Scaleforms.init.Handles[scaleformName],SfunctionName) --call function
    local ops = {...}
    local cb = ops[#ops]
    table.remove(ops,#ops)
    SendScaleformValues(...)
    local b = EndScaleformMovieMethodReturnValue()
    while true do 
    if IsScaleformMovieMethodReturnValueReady(b) then 
       local c = GetScaleformMovieMethodReturnValueInt(b)  --output
       cb(c)
       break 
    end 
    Citizen.Wait(0)
    end
end )


exports('RequestScaleformCallbackBool', function(scaleformName,SfunctionName,...) 
    if not Scaleforms.init.Handles[scaleformName] or not HasScaleformMovieLoaded(Scaleforms.init.Handles[scaleformName]) then 
        Threads.CreateLoad(scaleformName,RequestScaleformMovie,HasScaleformMovieLoaded,function(handle)
            Scaleforms.init.Handles[scaleformName] = handle
        end)
        local count = 0
        for i,v in pairs(Scaleforms.init.Handles) do 
            count = count + 1
        end 
        Scaleforms.init.counts = count
    end 
    BeginScaleformMovieMethod(Scaleforms.init.Handles[scaleformName],SfunctionName) --call function
    local ops = {...}
    local cb = ops[#ops]
    table.remove(ops,#ops)
    SendScaleformValues(...)
    local b = EndScaleformMovieMethodReturnValue()
    while true do 
    if IsScaleformMovieMethodReturnValueReady(b) then 
       local c = GetScaleformMovieMethodReturnValueBool(b)  --output
       cb(c)
       break 
    end 
    Citizen.Wait(0)
    end
end )


exports('DrawScaleformMovie', function (scaleformName,...)
    if not Scaleforms.init.Handles[scaleformName] or not HasScaleformMovieLoaded(Scaleforms.init.Handles[scaleformName]) then 
        Threads.CreateLoad(scaleformName,RequestScaleformMovie,HasScaleformMovieLoaded,function(handle)
            Scaleforms.init.Handles[scaleformName] = handle
        end)
        local count = 0
        for i,v in pairs(Scaleforms.init.Handles) do 
            count = count + 1
        end 
        Scaleforms.init.counts = count
    end 
    if Scaleforms.init.Handles[scaleformName] then 
        local ops = {...}
        if #ops > 1 then 
            Threads.CreateLoopOnce('scaleforms',0,function()
                if Scaleforms.init.counts == 0 then 
                    Threads.KillActionOfLoop('scaleforms')
                end 
                for i = 1,#(Scaleforms.init.Tasks) do
                    Scaleforms.init.Tasks[i]()
                end 
            end)
            Scaleforms.init.temp_tasks[scaleformName] = function()
                if Scaleforms.init.Kill[scaleformName] then  
                    SetScaleformMovieAsNoLongerNeeded(Scaleforms.init.Handles[scaleformName])
                    Scaleforms.init.Handles[scaleformName] = nil 
                    Scaleforms.init.Kill[scaleformName] = nil
                    Scaleforms.init.counts = Scaleforms.init.counts - 1
                    Scaleforms.init.temp_tasks[scaleformName] = nil
                elseif Scaleforms.init.Handles[scaleformName] then
                    if #ops > 1 then 
                    SetScriptGfxDrawOrder(ops[#ops])
                    end 
                    DrawScaleformMovie(Scaleforms.init.Handles[scaleformName], table.unpack(ops))
                    ResetScriptGfxAlign()
                end 
            end 
            local task = {}
            for i,v in pairs (Scaleforms.init.temp_tasks ) do
                table.insert(task,v)
            end 
            Scaleforms.init.Tasks = task
        else 
            Threads.CreateLoopOnce('scaleforms',0,function()
                if Scaleforms.init.counts == 0 then 
                    Threads.KillActionOfLoop('scaleforms')
                end 
                for i = 1,#(Scaleforms.init.Tasks) do
                    Scaleforms.init.Tasks[i]()
                end 
            end)
            Scaleforms.init.temp_tasks [scaleformName] = function()
                if Scaleforms.init.Kill[scaleformName] then  
                    SetScaleformMovieAsNoLongerNeeded(Scaleforms.init.Handles[scaleformName])
                    Scaleforms.init.Handles[scaleformName] = nil 
                    Scaleforms.init.Kill[scaleformName] = nil
                    Scaleforms.init.counts = Scaleforms.init.counts - 1
                    Scaleforms.init.temp_tasks[scaleformName] = nil
                elseif Scaleforms.init.Handles[scaleformName] then 
                    
                    if #ops == 1 then 
                    
                    SetScriptGfxDrawOrder(ops[1])
                    end 
                    DrawScaleformMovieFullscreen(Scaleforms.init.Handles[scaleformName])
                    ResetScriptGfxAlign()
                    
                end 
            end
            local task = {}
            for i,v in pairs (Scaleforms.init.temp_tasks ) do
                table.insert(task,v)
            end 
            Scaleforms.init.Tasks = task
        end 
    end 
end )



exports('DrawScaleformMoviePosition', function (scaleformName,...)
    if not Scaleforms.init.Handles[scaleformName] or not HasScaleformMovieLoaded(Scaleforms.init.Handles[scaleformName]) then 
        Threads.CreateLoad(scaleformName,RequestScaleformMovie,HasScaleformMovieLoaded,function(handle)
            Scaleforms.init.Handles[scaleformName] = handle
        end)
        local count = 0
        for i,v in pairs(Scaleforms.init.Handles) do 
            count = count + 1
        end 
        Scaleforms.init.counts = count
    end 
    if Scaleforms.init.Handles[scaleformName] then 
        local ops = {...}
        if #ops > 0 then 
            Threads.CreateLoopOnce('scaleforms',0,function()
                if Scaleforms.init.counts == 0 then 
                    Threads.KillActionOfLoop('scaleforms')
                end 
                for i = 1,#(Scaleforms.init.Tasks) do
                    Scaleforms.init.Tasks[i]()
                end 
            end)
            Scaleforms.init.temp_tasks[scaleformName] = function()
                if Scaleforms.init.Kill[scaleformName] then  
                    SetScaleformMovieAsNoLongerNeeded(Scaleforms.init.Handles[scaleformName])
                    Scaleforms.init.Handles[scaleformName] = nil 
                    Scaleforms.init.Kill[scaleformName] = nil
                    Scaleforms.init.counts = Scaleforms.init.counts - 1
                    Scaleforms.init.temp_tasks[scaleformName] = nil
                elseif Scaleforms.init.Handles[scaleformName] then 
                    DrawScaleformMovie_3d(Scaleforms.init.Handles[scaleformName], table.unpack(ops))
                end 
            end 
            local task = {}
            for i,v in pairs (Scaleforms.init.temp_tasks ) do
                table.insert(task,v)
            end 
            Scaleforms.init.Tasks = task
        end 
    end 
end )


exports('DrawScaleformMoviePosition2', function (scaleformName,...)
    if not Scaleforms.init.Handles[scaleformName] or not HasScaleformMovieLoaded(Scaleforms.init.Handles[scaleformName]) then 
        Threads.CreateLoad(scaleformName,RequestScaleformMovie,HasScaleformMovieLoaded,function(handle)
            Scaleforms.init.Handles[scaleformName] = handle
        end)
        local count = 0
        for i,v in pairs(Scaleforms.init.Handles) do 
            count = count + 1
        end 
        Scaleforms.init.counts = count
    end 
    if Scaleforms.init.Handles[scaleformName] then 
        local ops = {...}
        if #ops > 0 then 
            Threads.CreateLoopOnce('scaleforms',0,function()
                if Scaleforms.init.counts == 0 then 
                    Threads.KillActionOfLoop('scaleforms')
                end 
                for i = 1,#(Scaleforms.init.Tasks) do
                    Scaleforms.init.Tasks[i]()
                end 
            end)
            Scaleforms.init.temp_tasks[scaleformName] = function()
                if Scaleforms.init.Kill[scaleformName] then  
                    SetScaleformMovieAsNoLongerNeeded(Scaleforms.init.Handles[scaleformName])
                    Scaleforms.init.Handles[scaleformName] = nil 
                    Scaleforms.init.Kill[scaleformName] = nil
                    Scaleforms.init.counts = Scaleforms.init.counts - 1
                    Scaleforms.init.temp_tasks[scaleformName] = nil
                elseif Scaleforms.init.Handles[scaleformName] then 
                    DrawScaleformMovie_3dSolid(Scaleforms.init.Handles[scaleformName], table.unpack(ops))
                end 
            end 
            local task = {}
            for i,v in pairs (Scaleforms.init.temp_tasks ) do
                table.insert(task,v)
            end 
            Scaleforms.init.Tasks = task
        end 
    end 
end )


exports('EndScaleformMovie', function (scaleformName)
    if not Scaleforms.init.Handles[scaleformName] then 
    else 
        Scaleforms.init.Kill[scaleformName] = true
        SetScaleformMovieAsNoLongerNeeded(Scaleforms.init.Handles[scaleformName])
        Scaleforms.init.Handles[scaleformName] = nil 
        Scaleforms.init.Kill[scaleformName] = nil
        Scaleforms.init.counts = Scaleforms.init.counts - 1
        Scaleforms.init.temp_tasks[scaleformName] = nil
    end 
end )



exports('KillScaleformMovie', function(scaleformName)
    if not Scaleforms.init.Handles[scaleformName] then 
    else 
        Scaleforms.init.Kill[scaleformName] = true
        SetScaleformMovieAsNoLongerNeeded(Scaleforms.init.Handles[scaleformName])
        Scaleforms.init.Handles[scaleformName] = nil 
        Scaleforms.init.Kill[scaleformName] = nil
        Scaleforms.init.counts = Scaleforms.init.counts - 1
        Scaleforms.init.temp_tasks[scaleformName] = nil
    end 
end )


exports('DrawScaleformMovieDuration', function (scaleformName,duration,...)
    local ops = {...}
    local cb = ops[#ops]
    table.remove(ops,#ops)
    CreateThread(function()
        Scaleforms.init.DrawScaleformMovie(scaleformName,table.unpack(ops))
        Scaleforms.init.ReleaseTimer[scaleformName] = GetGameTimer() + duration
        
        Threads.CreateLoopOnce("ScaleformDuration"..scaleformName,333,function()
            if GetGameTimer() >= Scaleforms.init.ReleaseTimer[scaleformName] then 
                Scaleforms.init.KillScaleformMovie(scaleformName);
                if type(cb) == 'function' then 
                    cb()
                end 
                
                Threads.KillActionOfLoop("ScaleformDuration"..scaleformName,333);
            end 
        end)
    end)
end )


exports('DrawScaleformMoviePositionDuration', function (scaleformName,duration,...)
     local ops = {...}
    local cb = ops[#ops]
    table.remove(ops,#ops)
    CreateThread(function()
        Scaleforms.init.DrawScaleformMoviePosition(scaleformName,table.unpack(ops))
        Scaleforms.init.ReleaseTimer[scaleformName] = GetGameTimer() + duration
        
        Threads.CreateLoopOnce("ScaleformDuration"..scaleformName,333,function()
            if GetGameTimer() >= Scaleforms.init.ReleaseTimer[scaleformName] then 
                Scaleforms.init.KillScaleformMovie(scaleformName);
                if type(cb) == 'function' then 
                    cb()
                end 
                
                Threads.KillActionOfLoop("ScaleformDuration"..scaleformName,333);
            end 
        end)
    end)
end )


exports('DrawScaleformMoviePosition2Duration', function (scaleformName,duration,...)
    local ops = {...}
    local cb = ops[#ops]
    
    table.remove(ops,#ops)
    CreateThread(function()
        Scaleforms.init.DrawScaleformMoviePosition2(scaleformName,table.unpack(ops))
        Scaleforms.init.ReleaseTimer[scaleformName] = GetGameTimer() + duration
        
        Threads.CreateLoopOnce("ScaleformDuration"..scaleformName,333,function()
            if GetGameTimer() >= Scaleforms.init.ReleaseTimer[scaleformName] then 
                Scaleforms.init.KillScaleformMovie(scaleformName);
                if type(cb) == 'function' then 
                    cb()
                end 
                
                Threads.KillActionOfLoop("ScaleformDuration"..scaleformName,333);
            end 
        end)
    end)
end )



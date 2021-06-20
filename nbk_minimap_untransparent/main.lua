local myui_width = 191 - 10
local myui_height = 136 - 10

local Data = {0.06,0.0,1.0,1.25} 

local Grun,Gsend,Gstop = nil,nil,nil 
local nowscale = Data[3]
local hud = nil 

CreateThread(function()
while not IsMinimapRendering() do 
        Wait(5)
    end 
    CreateThread(function()
        while not Grun do 
            Scaleforms.CallScaleformMovie('nbk_minimap_noso_custom',function(run,send,stop,handle)
                Grun,Gsend,Gstop = run,send,stop
                while not hud do  
                    TriggerEvent('nbk_circle:RequestHudDimensionsFromMyUI',myui_width,myui_height,function(obj)
                    hud = obj
                    end,Data[1],Data[2],false,nowscale)
                    Wait(1000)
                end 
                local isBig  = IsBigmapActive()
                local isRender  = IsMinimapRendering()
                updateMinimap(isBig,isRender)
            end)
            Wait(1000)
        end 
        RegisterNetEvent("nbk_circle:OnMinimapRefresh")
        AddEventHandler('nbk_circle:OnMinimapRefresh', function(isBig,isRender)
            
            updateMinimap(isBig,isRender)
        end)

    end)




    function updateMinimap(isBig,isRender)
        if Grun and Gsend and Gstop then 
            local isBig  = IsBigmapActive()
            local isRender  = IsMinimapRendering()
            if isBig or not isRender then 
                Grun("SET_RADAR_DISPLAY")
                Gsend(false)
                Gstop()
                Scaleforms.EndScaleformMovie('nbk_minimap_untransparent')
            else 
                Grun("SET_RADAR_DISPLAY")
                Gsend(true)
                Gstop()
                Scaleforms.DrawScaleformMovie('nbk_minimap_untransparent',hud.x,hud.y,hud.width,hud.height, 255, 255, 255, 255,0)
            end 
        end 
    end 


end)

--[=[
CreateThread(function()
    SetBigmapActive(
	1 --[[ boolean ]], 
	1 --[[ boolean ]]
)
Wait(3000)
SetBigmapActive(
	false --[[ boolean ]], 
	1 --[[ boolean ]]
)
Wait(3000)
SetBigmapActive(
	false --[[ boolean ]], 
	false --[[ boolean ]]
)
Wait(3000)
DisplayRadar(false)
Wait(3000)
DisplayRadar(true)
end)
--]=]

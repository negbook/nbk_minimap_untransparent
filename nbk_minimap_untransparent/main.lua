local myui_width = 191 - 10
local myui_height = 136 - 10

local Grun,Gsend,Gstop = nil,nil,nil 
local hud = nil 
CreateThread(function()
    Scaleforms.CallScaleformMovie('nbk_minimap_untransparent',function(run,send,stop,handle)
        Grun,Gsend,Gstop = run,send,stop
        TriggerEvent('nbk_circle:RequestHudDimensionsFromMyUI',myui_width,myui_height,function(obj)
            hud = obj
            local isBig  = IsBigmapActive()
            local isRender  = IsMinimapRendering()
            updateMinimap(isBig,isRender)
        end,0.26,-0.3,false)
    end)
end)

RegisterNetEvent("nbk_circle:OnMinimapRefresh")
AddEventHandler('nbk_circle:OnMinimapRefresh', function(isBig,isRender)
    TriggerEvent('nbk_circle:RequestHudDimensionsFromMyUI',myui_width,myui_height,function(obj)
            hud = obj
            updateMinimap(isBig,isRender)
    end,0.26,-0.3,false)
end)



function updateMinimap(isBig,isRender)
    if Grun and Gsend and Gstop then 
        if isBig or not isRender then 
            Scaleforms.EndScaleformMovie('nbk_minimap_untransparent')
        else 
            Scaleforms.DrawScaleformMovie('nbk_minimap_untransparent',hud.x,hud.y,hud.width,hud.height, 255, 255, 255, 255,0)
            
        end 
    end 
end 


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

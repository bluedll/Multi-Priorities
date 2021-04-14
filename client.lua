-------------------------
--- Badger-Priorities2 ---
-------------------------

local _AOP = nil

RegisterNetEvent('PriorityAOP')
AddEventHandler('PriorityAOP', function(AOP)
	_AOP = AOP
end)

local statewide = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5500)
            if string.find(_AOP, 'Blaine County') or string.find(_AOP, 'blaine county') or string.find(_AOP, 'BC') or string.find(_AOP, 'Blaine-County') or string.find(_AOP, 'Sandy Shores') or string.find(_AOP, 'sandy shores') or string.find(_AOP, 'Paleto Bay') or string.find(_AOP, 'paleto bay') or string.find(_AOP, 'Grapeseed') or string.find(_AOP, 'grapeseed') then
				ExecuteCommand("start PrioritiesBC")
				ExecuteCommand("stop PrioritiesLS")
			elseif string.find(_AOP, 'StateWide') then
				ExecuteCommand("start PrioritiesBC")
				ExecuteCommand("start PrioritiesLS") 
			elseif string.find(_AOP, 'Los Santos') or string.find(_AOP, 'South LS') or string.find(_AOP, 'North LS') then
				ExecuteCommand("start PrioritiesLS")
				ExecuteCommand("stop PrioritiesBC")
            end
    end
end)

function Draw2DText(x, y, text, scale)
    -- Draw text on screen
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextJustification(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
drawText = Config.Options.CooldownDisplay2:gsub("{MINS}", "0");
RegisterNetEvent('Badger-Priorities2:DrawText')
AddEventHandler('Badger-Priorities2:DrawText', function(text)
	drawText = text;
end)
drawFast = false;
RegisterNetEvent('Badger-Priorities2:TriggerTrue')
AddEventHandler('Badger-Priorities2:TriggerTrue', function()
	drawFast = true 
end)
hideDisplays = false;
RegisterNetEvent('Badger-Priorities2:HideDisplay')
AddEventHandler('Badger-Priorities2:HideDisplay', function()
	hideDisplays = not hideDisplays;
end)
displayCooldown = 0;
Citizen.CreateThread(function()
	while true do 
		Wait(0);
		local x = Config.DisplayLocation.x;
		local y = Config.DisplayLocation.y;
		if not hideDisplays then 
			if #drawText > 1 then 
				Draw2DText(x, y, drawText, 0.5);
			end 
		end 
		if drawFast then 
			Draw2DText(.5, .5, Config.Options.TooFastDisplay2, 1.0)
		end
		if Config.Options.EnableSpeedMessage2 then 
			local ped = GetPlayerPed(-1);
			local veh = GetVehiclePedIsIn(ped, 0);
			if veh ~= nil then 
				-- They are in a vehicle 
				if GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 then 
					-- It's a car 
					local speed = GetEntitySpeed(veh) * 2.236936;
					if speed >= 80 then 
						-- Too fast if we are on cooldown
						if displayCooldown <= 2000 then 
							TriggerServerEvent('Badger-Priorities2:TriggerCheck')
						else 
							drawFast = false;
						end
						displayCooldown = displayCooldown + 1;
						if displayCooldown == (1000 * 60) then 
							displayCooldown = 0;
						end
					else 
						drawFast = false;
						displayCooldown = 0;
					end
				end
			end
		end
	end
end)
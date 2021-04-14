-------------------------
--- Badger-Priorities2 ---
-------------------------

function msg(src, text)
  -- Send message 
  TriggerClientEvent('chatMessage', src, Config.prefix .. text);
end

RegisterNetEvent('Badger-Priorities2:TriggerCheck')
AddEventHandler('Badger-Priorities2:TriggerCheck', function()
  local src = source;
  if inProgess or onHold or (currentCooldownTime > 0) then 
    TriggerClientEvent('Badger-Priorities2:TriggerTrue', src)
  end
end)

RegisterCommand("resetpcdbc", function(source, args, rawCommand)
  -- /resetpcd
  local src = source;
  if IsPlayerAceAllowed(src, "Badger-Priorities2.ResetPCD") or IsPlayerAceAllowed(src, "Badger-Priorities2.Commands") or src <= 0 then
    onHold = false;
    inProgress = false;
	resetPCD = true;
    currentCooldownTime = 0;
    TriggerClientEvent('Badger-Priorities2:DrawText', -1, Config.Options.resetDisplay2:gsub("{MINS}", currentCooldownTime))
	if Config.Options.EnablePCDMessage2 then -- Reset PCD Message Toggle
		msg(-1, Config.Messages.resetMessage) 
    elseif src <= 0 then 
      print(Config.Messages.resetMessage)
    end
  end
end)
RegisterCommand("inprogressbc", function(source, args, rawCommand)
  -- /inprogress 
  local src = source;
  if IsPlayerAceAllowed(src, "Badger-Priorities2.InProgress") or IsPlayerAceAllowed(src, "Badger-Priorities2.Commands") or src <= 0 then
    onHold = false;
    inProgress = true;
	resetPCD = false;
    currentCooldownTime = 0;
    --msg(src, 'There is a priority in progress...');
    TriggerClientEvent('Badger-Priorities2:DrawText', -1, Config.Options.InProgressDisplay2:gsub("{MINS}", currentCooldownTime))
	if Config.Options.EnableProgressMessage2 then -- inProgress Message Toggle
		msg(-1, Config.Messages.InProgressMessage) 
    elseif src <= 0 then 
      print(Config.Messages.InProgressMessage)
    end
  end
end)
RegisterCommand("onholdbc", function(source, args, rawCommand)
  -- /onhold 
  local src = source;
  if IsPlayerAceAllowed(src, "Badger-Priorities2.OnHold") or IsPlayerAceAllowed(src, "Badger-Priorities2.Commands") or src <= 0 then
    inProgress = false;
    onHold = true;
	resetPCD = false;	
    currentCooldownTime = 0;
    --msg(src, 'The priorities have been set on hold...');
    TriggerClientEvent('Badger-Priorities2:DrawText', -1, Config.Options.OnHoldDisplay2:gsub("{MINS}", currentCooldownTime))
	if Config.Options.EnableHoldMessage2 then -- On Hold Message Toggle
	    msg(-1, Config.Messages.OnHoldMessage)
    elseif src <= 0 then 
      print(Config.Messages.OnHoldMessage)
    end
  end
end)
RegisterCommand("cooldownbc", function(source, args, rawCommand)
  -- /cooldown <time>
  local src = source;
  if IsPlayerAceAllowed(src, "Badger-Priorities2.Cooldown") or IsPlayerAceAllowed(src, "Badger-Priorities2.Commands") or src <= 0 then 
    if #args > 0 then 
      -- Check if number 
      if tonumber(args[1]) ~= nil then 
        local coold = tonumber(args[1]);
        currentCooldownTime = coold;
        inProgress = false;
        onHold = false;
		resetPCD = false;
        --msg(src, 'The cooldown has been set to ^7' .. args[1] .. ' ^3minutes...');
        local display = Config.Options.CooldownDisplay2:gsub("{MINS}", currentCooldownTime);
        TriggerClientEvent('Badger-Priorities2:DrawText', -1, display)
		if Config.Options.EnableCooldownMessage2 then -- Cooldown Message Toggle
			msg(-1, Config.Messages.CooldownMessage:gsub("{MINS}", args[1]))
		end
      else 
        -- Not a number 
        msg(src, '^1ERROR: That is not a valid number');
      end
    else 
      -- You need an argument length over 0
      msg(src, '^1ERROR: The command usage is /cooldown <time>');
    end
  end 
end)

currentCooldownTime = 0;
onHold = false;
inProgress = false 
resetPCD = false

Citizen.CreateThread(function()
  while true do 
    Wait((1000 * 5));
    if not onHold and not inProgress and not resetPCD then 
      if Config.Options.AlwaysDisplay2 then 
        local display = Config.Options.CooldownDisplay2:gsub("{MINS}", currentCooldownTime);
        TriggerClientEvent('Badger-Priorities2:DrawText', -1, display);
      else
        if currentCooldownTime <= 0 then 
          local display = Config.Options.CooldownDisplay2:gsub("{MINS}", currentCooldownTime);
          TriggerClientEvent('Badger-Priorities2:DrawText', -1, "");
        else 
          local display = Config.Options.CooldownDisplay2:gsub("{MINS}", currentCooldownTime);
          TriggerClientEvent('Badger-Priorities2:DrawText', -1, display);
        end
      end
    end 
    if onHold and not inProgress and not resetPCD then  
      -- Print on screen, the priorities are on hold 
      TriggerClientEvent('Badger-Priorities2:DrawText', -1, Config.Options.OnHoldDisplay2:gsub("{MINS}", currentCooldownTime))
    end 
    if inProgress then 
      TriggerClientEvent('Badger-Priorities2:DrawText', -1, Config.Options.InProgressDisplay2:gsub("{MINS}", currentCooldownTime))
	end
	if resetPCD then
	  TriggerClientEvent('Badger-Priorities2:DrawText', -1, Config.Options.resetDisplay2:gsub("{MINS}", currentCooldownTime))
    end 
  end
end)

Citizen.CreateThread(function()
  while true do 
    Wait((1000 * 60));
    -- Every 60 seconds 
    if not onHold and not inProgress and not resetPCD then 
      -- Print on screen, the cooldown time 
      if Config.Options.AlwaysDisplay2 then 
        local display = Config.Options.CooldownDisplay2:gsub("{MINS}", currentCooldownTime);
        TriggerClientEvent('Badger-Priorities2:DrawText', -1, display);
      else
        if currentCooldownTime <= 0 then 
          local display = Config.Options.CooldownDisplay2:gsub("{MINS}", currentCooldownTime);
          TriggerClientEvent('Badger-Priorities2:DrawText', -1, "");
        else 
          local display = Config.Options.CooldownDisplay2:gsub("{MINS}", currentCooldownTime);
          TriggerClientEvent('Badger-Priorities2:DrawText', -1, display);
        end
      end
      if currentCooldownTime > 0 then 
        currentCooldownTime = currentCooldownTime - 1;
      end
    end 
  end
end)
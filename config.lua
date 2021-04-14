Config = {
	prefix = "^7[^1Crimson^7] ^7",
	Options = {
		EnableSpeedMessage2 = true,
		EnablePCDMessage2 = true,
		EnableHoldMessage2 = true,
		EnableProgressMessage2 = true,
		EnableCooldownMessage2 = true,
		AlwaysDisplay2 = true, -- Always display the priority cooldown text even with 0 mins left?
		CooldownDisplay2 = "~w~Priority Cooldown ~g~BC~w~: ~r~{MINS} ~w~mins",
		InProgressDisplay2 = "~w~Priority Cooldown ~g~BC~w~: ~g~Priority in Progress",
		OnHoldDisplay2 = "~w~Priority Cooldown ~g~BC~w~: ~b~Priorities are on Hold",
		-- TooFastDisplay triggers when a car is going over 80 MPH and priorities are in progress, on hold, or a cooldown is active 
		TooFastDisplay2 = "~r~NOTICE: ~b~You cannot run from police currently. You are risking staff punishment!",
		resetDisplay2 = "~r~Cooldown: ~b~None"
	},
	Messages = {
		CooldownMessage = '^7A priority was just conducted inside ^2Blaine County^7... ^2The cooldown has been activated. ' -- You can also use {MINS} parameter here
		.. '^1You cannot run from police or cause any priorities (violent RP) until the cooldown has concluded!',
		InProgressMessage = '^7There is a priority in progress inside ^2Blaine County^7... ^1You cannot run from police or cause any priorities (violent RP) until priorities are off hold!',
		OnHoldMessage = 'Priorities are now on hold inside ^2Blaine County^7... ^1You cannot run from police or cause any priorities (violent RP) until priorities are off hold!',
		resetMessage = 'Priorities Have Been Reset inside ^2Blaine County^7!'
	}, 
	DisplayLocation = {
		x = .0845,
		y = .77
	}
}
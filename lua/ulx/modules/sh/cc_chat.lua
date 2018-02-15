-------------------------------------
--  This file holds chat commands  --
-------------------------------------

ulx_tsay_color_table = { "black", "white", "red", "blue", "green", "orange", "purple", "pink", "gray", "yellow" }

function ulx.tsaycolor( calling_ply, message, color )
	
		local pink = Color( 255, 0, 97 )
		
		local white = Color( 255, 255, 255 )
		
		local black = Color( 0, 0, 0 )
		
		local red = Color( 255, 0, 0 )
		
		local blue = Color( 0, 0, 255 )
		
		local green = Color( 0, 255, 0 )
		
		local orange = Color( 255, 127, 0 )
		
		local purple = Color( 51, 0, 102 )
		
		local gray = Color( 96, 96, 96 )
		
		local grey = Color( 96, 96, 96 )
		
		local maroon = Color( 128, 0, 0 )
		
		local yellow = Color( 255, 255, 0 )

	
	if color == "pink" then
	
		ULib.tsayColor( nil, false, pink, message )
	
	elseif color == "white" then
	
		ULib.tsayColor( nil, false, white, message )

	elseif color == "black" then
	
		ULib.tsayColor( nil, false, black, message )
	
	elseif color == "red" then
	
		ULib.tsayColor( nil, false, red, message )

	elseif color == "blue" then
	
		ULib.tsayColor( nil, false, blue, message )
	
	elseif color == "green" then
	
		ULib.tsayColor( nil, false, green, message )

	elseif color == "orange" then
	
		ULib.tsayColor( nil, false, orange, message )
	
	elseif color == "purple" then
	
		ULib.tsayColor( nil, false, purple, message )

	elseif color == "gray" then
	
		ULib.tsayColor( nil, false, gray, message )
	
	elseif color == "grey" then
	
		ULib.tsayColor( nil, false, grey, message )

	elseif color == "maroon" then
	
		ULib.tsayColor( nil, false, maroon, message )
	
	elseif color == "yellow" then
	
		ULib.tsayColor( nil, false, yellow, message )	

	elseif color == "default" then
	
		ULib.tsay( nil, message )

	end

	if util.tobool( GetConVarNumber( "ulx_logChat" ) ) then
	
		ulx.logString( string.format( "(tsay from %s) %s", calling_ply:IsValid() and calling_ply:Nick() or "Console", message ) )
		
	end
	
end
local tsaycolor = ulx.command( "Chat", "ulx tsaycolor", ulx.tsaycolor, "!tsaycolor", true, true )
tsaycolor:addParam{ type=ULib.cmds.StringArg, hint="message" }
tsaycolor:addParam{ type=ULib.cmds.StringArg, hint="color", completes=ulx_tsay_color_table, ULib.cmds.restrictToCompletes } -- only allows values in that table
tsaycolor:defaultAccess( ULib.ACCESS_SUPERADMIN )
tsaycolor:help( "Send a message to everyone in the chat box with color." )

function ulx.lowercase( calling_ply, target_ply, should_lower ) 

	if not should_lower then -- If it's false
		
		target_ply:RemovePData( "lower_case" )
		ulx.fancyLogAdmin( calling_ply, "#A removed force lower-case on #T", target_ply )

	else

		target_ply:SetPData( "lower_case", "true" )
		ulx.fancyLogAdmin( calling_ply, "#A forced lower-case on #T", target_ply )

	end

end
local lower = ulx.command( "Chat", "ulx lower", ulx.lowercase, "!lower" )
lower:addParam{ type=ULib.cmds.PlayerArg }
lower:addParam{ type=ULib.cmds.BoolArg, invisible=true }
lower:defaultAccess( ULib.ACCESS_SUPERADMIN )
lower:help( "Forces all text sent to be set to lower-case." )
lower:setOpposite( "ulx unlower", { _, _, false }, "!unlower" )

if SERVER then
	
	hook.Add( "PlayerSay", "To Lower Case", function( ply, text, bTeam )

		if ply:GetPData( "lower_case" ) == "true" then 

			text = string.lower( text )

			return text

		end
		
	end )

end

notification_types_table = { "generic", "error", "undo", "hint", "cleanup", "progress" }

function ulx.notifications( calling_ply, target_plys, text, ntype, duration )

	if ntype == "generic" then
	
		for k,v in pairs( target_plys ) do
		
			v:SendLua("notification.AddLegacy(\"" .. text .. "\", NOTIFY_GENERIC, " .. duration .. ")")
			
			v:SendLua([[surface.PlaySound("buttons/button15.wav")]])
			
			ULib.console( v, text )
			
		end
		
	elseif ntype == "error" then
	
		for k,v in pairs( target_plys ) do
		
			v:SendLua("notification.AddLegacy(\"" .. text .. "\", NOTIFY_ERROR, " .. duration .. ")")
			
			v:SendLua([[surface.PlaySound("buttons/button15.wav")]])
			
			ULib.console( v, text )
			
		end
		
	elseif ntype == "undo" then
	
		for k,v in pairs( target_plys ) do
		
			v:SendLua("notification.AddLegacy(\"" .. text .. "\", NOTIFY_UNDO, " .. duration .. ")")
			
			v:SendLua([[surface.PlaySound("buttons/button15.wav")]])
			
			ULib.console( v, text )
			
		end
		
	elseif ntype == "hint" then
	
		for k,v in pairs( target_plys ) do
		
			v:SendLua("notification.AddLegacy(\"" .. text .. "\", NOTIFY_HINT, " .. duration .. ")")
			
			v:SendLua([[surface.PlaySound("buttons/button15.wav")]])
			
			ULib.console( v, text )
			
		end
		
	elseif ntype == "cleanup" then
	
		for k,v in pairs( target_plys ) do
		
			v:SendLua("notification.AddLegacy(\"" .. text .. "\", NOTIFY_CLEANUP, " .. duration .. ")")
			
			v:SendLua([[surface.PlaySound("buttons/button15.wav")]])
			
			ULib.console( v, text )
			
		end
		
	elseif ntype == "progress" then	
		
		for k,v in pairs( target_plys ) do
		
			local x = math.random() --can't have the same process ID for different notifications
			
			v:SendLua("notification.AddProgress(" .. x .. ",\"" .. text .. "\")" )
			
			v:SendLua([[surface.PlaySound("buttons/button15.wav")]])
			
			timer.Simple( duration, function()
			
				v:SendLua("notification.Kill(" .. x .. ")")
				
			end )
			
		end
		
	end
	
end
local notifications = ulx.command( "Chat", "ulx notifications", ulx.notifications, "!notifications" )
notifications:addParam{ type=ULib.cmds.PlayersArg }
notifications:addParam{ type=ULib.cmds.StringArg, hint="text" }
notifications:addParam{ type=ULib.cmds.StringArg, hint="type", completes=notification_types_table, ULib.cmds.restrictToCompletes }
notifications:addParam{ type=ULib.cmds.NumArg, default=5, min=1, max=120, hint="duration", ULib.cmds.optional }
notifications:defaultAccess( ULib.ACCESS_SUPERADMIN )
notifications:help( "Send a sandbox-type notification to players." )

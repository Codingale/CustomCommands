
local allDisconnected = {}

local i = 1
local function plyDiscoBan( ply )

	allDisconnected[i] = { tostring( ply:SteamID() ), tostring( ply:Nick() ), tostring( os.date( "%H:%M" ) ) }
	
	i = i + 1

end
hook.Add( "PlayerDisconnected", "plyDiscoBan", plyDiscoBan )

local function printIDTable()
	PrintTable( allDisconnected )
end
concommand.Add( "print_disc_steamids", printIDTable )


local function DisconnectsCommand( ply, c, a )

	if ply:IsValid() then
		for k,v in pairs( allDisconnected ) do
			umsg.Start( "disconnects_u", ply )
			umsg.String( v[2] )
			umsg.String( v[1] )
			umsg.String( v[3] )
			umsg.End()
		end
	end

end

concommand.Add( "discs_request", DisconnectsCommand )

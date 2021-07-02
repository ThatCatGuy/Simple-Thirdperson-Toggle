local offset = -85
local convar = CreateClientConVar("cat_thirdperson", 0) 

hook.Add('ShouldDrawLocalPlayer', 'ThirdPersonDrawPlayer', function()
	if convar:GetBool() then
    	return ((not LocalPlayer():InVehicle()))
	end
end)

hook.Add('CalcView', 'ThirdPersonCalcView', function (pl, origin, ang, fov)
	if convar:GetBool() and not pl:InVehicle() then
		return {
			origin = util.TraceLine({
				start = origin,
				endpos = origin + (ang:Forward() * offset),
				filter = pl,
			}).HitPos + Vector(0,0,7.5),
			angles = ang,
			fov = fov
		}
	end
end)

hook.Add("ShowHelp", "Cat_Thirdperson_Keypress", function()
	convar:SetBool(!convar:GetBool())
end)
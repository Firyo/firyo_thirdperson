local passiveWeapons = {"fas2_ifak", "re_hands", "weapon_fists", "weapon_physgun", "gmod_tool", "gmod_camera", "weapon_simrepair", "lbdn_radio_weapon", "weapon_physcannon", "stunstick", "keys", "doi_atow_binocularsde", "doi_atow_binocularsus", "doi_atow_binocularsus", "doi_atow_bayonetde", "doi_atow_bayonetcw", "doi_atow_bayonetus", "doi_atow_knifeus", "doi_atow_etoolcw", "doi_atow_etoolde", "doi_atow_etoolus"}
local third = false

local function ThirdPerson(bol)
    if not(LocalPlayer():GetActiveWeapon():IsValid()) then return end
    if not (table.HasValue(passiveWeapons, LocalPlayer():GetActiveWeapon():GetClass())) then return end

    if (bol == nil) then
        if (third == false) then
            third = true

            hook.Add("CalcView", "Firyo:ThirdPerson", function(ply, pos, angles, fov)
                if (IsValid(ply) and not (ply:InVehicle())) then
                    local trace = util.TraceHull({
                        start = pos,
                        endpos = pos - angles:Forward() * 30,
                        filter = {ply:GetActiveWeapon(), ply},
                        mins = Vector(-4, -4, -4),
                        maxs = Vector(4, 4, 4)
                    })

                    if (trace.Hit) then
                        pos = trace.HitPos
                    else
                        pos = pos - angles:Forward() * 30 - angles:Right() * -25
                    end

                    return {
                        origin = pos,
                        angles = angles,
                        drawviewer = true
                    }
                end
            end)
        else
            third = false
            hook.Remove("CalcView", "Firyo:ThirdPerson")
        end
    else
        hook.Remove("CalcView", "Firyo:ThirdPerson")
    end
end

list.Set("DesktopWindows", "ThirdPerson", {
    title = "Troisième Personne",
    icon = "icon32/zoom_extend.png",
    init = function()
        ThirdPerson()
    end
})

net.Receive("Firyo:ThirdPerson:Toggle", function(len)
    ThirdPerson()
end)

hook.Add("PlayerSwitchWeapon", "Firyo:ThirdPersonSwitchWPN", function(ply, old, new)
    if not (table.HasValue(passiveWeapons, new:GetClass())) then
        ThirdPerson(false)
    end
end)

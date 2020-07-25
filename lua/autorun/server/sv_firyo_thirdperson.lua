util.AddNetworkString("Firyo:ThirdPerson:Toggle")

hook.Add("ShowHelp", "Firyo:ThirdPerson:F1", function(ply)
    net.Start("Firyo:ThirdPerson:Toggle")
    net.WriteInt(1, 4)
    net.Send(ply)
end)
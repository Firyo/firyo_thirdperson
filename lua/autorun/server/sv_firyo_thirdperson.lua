util.AddNetworkString("Firyo:ThirdPerson:Toggle")

hook.Add("ShowHelp", "Firyo:ThirdPerson:F1", function(ply)
    net.Start("Firyo:ThirdPerson:Toggle")
    net.Send(ply)
end)

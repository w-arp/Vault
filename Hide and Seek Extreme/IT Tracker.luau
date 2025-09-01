for _, plr in ipairs(game.Players:GetPlayers()) do
    local IT = plr:FindFirstChild("PlayerData") and plr.PlayerData:FindFirstChild("It")
    if IT and IT:IsA("BoolValue") then
        if IT.Value then
            print(('<font color="rgb(255,0,0)" face="Code">%s is the IT</font>'):format(plr.Name))
        else
            print(('<font color="rgb(0,255,0)" face="Code">%s: false</font>'):format(plr.Name))
        end
    else
        print(plr.Name .. ": No It value found")
    end
end

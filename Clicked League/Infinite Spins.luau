print("@warp")

game:GetService("RunService").RenderStepped:Connect(function()
    for i=1,50 do game.ReplicatedStorage.Events.SpinsAdd:FireServer(game.Players.LocalPlayer) end
end)

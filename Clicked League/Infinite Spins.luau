print("@warp")

getgenv().iterations=50
game:GetService("RunService").RenderStepped:Connect(function()
    for i=1,getgenv().iterations do
        game.ReplicatedStorage.Events.SpinsAdd:FireServer(game.Players.LocalPlayer)
    end
end)

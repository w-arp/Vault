game:GetService("RunService").RenderStepped:Connect(function()
    game.ReplicatedStorage.Events.Tap:FireServer("Click")
end)

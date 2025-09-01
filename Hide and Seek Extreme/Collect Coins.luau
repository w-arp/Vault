for _, obj in ipairs(workspace.GameObjects:GetDescendants()) do
    if obj.Name == "Credit" and obj:FindFirstChild("TouchInterest") then
        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), obj, 0)
    end
end

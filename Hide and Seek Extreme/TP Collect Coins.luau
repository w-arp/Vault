for _, obj in ipairs(workspace.GameObjects:GetDescendants()) do
    if obj.Name == "Credit" and obj:FindFirstChild("TouchInterest") then
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = obj.CFrame
        task.wait(0.2)
    end
end

local WARP = {}

WARP["1"] = Instance.new("ScreenGui")
WARP["1"].Name = "PingGui"
WARP["1"].ResetOnSpawn = false
WARP["1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling

WARP["2"] = Instance.new("Frame", WARP["1"])
WARP["2"].BorderSizePixel = 0
WARP["2"].BackgroundColor3 = Color3.fromRGB(19, 19, 22)
WARP["2"].Size = UDim2.new(0, 102, 0, 44)
WARP["2"].Position = UDim2.new(0, 266, 0, -46)
WARP["2"].BackgroundTransparency = 0.08

WARP["3"] = Instance.new("UICorner", WARP["2"])
WARP["3"].CornerRadius = UDim.new(1, 0)

WARP["4"] = Instance.new("TextLabel", WARP["2"])
WARP["4"].BorderSizePixel = 0
WARP["4"].TextSize = 18
WARP["4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WARP["4"].FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
WARP["4"].TextColor3 = Color3.fromRGB(255, 255, 255)
WARP["4"].BackgroundTransparency = 1
WARP["4"].Size = UDim2.new(0, 102, 0, 48)
WARP["4"].Text = "PING: XX"
WARP["4"].Name = "Ping"
WARP["4"].Position = UDim2.new(0, 0, 0, -2)

WARP["W-ARP1"] = function()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Stats = game:GetService("Stats")
    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")

    -- parent gui when function runs
    WARP["1"].Parent = PlayerGui

    local lbl = WARP["4"]
    RunService.RenderStepped:Connect(function()
        if lbl and lbl.Parent then
            local pingVal = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            lbl.Text = "PING: " .. math.floor(pingVal) .. " ms"
        end
    end)
end

task.spawn(WARP["W-ARP1"])

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    task.spawn(WARP["W-ARP1"])
end)

return WARP["1"], require

-- js stripped off the fps counter source and did some adjustments 

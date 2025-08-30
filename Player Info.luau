local WARP = {};

WARP["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
WARP["1"].Name = "PlayerInfoGUI";
WARP["1"].ResetOnSpawn = false;
WARP["1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

WARP["2"] = Instance.new("Frame", WARP["1"]);
WARP["2"].Size = UDim2.new(0.98, 0, 0.08, 0);
WARP["2"].Position = UDim2.new(0.01, 0, 0.01, 0);
WARP["2"].BackgroundTransparency = 1;

WARP["3"] = Instance.new("UIScale", WARP["2"]);
WARP["3"].Scale = 1;

WARP["4"] = Instance.new("TextLabel", WARP["2"]);
WARP["4"].Size = UDim2.new(1,0,1,0);
WARP["4"].Position = UDim2.new(0,0,0,0);
WARP["4"].BackgroundTransparency = 1;
WARP["4"].TextColor3 = Color3.fromRGB(255,255,255);
WARP["4"].Font = Enum.Font.Code;
WARP["4"].TextScaled = true;
WARP["4"].TextWrapped = true;
WARP["4"].TextXAlignment = Enum.TextXAlignment.Left;
WARP["4"].TextYAlignment = Enum.TextYAlignment.Top;
WARP["4"].ZIndex = 2

WARP["W-ARP1"] = function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Market = game:GetService("MarketplaceService")
    
    local plr, char, hum = Players.LocalPlayer, nil, nil
    local lbl = WARP["4"]

    local fps = 0
    RunService.RenderStepped:Connect(function(dt)
        fps = math.floor(1 / dt)
    end)

    local function w_re()
        if not char or not hum then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local uname, dname, hp, pos =
            plr.Name,
            plr.DisplayName,
            math.floor(hum.Health),
            hrp.Position

        local coords = string.format("X: %.0f Y: %.0f Z: %.0f", pos.X, pos.Y, pos.Z)
        local jid, gid, gname = game.JobId or "N/A", game.GameId or "N/A", "N/A"

        pcall(function()
            local info = Market:GetProductInfo(game.PlaceId)
            gname = info.Name or "N/A"
        end)

        local t = os.date("%I:%M %p")

        local out = string.format(
            "Username: %s | Display_Name: %s | Health: %d | Coordinates: %s | Job_ID: %s | Game ID: %s | Game_Name: %s | Time: %s | FPS: %d",
            uname, dname, hp, coords, jid, gid, gname, t, fps
        )

        lbl.Text = out
    end

    RunService.RenderStepped:Connect(w_re)

    local function oca(nc)
        char, hum = nc, nc:WaitForChild("Humanoid")
    end
    plr.CharacterAdded:Connect(oca)
    if plr.Character then
        oca(plr.Character)
    end
end
task.spawn(WARP["W-ARP1"])

return WARP["1"], require

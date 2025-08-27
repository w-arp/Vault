local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library/main/Library"))()
local plrs = game:GetService("Players")
local run = game:GetService("RunService")
local tween = game:GetService("TweenService")

local me = plrs.LocalPlayer
local dude = me.Character or me.CharacterAdded:Wait()
local root = dude:WaitForChild("HumanoidRootPart")
local clipboard = setclipboard or toclipboard or setrbxclipboard


local win = lib:AddWindow("Coords Thingy", {
    main_color = Color3.fromRGB(41, 74, 122),
    min_size = Vector2.new(500, 250),
    can_resize = false
})
local tab = win:AddTab("Stuff")
tab:Show()

local howShow = {
    ["Normal"] = function(p) return tostring(p) end,
    ["Roundy"] = function(p) return math.floor(p.X)..", "..math.floor(p.Y)..", "..math.floor(p.Z) end,
    ["2 Deci"] = function(p) return string.format("%.2f, %.2f, %.2f", p.X, p.Y, p.Z) end
}
local pickedShow = "Normal"
local pickedTp = "Set"

local formatDrop = tab:AddDropdown("Coords Look", function(txt) pickedShow = txt end)
formatDrop:Add("Normal")
formatDrop:Add("Roundy")
formatDrop:Add("2 Deci")

local tpDrop = tab:AddDropdown("TP Way", function(txt) pickedTp = txt end)
tpDrop:Add("Walk")
tpDrop:Add("Tween")
tpDrop:Add("Set")

local coordTxt = tab:AddLabel("You: "..me.Name.."\nCoords: "..howShow[pickedShow](root.Position))

run.RenderStepped:Connect(function()
    if dude and root then
        coordTxt.Text = "Me: "..me.Name.."\nCoords: "..howShow[pickedShow](root.Position)
    end
end)

tab:AddButton("Copy Coords", function()
    local t = howShow[pickedShow](root.Position)
    if setclipboard then
        setclipboard(t)
    elseif toclipboard then
        toclipboard(t)
    end
end)

local function makeTpScrpt(pos, kind)
    if kind == "Walk" then
        return "local p=game:GetService('Players').LocalPlayer local c=p.Character or p.CharacterAdded:Wait() local h=c:WaitForChild('Humanoid') h:MoveTo(Vector3.new("..pos.X..","..pos.Y..","..pos.Z.."))"
    elseif kind == "Tween" then
        return "local p=game:GetService('Players').LocalPlayer local t=game:GetService('TweenService') local c=p.Character or p.CharacterAdded:Wait() local r=c:WaitForChild('HumanoidRootPart') local g={CFrame=CFrame.new("..pos.X..","..pos.Y..","..pos.Z..")} local tw=t:Create(r,TweenInfo.new(2),g) tw:Play()"
    elseif kind == "Set" then
        return "local p=game:GetService('Players').LocalPlayer local c=p.Character or p.CharacterAdded:Wait() local r=c:WaitForChild('HumanoidRootPart') r.CFrame=CFrame.new("..pos.X..","..pos.Y..","..pos.Z..")"
    end
end

tab:AddButton("Save TP Scrpt", function()
    local pos = root.Position
    local txt = makeTpScrpt(pos, pickedTp)
    if writefile then
        writefile("TpScript.lua", txt)
        print("saved -> TpScript.lua")
    else
        warn("nah, cant save")
    end
end)

tab:AddButton("Copy TP Scrpt", function()
    local pos = root.Position
    local txt = makeTpScrpt(pos, pickedTp)
    if clipboard then
        clipboard(txt)
        print("copied in ur clipboard")
    else
        warn("cant copy")
    end
end)

-- this is so old, made it like almost a year ago js integrated it into a ui lib

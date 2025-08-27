local clonerefwrap = (type(cloneref) == "function" and cloneref) or function(x) return x end

local svcmt = {}
svcmt.__index = function(t, k)
    local svc = game:GetService(k)
    local safe = clonerefwrap(svc)
    rawset(t, k, safe)
    return safe
end

local svc = setmetatable({}, svcmt)
local players = svc.Players
local workspace = svc.Workspace
local localplayer = players.LocalPlayer

local function getplot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end

    for i = 1, 6 do
        local p = plots:FindFirstChild("Plot" .. i)
        if p and p:FindFirstChild("BaseFloor") then
            local gui = p.BaseFloor:FindFirstChild("BillboardGui")
            local label = gui and gui:FindFirstChild("Frame") and gui.Frame:FindFirstChild("TextLabel")
            if label and label.Text:find(localplayer.Name) then
                return p
            end
        end
    end
    return nil
end

local function firegens(plot)
    local gens = plot:FindFirstChild("Generators")
    if not gens then return end

    for _, obj in ipairs(gens:GetChildren()) do
        local prompt = (obj:IsA("ProximityPrompt") and obj) or obj:FindFirstChildWhichIsA("ProximityPrompt")
        if prompt then
            pcall(fireproximityprompt, prompt)
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        local cp = getplot()
        if cp then
            firegens(cp)
        end
    end
end)

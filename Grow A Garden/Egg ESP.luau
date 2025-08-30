local RS, CS, PLS, RUN, LP, CAM, hatch_fn, e_m, e_p, Lk, ESP, newLabel, init =
    game:GetService("ReplicatedStorage"),
    game:GetService("CollectionService"),
    game:GetService("Players"),
    game:GetService("RunService"),
    game:GetService("Players").LocalPlayer,
    workspace.CurrentCamera,
    (function()
        local fn = getupvalue(
            getupvalue(
                getconnections(game:GetService("ReplicatedStorage").GameEvents.PetEggService.OnClientEvent)[1].Function,
                1
            ),
            2
        )
        return fn
    end)(),
    nil, nil, {}, {}, nil, nil

e_m, e_p = getupvalue(hatch_fn, 1), getupvalue(hatch_fn, 2)

function Lk:uid(id)
    for _, m in ipairs(e_m) do
        if m:GetAttribute("OBJECT_UUID") == id then
            return m
        end
    end
    return nil
end

ESP = { c = {}, a = {} }

newLabel = function(txt)
    local bb = Instance.new("BillboardGui")
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.StudsOffset = Vector3.new(0, 3, 0)

    local tl = Instance.new("TextLabel")
    tl.Parent = bb
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.TextColor3 = Color3.new(1, 1, 1)
    tl.TextStrokeTransparency = 0
    tl.TextScaled = true
    tl.Font = Enum.Font.SourceSansBold
    tl.Text = txt

    return bb, tl
end

function ESP:Main()
    local selfRef = self

    local function add(m)
        if m:GetAttribute("OWNER") ~= LP.Name then return end
        local id = m:GetAttribute("OBJECT_UUID")
        local en = m:GetAttribute("EggName")
        local pn = e_p[id] or "unidentified"
        if not id or selfRef.c[id] then return end

        local bb = newLabel(string.format("%s | %s", en, pn))
        bb.Parent = m:FindFirstChild("PrimaryPart") or m
        selfRef.c[id], selfRef.a[id] = bb, m
    end

    local function rem(m)
        if m:GetAttribute("OWNER") ~= LP.Name then return end
        local id = m:GetAttribute("OBJECT_UUID")
        if selfRef.c[id] then
            selfRef.c[id]:Destroy()
            selfRef.c[id] = nil
        end
        selfRef.a[id] = nil
    end

    local function upd_lbl(id, pn)
        local m = Lk:uid(id)
        local gui = selfRef.c[id]
        if not (m and gui) then return end
        local tl = gui:FindFirstChildOfClass("TextLabel")
        if tl then
            tl.Text = string.format("%s | %s", m:GetAttribute("EggName"), pn or "unidentified")
        end
    end

    local function upd_all()
        for id, m in pairs(selfRef.a) do
            if not (m and m:IsDescendantOf(workspace)) then
                if selfRef.c[id] then
                    selfRef.c[id]:Destroy()
                    selfRef.c[id] = nil
                end
                selfRef.a[id] = nil
            end
        end
    end

    return { add = add, rem = rem, upd_lbl = upd_lbl, upd_all = upd_all }
end

local espMethods = ESP:Main()


--- init
init = function()
    for _, egg in ipairs(CS:GetTagged("PetEggServer")) do
        task.defer(function() espMethods.add(egg) end)
    end

    CS:GetInstanceAddedSignal("PetEggServer"):Connect(function(egg)
        espMethods.add(egg)
    end)

    CS:GetInstanceRemovedSignal("PetEggServer"):Connect(function(egg)
        espMethods.rem(egg)
    end)

    local gg = getconnections(RS.GameEvents.EggReadyToHatch_RE.OnClientEvent)[1].Function
    hookfunction(gg, newcclosure(function(id, pn)
        espMethods.upd_lbl(id, pn)
        return gg(id, pn)
    end))

    RUN.Heartbeat:Connect(function()
        espMethods.upd_all()
    end)
end

init()

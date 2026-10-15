-- ==================================================
-- PUMBA HUB | TAB | Farming (With Pet Scanner)
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Tab = Window:Tab({Name = "Farming", Icon = "sprout"})

-- ==================================================
-- STATE
-- ==================================================
local SelectedPet = nil
local DetectedEggs = {}
local EggCounter = 0
local Scanning = false
local PetButtons = {}

-- ==================================================
-- HELPER: Cari folder egg di game
-- ==================================================
local function FindEggFolder()
    -- Coba berbagai lokasi umum
    local paths = {
        {ReplicatedStorage, "ServerData", "ActiveEggs"},
        {ReplicatedStorage, "ServerData", "Eggs"},
        {ReplicatedStorage, "ActiveEggs"},
        {ReplicatedStorage, "Eggs"},
        {workspace, "ActiveEggs"},
        {workspace, "Eggs"},
        {workspace, "EggSpawns"},
    }

    for _, path in ipairs(paths) do
        local current = path[1]
        for i = 2, #path do
            if not current then break end
            current = current:FindFirstChild(path[i])
        end
        if current then
            return current
        end
    end

    -- Cari di plot player
    local plots = workspace:FindFirstChild("Plots")
    if plots then
        for _, plot in pairs(plots:GetChildren()) do
            local eggs = plot:FindFirstChild("Eggs") or plot:FindFirstChild("ActiveEggs")
            if eggs then return eggs end
        end
    end

    return nil
end

-- ==================================================
-- HELPER: Ambil info egg
-- ==================================================
local function GetEggInfo(egg)
    if not egg then return nil end

    local name = egg:GetAttribute("EggName") 
              or egg:GetAttribute("Egg")
              or egg:GetAttribute("PetName")
              or egg.Name

    local price = egg:GetAttribute("Price") 
               or egg:GetAttribute("Value")
               or egg:GetAttribute("Income")
               or egg:GetAttribute("PricePerSecond")
               or 0

    -- Coba cari dari children
    if price == 0 then
        for _, child in pairs(egg:GetChildren()) do
            if child:IsA("NumberValue") or child:IsA("IntValue") then
                local n = child.Name:lower()
                if n:find("price") or n:find("value") or n:find("income") then
                    price = child.Value
                    break
                end
            end
        end
    end

    -- Format harga
    local priceStr
    if price >= 1e12 then priceStr = string.format("$%.2fT/s", price / 1e12)
    elseif price >= 1e9 then priceStr = string.format("$%.2fB/s", price / 1e9)
    elseif price >= 1e6 then priceStr = string.format("$%.2fM/s", price / 1e6)
    elseif price >= 1e3 then priceStr = string.format("$%.2fK/s", price / 1e3)
    else priceStr = string.format("$%d/s", price) end

    return {
        Instance = egg,
        Name = name,
        Price = price,
        PriceStr = priceStr,
    }
end

-- ==================================================
-- SCAN EGGS
-- ==================================================
local function ScanEggs()
    local folder = FindEggFolder()
    if not folder then
        Window:Notify({
            Title = "Scan Gagal",
            Content = "Tidak menemukan folder egg",
            Duration = 3,
            Type = "Error"
        })
        return {}
    end

    local list = {}
    for _, egg in ipairs(folder:GetChildren()) do
        local info = GetEggInfo(egg)
        if info then
            table.insert(list, info)
        end
    end

    -- Sort by price descending
    table.sort(list, function(a, b) return a.Price > b.Price end)

    return list
end

-- ==================================================
-- HEADER
-- ==================================================
Tab:Section("Selected Pet")

local HeaderLabel = Tab:Label({
    Name = "SelectedPet",
    Text = "🐾 No Egg Selected | $0/s"
})

Tab:Toggle({
    Name = "Start Check Egg",
    Description = "Egg: 0",
    Default = false,
    Flag = "StartCheckEgg",
    Callback = function(state)
        Scanning = state
        if state then
            print("[Farming] Check Egg START")
            task.spawn(function()
                while Scanning do
                    DetectedEggs = ScanEggs()
                    EggCounter = #DetectedEggs
                    print("[Farming] Detected:", EggCounter, "eggs")
                    task.wait(5)
                end
            end)
        else
            print("[Farming] Check Egg STOP")
        end
    end
})

-- ==================================================
-- SCAN BUTTON (untuk refresh manual)
-- ==================================================
Tab:Button({
    Name = "Scan Eggs Sekarang",
    Description = "Scan ulang daftar egg di server",
    Icon = "refresh-cw",
    Style = "Primary",
    Callback = function()
        DetectedEggs = ScanEggs()
        EggCounter = #DetectedEggs

        if EggCounter == 0 then
            Window:Notify({
                Title = "Tidak Ada Egg",
                Content = "0 egg ditemukan di server",
                Duration = 3,
                Type = "Warning"
            })
            return
        end

        Window:Notify({
            Title = "Scan Selesai",
            Content = EggCounter .. " egg ditemukan",
            Duration = 3,
            Type = "Success"
        })

        -- Refresh list UI
        for _, btn in ipairs(PetButtons) do
            if btn and btn.Destroy then
                pcall(btn.Destroy, btn)
            end
        end
        PetButtons = {}

        -- Rebuild list
        for i, eggInfo in ipairs(DetectedEggs) do
            if i > 20 then break end  -- Limit 20 biar UI tidak berat

            local Btn = Tab:Button({
                Name = eggInfo.Name,
                Description = eggInfo.PriceStr,
                Icon = "egg",
                Callback = function()
                    SelectedPet = eggInfo
                    HeaderLabel:Set("🐾 " .. eggInfo.Name .. " | " .. eggInfo.PriceStr)
                    Window:Notify({
                        Title = "Selected",
                        Content = eggInfo.Name .. " | " .. eggInfo.PriceStr,
                        Duration = 3,
                        Type = "Success"
                    })
                    print("[Farming] Selected:", eggInfo.Name)
                end
            })
            table.insert(PetButtons, Btn)
        end
    end
})

-- ==================================================
-- AUTO FARM
-- ==================================================
Tab:Section("Auto Farm")

Tab:Toggle({
    Name = "Auto Farm Selected Egg",
    Description = "Auto farm egg yang sudah dipilih",
    Default = false,
    Flag = "AutoFarmSelected",
    Callback = function(state)
        if state and not SelectedPet then
            Window:Notify({
                Title = "Belum Pilih Egg",
                Content = "Klik 'Scan Eggs' dulu, lalu pilih egg",
                Duration = 3,
                Type = "Warning"
            })
            return false
        end

        if _G.YOKUDO_FarmingManager then
            if state then
                _G.YOKUDO_FarmingManager.Enable()
            else
                _G.YOKUDO_FarmingManager.Disable()
            end
        else
            Window:Notify({
                Title = "Error",
                Content = "FarmingManager tidak loaded",
                Duration = 3,
                Type = "Error"
            })
        end
    end
})

-- ==================================================
-- AUTO SCAN LOOP
-- ==================================================
task.spawn(function()
    while task.wait(1) do
        if Scanning then
            DetectedEggs = ScanEggs()
            EggCounter = #DetectedEggs
        end
    end
end)

print("✅ PUMBA Farming Tab (Pet Scanner) Loaded")

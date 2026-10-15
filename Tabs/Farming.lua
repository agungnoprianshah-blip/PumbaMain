-- ==================================================
-- PUMBA HUB | TAB | Farming
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local Tab = Window:Tab({Name = "Farming", Icon = "sprout"})

local AllRarities = {"Divine","Eternal","Secret","Mythic","Legendary","Epic","Rare","Uncommon","Common"}
local DefaultRarities = {"Divine","Eternal","Secret","Mythic","Legendary"}

Tab:Section("Select Egg Type")

Tab:Dropdown({
    Name = "Select Rarity to Farm",
    Description = "Pilih rarity yang mau di-farm",
    Options = AllRarities,
    Multi = true,
    Default = DefaultRarities,
    Flag = "FarmRarities",
    Callback = function(selected)
        if _G.YOKUDO_FarmingManager then
            _G.YOKUDO_FarmingManager.SetRarities(selected or {})
        end
    end
})

Tab:Section("Auto Farm")

Tab:Toggle({
    Name = "Auto AFK Farming Egg",
    Description = "Auto farm rarity yang dipilih",
    Default = false,
    Flag = "AutoFarm",
    Callback = function(state)
        if _G.YOKUDO_SpeedLock and not _G.YOKUDO_SpeedLock.IsUnlocked() then
            if _G.YOKUDO_SpeedLock.ShowMessage then
                _G.YOKUDO_SpeedLock.ShowMessage("🔒 Butuh Speed 1B dulu!\nKalau sudah 1B, exit game dan join lagi.", 5)
            end
            Window:Notify({Title = "Terkunci", Content = "Butuh Speed 1B untuk unlock", Duration = 3, Type = "Warning"})
            return
        end
        if not _G.YOKUDO_FarmingManager then warn("[Pumba] FarmingManager tidak loaded") return end
        if state then
            _G.YOKUDO_FarmingManager.Enable()
        else
            _G.YOKUDO_FarmingManager.Disable()
        end
    end
})

print("✅ PUMBA Farming Tab Loaded")

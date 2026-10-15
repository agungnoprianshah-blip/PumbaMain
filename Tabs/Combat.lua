-- ==================================================
-- PUMBA HUB | TAB | Combat
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local Tab = Window:Tab({Name = "Combat", Icon = "sword"})

Tab:Section("Combat")

Tab:Toggle({
    Name = "Auto Equip Bat",
    Description = "Otomatis equip bat terbaik",
    Default = false,
    Flag = "AutoEquipBat",
    Callback = function(state)
        if not _G.YOKUDO_AutoAttack then return end
        if state then
            _G.YOKUDO_AutoAttack.EnableAutoEquip()
        else
            _G.YOKUDO_AutoAttack.DisableAutoEquip()
        end
    end
})

Tab:Toggle({
    Name = "Auto Hit Player",
    Description = "Auto hit player dalam range 50 studs",
    Default = false,
    Flag = "AutoHitPlayer",
    Callback = function(state)
        if not _G.YOKUDO_AutoAttack then return end
        if state then
            _G.YOKUDO_AutoAttack.EnableAutoHit()
        else
            _G.YOKUDO_AutoAttack.DisableAutoHit()
        end
    end
})

print("✅ PUMBA Combat Tab Loaded")

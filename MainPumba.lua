-- ==================================================
-- YOKUDO HUB | PUMBA BRIDGE
-- ==================================================

local Pumba = _G.YOKUDO_Pumba

if not Pumba then
    warn("❌ Pumba tidak loaded! Cek PumbaUI.lua")
    return
end

local Window = Pumba:Window({
    Name = "YOKUDO HUB",
    LoadingTitle = "YOKUDO HUB",
    LoadingSubtitle = "Steal An Egg | Pumba Edition",
    Theme = "Pumba",
    Size = UDim2.fromOffset(640, 480),
    Keybind = "RightControl",
    LoadingDuration = 1.8,
    Icon = "rbxassetid://101352576986760",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "YokudoConfig",
        FileName = "Default",
        AutoSave = false,
    }
})

_G.YOKUDO_Window = Window
print("✅ Pumba Window created")

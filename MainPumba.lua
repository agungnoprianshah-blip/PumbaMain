-- ==================================================
-- PUMBA HUB | MAIN BRIDGE
-- ==================================================

local Pumba = _G.YOKUDO_Pumba

if not Pumba then
    warn("❌ Pumba tidak loaded! Cek PumbaUI.lua")
    return
end

local Window = Pumba:Window({
    Name = "PUMBA HUB",
    LoadingTitle = "PUMBA HUB",
    LoadingSubtitle = "Steal An Egg | Warthog Edition",
    Theme = "Pumba",
    Size = UDim2.fromOffset(640, 480),
    Keybind = "RightControl",
    LoadingDuration = 1.8,
    Icon = "rbxassetid://101352576986760",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PumbaConfig",
        FileName = "Default",
        AutoSave = false,
    }
})

_G.YOKUDO_Window = Window
print("✅ PUMBA HUB Window created")

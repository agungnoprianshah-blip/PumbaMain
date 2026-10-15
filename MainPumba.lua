-- ==================================================
-- PUMBA HUB | MAIN BRIDGE + HOME TAB
-- ==================================================
local Pumba = _G.YOKUDO_Pumba
if not Pumba then warn("❌ Pumba belum loaded!") return end

local Window = Pumba:Window({
    Name = "PUMBA HUB",
    Title = "PUMBA HUB",
    Subtitle = "Steal An Egg | Warthog Edition",
    Theme = "Pumba",
    Size = UDim2.fromOffset(720, 500),
    Keybind = "RightShift",
    LoadingDuration = 1.8,
    Icon = "rbxassetid://101352576986760",
    MaxNotifications = 5,
    KeepOnScreen = true,

    -- ⭐ HOME TAB (avatar + stats otomatis)
    Home = {
        Name = "Home",
        Icon = "house",
        SectionName = "Session Info",
        Welcome = "Welcome back, ",
        Stats = { "FPS", "Ping", "Executor", "Game", "Region", "Time", "Players", "Uptime" },
    },

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PumbaConfig",
        FileName = "Default",
        AutoSave = false,
    }
})

_G.YOKUDO_Window = Window
print("✅ PUMBA Window + Home created")

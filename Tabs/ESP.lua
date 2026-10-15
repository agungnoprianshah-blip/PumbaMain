-- ==================================================
-- PUMBA HUB | TAB | ESP
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local Tab = Window:Tab({Name = "ESP", Icon = "eye"})

Tab:Section("ESP Settings")

Tab:Toggle({
    Name = "ESP Name",
    Description = "Tampilkan nama player",
    Default = false,
    Flag = "ESPName",
    Callback = function(state)
        if not _G.YOKUDO_ESP then return end
        _G.YOKUDO_ESP.Settings.Name = state
        _G.YOKUDO_ESP.Refresh()
    end
})

Tab:Toggle({
    Name = "ESP Distance",
    Description = "Tampilkan jarak player (studs)",
    Default = false,
    Flag = "ESPDistance",
    Callback = function(state)
        if not _G.YOKUDO_ESP then return end
        _G.YOKUDO_ESP.Settings.Distance = state
        _G.YOKUDO_ESP.Refresh()
    end
})

Tab:Toggle({
    Name = "ESP Box",
    Description = "Gambar kotak di sekitar player",
    Default = false,
    Flag = "ESPBox",
    Callback = function(state)
        if not _G.YOKUDO_ESP then return end
        _G.YOKUDO_ESP.Settings.Box = state
        _G.YOKUDO_ESP.Refresh()
    end
})

print("✅ PUMBA ESP Tab Loaded")

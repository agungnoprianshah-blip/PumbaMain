-- ==================================================
-- PUMBA HUB | TAB | Setting
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local Tab = Window:Tab({Name = "Setting", Icon = "settings"})

Tab:Section("Anti Fitur")

Tab:Toggle({
    Name = "Anti Trap",
    Description = "Hilangkan trap di sekitar",
    Default = false,
    Flag = "AntiTrap",
    Callback = function(state)
        if not _G.YOKUDO_AntiTrap then return end
        if state then _G.YOKUDO_AntiTrap.Enable() else _G.YOKUDO_AntiTrap.Disable() end
    end
})

Tab:Toggle({
    Name = "Anti AFK",
    Description = "Cegah tendang karena AFK",
    Default = false,
    Flag = "AntiAFK",
    Callback = function(state)
        if not _G.YOKUDO_AntiAFK then return end
        if state then _G.YOKUDO_AntiAFK.Enable() else _G.YOKUDO_AntiAFK.Disable() end
    end
})

Tab:Section("Karakter")

Tab:Button({
    Name = "God Mode",
    Description = "Klik ketika karakter mati",
    Icon = "shield",
    Style = "Primary",
    Callback = function()
        if _G.YOKUDO_GodMode then
            _G.YOKUDO_GodMode.Enable()
            Window:Notify({Title = "God Mode", Content = "God Mode aktif!", Duration = 3, Type = "Success"})
        end
    end
})

Tab:Button({
    Name = "Manual Fast Click",
    Description = "Click egg cepat secara manual",
    Icon = "mouse-pointer-click",
    Callback = function()
        if not _G.YOKUDO_ManualFastClick then
            Window:Notify({Title = "Error", Content = "ManualFastClick tidak loaded", Duration = 3, Type = "Error"})
            return
        end
        if _G.YOKUDO_ManualFastClick.IsEnabled() then
            _G.YOKUDO_ManualFastClick.Disable()
            Window:Notify({Title = "Manual Fast Click", Content = "Dimatikan", Duration = 2, Type = "Info"})
        else
            _G.YOKUDO_ManualFastClick.Enable()
            Window:Notify({Title = "Manual Fast Click", Content = "Diaktifkan", Duration = 2, Type = "Success"})
        end
    end
})

print("✅ PUMBA Setting Tab Loaded")

-- ==================================================
-- PUMBA HUB | TAB | Collect Egg New
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local Tab = Window:Tab({Name = "Collect Egg", Icon = "egg"})

Tab:Section("Collect Egg new")

Tab:Toggle({
    Name = "For Event Drop Egg",
    Description = "Event Drop Egg Mode",
    Default = false,
    Flag = "DropEgg",
    Callback = function(state)
        if not _G.YOKUDO_DropEgg then return end
        if state then
            _G.YOKUDO_DropEgg.Enable()
        else
            _G.YOKUDO_DropEgg.Disable()
        end
    end
})

Tab:Toggle({
    Name = "Anti Guard",
    Description = "Anti Guard Attack Protection",
    Default = false,
    Flag = "AntiGuard",
    Callback = function(state)
        if not _G.YOKUDO_AntiGuard then return end
        if state then
            _G.YOKUDO_AntiGuard.Enable()
        else
            _G.YOKUDO_AntiGuard.Disable()
        end
    end
})

print("✅ PUMBA Collect Egg Tab Loaded")

-- ==================================================
-- PUMBA HUB | TAB | Event
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local Tab = Window:Tab({Name = "Event", Icon = "zap"})

Tab:Section("Event")

Tab:Toggle({
    Name = "Auto Attack Drone",
    Description = "AFK Farm Drone otomatis",
    Default = false,
    Flag = "AutoAttackDrone",
    Callback = function(state)
        if not _G.YOKUDO_ManagerDrone then
            warn("[Pumba] ManagerDrone tidak loaded")
            return
        end
        if state then
            _G.YOKUDO_ManagerDrone.Enable()
        else
            _G.YOKUDO_ManagerDrone.Disable()
        end
    end
})

print("✅ PUMBA Event Tab Loaded")

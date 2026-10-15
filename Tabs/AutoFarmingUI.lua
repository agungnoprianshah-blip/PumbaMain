-- ==================================================
-- PUMBA HUB | TAB | Auto Farming (UI Pumba)
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local Tab = Window:Tab({Name = "Auto Farming", Icon = "zap"})

Tab:Section("Auto Farming")

Tab:Toggle({
    Name = "Auto Farm (Alternate)",
    Description = "Auto farm egg versi AutoFarm feature",
    Default = false,
    Flag = "AutoFarmingToggle",
    Callback = function(state)
        -- Coba berbagai nama API yang mungkin dipakai AutoFarming.lua
        local api = _G.YOKUDO_AutoFarm or _G.YOKUDO_AutoFarming or _G.YOKUDO_AutoFarmingManager

        if api then
            if state then
                if type(api.Enable) == "function" then
                    pcall(api.Enable)
                elseif type(api.Start) == "function" then
                    pcall(api.Start)
                else
                    warn("[Pumba] AutoFarm API tidak punya Enable/Start")
                end
            else
                if type(api.Disable) == "function" then
                    pcall(api.Disable)
                elseif type(api.Stop) == "function" then
                    pcall(api.Stop)
                end
            end
        else
            warn("[Pumba] API AutoFarm tidak ditemukan di _G")
        end
    end
})

Tab:Button({
    Name = "Cek Status AutoFarm",
    Description = "Lihat API AutoFarm yang tersedia",
    Icon = "info",
    Callback = function()
        local found = {}
        if _G.YOKUDO_AutoFarm then table.insert(found, "_G.YOKUDO_AutoFarm") end
        if _G.YOKUDO_AutoFarming then table.insert(found, "_G.YOKUDO_AutoFarming") end
        if _G.YOKUDO_AutoFarmingManager then table.insert(found, "_G.YOKUDO_AutoFarmingManager") end

        if #found > 0 then
            Window:Notify({
                Title = "AutoFarm",
                Content = "Ditemukan: " .. table.concat(found, ", "),
                Duration = 5,
                Type = "Success"
            })
        else
            Window:Notify({
                Title = "AutoFarm",
                Content = "Tidak ada API yang ditemukan",
                Duration = 5,
                Type = "Error"
            })
        end
    end
})

print("✅ PUMBA AutoFarming UI Tab Loaded")

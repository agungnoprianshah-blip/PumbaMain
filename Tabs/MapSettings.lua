-- ==================================================
-- PUMBA HUB | TAB | Map Settings
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local Tab = Window:Tab({Name = "Map Settings", Icon = "map"})

local Maps = {
    {Id=1, Name="Angels & Demons", Wait=8},
    {Id=2, Name="Titan Temple", Wait=8},
    {Id=3, Name="Cherry Blossom", Wait=7},
    {Id=4, Name="Cosmic", Wait=6},
    {Id=5, Name="Prehistoric", Wait=4},
    {Id=6, Name="Abyss Ocean", Wait=4},
    {Id=7, Name="Volcano", Wait=1},
    {Id=8, Name="Snow", Wait=1},
    {Id=9, Name="Jungle", Wait=1},
    {Id=10, Name="Desert", Wait=1},
    {Id=11, Name="Enchanted Forest", Wait=11},
}

Tab:Section("Map Wait Time")

for _, m in ipairs(Maps) do
    Tab:Input({
        Name = "Map " .. m.Id .. " - " .. m.Name,
        Description = "Default: " .. m.Wait .. "s",
        Placeholder = tostring(m.Wait),
        Default = tostring(m.Wait),
        Numeric = true,
        Flag = "MapWait_" .. m.Id,
        Callback = function(value, enterPressed)
            if not enterPressed then return end
            local n = tonumber(value)
            if n and n >= 0 then
                if _G.YOKUDO_MapSettings then
                    _G.YOKUDO_MapSettings.SetMapWait(m.Id, n)
                end
            end
        end
    })
end

Tab:Button({
    Name = "Reset All to Default",
    Icon = "rotate-ccw",
    Style = "Primary",
    Callback = function()
        for _, m in ipairs(Maps) do
            if _G.YOKUDO_MapSettings then
                _G.YOKUDO_MapSettings.ResetMapWait(m.Id)
            end
        end
        Window:Notify({Title = "Reset", Content = "Semua map direset", Duration = 3, Type = "Success"})
    end
})

print("✅ PUMBA Map Settings Tab Loaded")

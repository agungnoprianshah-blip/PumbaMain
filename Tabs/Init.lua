-- ==================================================
-- PUMBA HUB | TabsManager SHIM
-- Biar AutoFarming.lua (obfuscated) tidak crash
-- ==================================================

local DummyTab = {}
DummyTab.__index = DummyTab

local function MakeDummy()
    local obj = setmetatable({}, DummyTab)
    obj.Visible = false
    obj.MouseButton1Click = { Connect = function() end }
    obj.FindFirstChild = function() return nil end
    obj.Destroy = function() end
    obj.SetOpen = function() end
    obj.Locked = false
    return obj
end

local TabsManager = {
    Tabs = {},
    Pages = {},
    ActiveTab = nil,
    ActivePage = nil,
}

function TabsManager:RegisterTab(Name, Order, PageName)
    print("[Shim] RegisterTab:", Name)
    return MakeDummy(), MakeDummy()
end

function TabsManager:SelectTab() end
function TabsManager:GetTab() return nil, nil end
function TabsManager:SelectTabByName() end

_G.YOKUDO_TabsManager = TabsManager

-- Shim global functions biar obfuscated code tidak crash
_G.CreateTab = function() return MakeDummy() end
_G.CreatePage = function() return MakeDummy() end
_G.CreateSectionTitle = function() return MakeDummy() end
_G.CreateCheckbox = function() return MakeDummy(), MakeDummy(), function() return false end end
_G.CreateTextBoxWithCheckbox = function() return MakeDummy(), MakeDummy(), function() return false end, MakeDummy(), function() return 0 end end
_G.CreateSmartCheckbox = function()
    return { Holder = MakeDummy(), Button = MakeDummy(), GetState = function() return false end, SetState = function() end, Update = function() end }
end

print("✅ Shim TabsManager + Components Loaded")

-- ==================================================
-- YOKUDO HUB | LOADER (PUMBA EDITION - DEBUG MODE)
-- ==================================================

local BASE_URL = "https://raw.githubusercontent.com/agungnoprianshah-blip/PumbaMain/main/"

_G.YOKUDO_EnablePrint = true

local oldPrint = print
print = function(...)
    if _G.YOKUDO_EnablePrint then
        oldPrint(...)
    end
end

print("🔵 Loading YOKUDO HUB...")

_G.YOKUDO_Cache = _G.YOKUDO_Cache or {}

local function GetScript(path)
    local fullPath = BASE_URL .. path
    if _G.YOKUDO_Cache[fullPath] then
        return _G.YOKUDO_Cache[fullPath]
    end
    local script = game:HttpGet(fullPath)
    _G.YOKUDO_Cache[fullPath] = script
    return script
end

_G.YOKUDO_GetScript = GetScript

-- ✅ Fungsi baru: load dengan error handler
local function SafeLoad(path)
    print("📦 ["..path.."] downloading...")
    local src = GetScript(path)
    
    if not src or #src < 10 then
        warn("❌ ["..path.."] FILE KOSONG / 404!")
        return false
    end
    
    print("   ["..path.."] size: "..#src.." bytes")
    
    local fn, err = loadstring(src)
    if not fn then
        warn("❌ ["..path.."] SYNTAX ERROR: "..tostring(err))
        return false
    end
    
    local ok, result = pcall(fn)
    if not ok then
        warn("❌ ["..path.."] RUNTIME ERROR: "..tostring(result))
        return false
    end
    
    print("✅ ["..path.."] loaded")
    return true, result
end

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

print("✅ Game loaded, Player: " .. Player.Name)

-- ==================================================
-- LOADING SCREEN
-- ==================================================
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "LoadingScreen"
LoadingGui.ResetOnSpawn = false
LoadingGui.IgnoreGuiInset = true
LoadingGui.DisplayOrder = 9999
LoadingGui.Parent = CoreGui

local Container = Instance.new("Frame")
Container.Size = UDim2.new(0, 280, 0, 110)
Container.Position = UDim2.new(0.5, -140, 0.5, -55)
Container.BackgroundColor3 = Color3.fromRGB(16, 17, 23)
Container.BorderSizePixel = 0
Container.Parent = LoadingGui

local C1 = Instance.new("UICorner", Container)
C1.CornerRadius = UDim.new(0, 14)

local C2 = Instance.new("UIStroke", Container)
C2.Color = Color3.fromRGB(255, 70, 70)
C2.Thickness = 2
C2.Transparency = 0.2

local Title = Instance.new("TextLabel", Container)
Title.Size = UDim2.new(1, -30, 0, 28)
Title.Position = UDim2.new(0, 15, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "YOKUDO HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold

local Subtitle = Instance.new("TextLabel", Container)
Subtitle.Size = UDim2.new(1, -30, 0, 14)
Subtitle.Position = UDim2.new(0, 15, 0, 36)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Steal An Egg | Pumba Edition"
Subtitle.TextColor3 = Color3.fromRGB(145, 145, 175)
Subtitle.TextSize = 9
Subtitle.Font = Enum.Font.GothamMedium

local BarBg = Instance.new("Frame", Container)
BarBg.Size = UDim2.new(0.75, 0, 0, 4)
BarBg.Position = UDim2.new(0.125, 0, 0.5, 0)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
BarBg.BorderSizePixel = 0

local C3 = Instance.new("UICorner", BarBg)
C3.CornerRadius = UDim.new(1, 0)

local Bar = Instance.new("Frame", BarBg)
Bar.Size = UDim2.new(0, 0, 1, 0)
Bar.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
Bar.BorderSizePixel = 0

local C4 = Instance.new("UICorner", Bar)
C4.CornerRadius = UDim.new(1, 0)

local Percent = Instance.new("TextLabel", Container)
Percent.Size = UDim2.new(1, -30, 0, 22)
Percent.Position = UDim2.new(0, 15, 0.7, 0)
Percent.BackgroundTransparency = 1
Percent.Text = "0%"
Percent.TextColor3 = Color3.fromRGB(255, 70, 70)
Percent.TextSize = 18
Percent.Font = Enum.Font.GothamBold

local function Update(p)
    p = math.clamp(p, 0, 100)
    Bar.Size = UDim2.new(p / 100, 0, 1, 0)
    Percent.Text = math.floor(p) .. "%"
end

Update(5)

-- ==================================================
-- LOAD CORE FILES
-- ==================================================
Update(8)
SafeLoad("Config.lua")

Update(10)
local ok1, pumba = SafeLoad("PumbaUI.lua")
if ok1 then
    _G.YOKUDO_Pumba = pumba
    print("   _G.YOKUDO_Pumba set:", _G.YOKUDO_Pumba ~= nil)
end

Update(12)
SafeLoad("MainPumba.lua")

Update(15)
SafeLoad("Features/SpeedLock.lua")

Update(18)
if _G.YOKUDO_SpeedLock then
    _G.YOKUDO_SpeedLock.RunCheck()
    _G.YOKUDO_IsSpeedUnlocked = _G.YOKUDO_SpeedLock.IsUnlocked()
end

-- ==================================================
-- LOAD FEATURES
-- ==================================================
Update(25)
SafeLoad("Features/AntiAFK.lua")
SafeLoad("Features/AntiTrap.lua")
SafeLoad("Features/GodMode.lua")
SafeLoad("Features/TeleportSystem.lua")
SafeLoad("Features/AutoFarm.lua")
SafeLoad("Features/AutoAttack.lua")
SafeLoad("Features/AFKSystem.lua")
SafeLoad("Features/FarmingManager.lua")
SafeLoad("Features/ManualFastClick.lua")
SafeLoad("Features/DropEgg.lua")
SafeLoad("Features/AntiGuard.lua")
SafeLoad("Features/ConfigSystem.lua")

-- ==================================================
-- LOAD TABS (PUMBA)
-- ==================================================
Update(65)
SafeLoad("Tabs/Info.lua")

-- ==================================================
-- BYPASS
-- ==================================================
Update(96)
SafeLoad("Features/BypassAntiCheat.lua")

Update(100)
task.wait(0.5)
LoadingGui:Destroy()
print("🚀 YOKUDO HUB | Ready!")

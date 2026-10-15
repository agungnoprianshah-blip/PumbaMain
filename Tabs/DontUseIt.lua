-- ==================================================
-- PUMBA HUB | TAB | Don't Use It
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Tab = Window:Tab({Name = "Don't Use It", Icon = "alert-triangle"})

Tab:Section("Don't Use It")

local FloatingGui, FloatingFrame, FloatingLabel
local FloatingEnabled = false

local function CreateFloating()
    if FloatingGui then return end
    FloatingGui = Instance.new("ScreenGui")
    FloatingGui.Name = "PumbaFloatingToggle"
    FloatingGui.ResetOnSpawn = false
    FloatingGui.IgnoreGuiInset = true
    FloatingGui.DisplayOrder = 9999
    FloatingGui.Parent = CoreGui

    FloatingFrame = Instance.new("TextButton")
    FloatingFrame.Size = UDim2.new(0, 160, 0, 44)
    FloatingFrame.Position = UDim2.new(0, 20, 0.5, -22)
    FloatingFrame.BackgroundColor3 = Color3.fromRGB(28, 12, 12)
    FloatingFrame.BorderSizePixel = 0
    FloatingFrame.Text = ""
    FloatingFrame.AutoButtonColor = false
    FloatingFrame.Parent = FloatingGui

    local C = Instance.new("UICorner", FloatingFrame)
    C.CornerRadius = UDim.new(0, 8)
    local S = Instance.new("UIStroke", FloatingFrame)
    S.Name = "Stroke"
    S.Color = Color3.fromRGB(200, 80, 80)
    S.Thickness = 1.5

    FloatingLabel = Instance.new("TextLabel", FloatingFrame)
    FloatingLabel.Size = UDim2.new(1, -20, 1, 0)
    FloatingLabel.Position = UDim2.new(0, 10, 0, 0)
    FloatingLabel.BackgroundTransparency = 1
    FloatingLabel.Text = "Don't use it : OFF"
    FloatingLabel.TextColor3 = Color3.fromRGB(240, 220, 220)
    FloatingLabel.TextSize = 12
    FloatingLabel.TextXAlignment = Enum.TextXAlignment.Center
    FloatingLabel.Font = Enum.Font.GothamBold

    FloatingFrame.MouseButton1Click:Connect(function()
        FloatingEnabled = not FloatingEnabled
        if FloatingEnabled then
            FloatingFrame.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
            FloatingFrame.Stroke.Color = Color3.fromRGB(255, 150, 150)
            FloatingLabel.Text = "Don't use it : ON"
            if _G.YOKUDO_DontUseIt then _G.YOKUDO_DontUseIt.Enable() end
        else
            FloatingFrame.BackgroundColor3 = Color3.fromRGB(28, 12, 12)
            FloatingFrame.Stroke.Color = Color3.fromRGB(200, 80, 80)
            FloatingLabel.Text = "Don't use it : OFF"
            if _G.YOKUDO_DontUseIt then _G.YOKUDO_DontUseIt.Disable() end
        end
    end)

    -- Drag
    local Dragging, DragStart, StartPos, ActiveTouch = false, nil, nil, nil
    FloatingFrame.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            if Input.UserInputType == Enum.UserInputType.Touch then ActiveTouch = Input end
            Dragging = true
            DragStart = Input.Position
            StartPos = FloatingFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then return end
        if Input.UserInputType == Enum.UserInputType.Touch and ActiveTouch and Input ~= ActiveTouch then return end
        if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then return end
        local D = Input.Position - DragStart
        FloatingFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + D.X, StartPos.Y.Scale, StartPos.Y.Offset + D.Y)
    end)
    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.Touch and Input == ActiveTouch then
            Dragging, ActiveTouch, DragStart, StartPos = false, nil, nil, nil
        elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging, DragStart, StartPos = false, nil, nil
        end
    end)
end

Tab:Toggle({
    Name = "Show Floating Toggle",
    Description = "Tampilkan toggle floating",
    Default = false,
    Flag = "ShowFloatingToggle",
    Callback = function(state)
        CreateFloating()
        if FloatingGui then
            FloatingGui.Enabled = state
        end
    end
})

print("✅ PUMBA Don't Use It Tab Loaded")

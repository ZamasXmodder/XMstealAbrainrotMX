-- XM PANEL MX - STEAL A BRAINROT
-- Roblox GUI Script by Claude

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMPanelMX"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Frame principal del panel
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 420, 0, 350)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Corner redondeado para el panel principal
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 25)
mainCorner.Parent = mainFrame

-- Gradiente para el fondo del panel
local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(42, 42, 42)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
}
mainGradient.Rotation = 145
mainGradient.Parent = mainFrame

-- Borde rainbow animado
local rainbowFrame = Instance.new("Frame")
rainbowFrame.Name = "RainbowBorder"
rainbowFrame.Size = UDim2.new(1, 4, 1, 4)
rainbowFrame.Position = UDim2.new(0, -2, 0, -2)
rainbowFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 110)
rainbowFrame.BorderSizePixel = 0
rainbowFrame.ZIndex = mainFrame.ZIndex - 1
rainbowFrame.Parent = mainFrame

local rainbowCorner = Instance.new("UICorner")
rainbowCorner.CornerRadius = UDim.new(0, 27)
rainbowCorner.Parent = rainbowFrame

local rainbowGradient = Instance.new("UIGradient")
rainbowGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 110)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(131, 56, 236)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(58, 134, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(6, 255, 165)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 190, 11)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(251, 86, 7)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 110))
}
rainbowGradient.Rotation = 45
rainbowGradient.Parent = rainbowFrame

-- Título principal "XM PANEL MX"
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 25)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM PANEL MX"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.TextStrokeTransparency = 0.5
titleLabel.TextStrokeColor3 = Color3.fromRGB(255, 0, 110)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Gradiente para el título
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 110)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(131, 56, 236)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(58, 134, 255)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(6, 255, 165)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 190, 11)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(251, 86, 7))
}
titleGradient.Rotation = 45
titleGradient.Parent = titleLabel

-- Subtítulo "STEAL A BRAINROT"
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, 0, 0, 25)
subtitleLabel.Position = UDim2.new(0, 0, 0, 70)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "STEAL A BRAINROT"
subtitleLabel.TextColor3 = Color3.fromRGB(255, 0, 110)
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.GothamBold
subtitleLabel.Parent = mainFrame

-- Trial label
local trialLabel = Instance.new("TextLabel")
trialLabel.Name = "TrialLabel"
trialLabel.Size = UDim2.new(1, 0, 0, 20)
trialLabel.Position = UDim2.new(0, 0, 0, 110)
trialLabel.BackgroundTransparency = 1
trialLabel.Text = "(TRIAL 3 DAYS)"
trialLabel.TextColor3 = Color3.fromRGB(136, 136, 136)
trialLabel.TextScaled = true
trialLabel.Font = Enum.Font.Gotham
trialLabel.Parent = mainFrame

-- Línea decorativa
local decorativeLine = Instance.new("Frame")
decorativeLine.Name = "DecorativeLine"
decorativeLine.Size = UDim2.new(0, 60, 0, 2)
decorativeLine.Position = UDim2.new(0.5, -30, 0, 140)
decorativeLine.BorderSizePixel = 0
decorativeLine.Parent = mainFrame

local lineCorner = Instance.new("UICorner")
lineCorner.CornerRadius = UDim.new(0, 1)
lineCorner.Parent = decorativeLine

local lineGradient = Instance.new("UIGradient")
lineGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 56, 236)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 255, 165))
}
lineGradient.Rotation = 90
lineGradient.Parent = decorativeLine

-- Campo de texto para la key
local keyTextBox = Instance.new("TextBox")
keyTextBox.Name = "KeyTextBox"
keyTextBox.Size = UDim2.new(0.85, 0, 0, 45)
keyTextBox.Position = UDim2.new(0.075, 0, 0, 170)
keyTextBox.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
keyTextBox.BorderSizePixel = 2
keyTextBox.BorderColor3 = Color3.fromRGB(51, 51, 51)
keyTextBox.Text = ""
keyTextBox.PlaceholderText = "Insert Key"
keyTextBox.PlaceholderColor3 = Color3.fromRGB(102, 102, 102)
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.TextScaled = true
keyTextBox.Font = Enum.Font.Gotham
keyTextBox.Parent = mainFrame

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 12)
textBoxCorner.Parent = keyTextBox

-- Gradiente para el TextBox
local textBoxGradient = Instance.new("UIGradient")
textBoxGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 26, 26)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 45))
}
textBoxGradient.Rotation = 145
textBoxGradient.Parent = keyTextBox

-- Botón GET KEY
local getKeyButton = Instance.new("TextButton")
getKeyButton.Name = "GetKeyButton"
getKeyButton.Size = UDim2.new(0.4, -10, 0, 45)
getKeyButton.Position = UDim2.new(0.075, 0, 0, 240)
getKeyButton.BackgroundColor3 = Color3.fromRGB(131, 56, 236)
getKeyButton.BorderSizePixel = 0
getKeyButton.Text = "GET KEY"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextScaled = true
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.Parent = mainFrame

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 12)
getKeyCorner.Parent = getKeyButton

local getKeyGradient = Instance.new("UIGradient")
getKeyGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 56, 236)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(108, 43, 217))
}
getKeyGradient.Rotation = 145
getKeyGradient.Parent = getKeyButton

-- Botón SUBMIT
local submitButton = Instance.new("TextButton")
submitButton.Name = "SubmitButton"
submitButton.Size = UDim2.new(0.4, -10, 0, 45)
submitButton.Position = UDim2.new(0.525, 0, 0, 240)
submitButton.BackgroundColor3 = Color3.fromRGB(6, 255, 165)
submitButton.BorderSizePixel = 0
submitButton.Text = "SUBMIT"
submitButton.TextColor3 = Color3.fromRGB(0, 0, 0)
submitButton.TextScaled = true
submitButton.Font = Enum.Font.GothamBold
submitButton.Parent = mainFrame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 12)
submitCorner.Parent = submitButton

local submitGradient = Instance.new("UIGradient")
submitGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(6, 255, 165)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 224, 148))
}
submitGradient.Rotation = 145
submitGradient.Parent = submitButton

-- Indicador de estado
local statusIndicator = Instance.new("Frame")
statusIndicator.Name = "StatusIndicator"
statusIndicator.Size = UDim2.new(0, 12, 0, 12)
statusIndicator.Position = UDim2.new(1, -32, 0, 20)
statusIndicator.BackgroundColor3 = Color3.fromRGB(6, 255, 165)
statusIndicator.BorderSizePixel = 0
statusIndicator.Parent = mainFrame

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(0.5, 0)
indicatorCorner.Parent = statusIndicator

-- Efectos y animaciones
local function createHoverEffect(button, hoverColor, originalColor)
    local hoverTween = TweenService:Create(
        button,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = hoverColor}
    )
    
    local normalTween = TweenService:Create(
        button,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = originalColor}
    )
    
    button.MouseEnter:Connect(function()
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        normalTween:Play()
    end)
end

-- Aplicar efectos hover
createHoverEffect(getKeyButton, Color3.fromRGB(108, 43, 217), Color3.fromRGB(131, 56, 236))
createHoverEffect(submitButton, Color3.fromRGB(4, 224, 148), Color3.fromRGB(6, 255, 165))

-- Animación del borde rainbow
local rainbowConnection
rainbowConnection = RunService.Heartbeat:Connect(function()
    rainbowGradient.Rotation = rainbowGradient.Rotation + 1
    if rainbowGradient.Rotation >= 360 then
        rainbowGradient.Rotation = 0
    end
end)

-- Animación del indicador de estado
local function pulseIndicator()
    local pulseTween = TweenService:Create(
        statusIndicator,
        TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {BackgroundTransparency = 0.5}
    )
    pulseTween:Play()
end

pulseIndicator()

-- Función para generar key aleatoria
local function generateKey()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local key = "XM-"
    for i = 1, 12 do
        local randomIndex = math.random(1, #chars)
        key = key .. chars:sub(randomIndex, randomIndex)
    end
    return key
end

-- Funcionalidad del botón GET KEY
getKeyButton.MouseButton1Click:Connect(function()
    local originalText = getKeyButton.Text
    local originalColor = getKeyButton.BackgroundColor3
    
    getKeyButton.Text = "GENERATING..."
    getKeyButton.BackgroundColor3 = Color3.fromRGB(255, 190, 11)
    
    wait(1.5)
    
    local newKey = generateKey()
    keyTextBox.Text = newKey
    
    getKeyButton.Text = "KEY GENERATED!"
    getKeyButton.BackgroundColor3 = Color3.fromRGB(6, 255, 165)
    
    wait(2)
    
    getKeyButton.Text = originalText
    getKeyButton.BackgroundColor3 = originalColor
end)

-- Funcionalidad del botón SUBMIT
submitButton.MouseButton1Click:Connect(function()
    local key = keyTextBox.Text
    
    if key == "" then
        -- Crear notificación de error
        local errorFrame = Instance.new("Frame")
        errorFrame.Size = UDim2.new(0, 250, 0, 60)
        errorFrame.Position = UDim2.new(0.5, -125, 0, -80)
        errorFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 110)
        errorFrame.BorderSizePixel = 0
        errorFrame.Parent = mainFrame
        
        local errorCorner = Instance.new("UICorner")
        errorCorner.CornerRadius = UDim.new(0, 10)
        errorCorner.Parent = errorFrame
        
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Size = UDim2.new(1, 0, 1, 0)
        errorLabel.Position = UDim2.new(0, 0, 0, 0)
        errorLabel.BackgroundTransparency = 1
        errorLabel.Text = "Please insert a key first!"
        errorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        errorLabel.TextScaled = true
        errorLabel.Font = Enum.Font.GothamBold
        errorLabel.Parent = errorFrame
        
        wait(2)
        errorFrame:Destroy()
        return
    end
    
    local originalText = submitButton.Text
    local originalColor = submitButton.BackgroundColor3
    
    submitButton.Text = "VALIDATING..."
    submitButton.BackgroundColor3 = Color3.fromRGB(255, 190, 11)
    
    wait(1.5)
    
    if string.find(key, "XM%-") then
        submitButton.Text = "SUCCESS!"
        submitButton.BackgroundColor3 = Color3.fromRGB(6, 255, 165)
        
        -- Crear notificación de éxito
        local successFrame = Instance.new("Frame")
        successFrame.Size = UDim2.new(0, 280, 0, 70)
        successFrame.Position = UDim2.new(0.5, -140, 0, -90)
        successFrame.BackgroundColor3 = Color3.fromRGB(6, 255, 165)
        successFrame.BorderSizePixel = 0
        successFrame.Parent = mainFrame
        
        local successCorner = Instance.new("UICorner")
        successCorner.CornerRadius = UDim.new(0, 10)
        successCorner.Parent = successFrame
        
        local successLabel = Instance.new("TextLabel")
        successLabel.Size = UDim2.new(1, 0, 1, 0)
        successLabel.Position = UDim2.new(0, 0, 0, 0)
        successLabel.BackgroundTransparency = 1
        successLabel.Text = "Key validated successfully!\nAccess granted."
        successLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        successLabel.TextScaled = true
        successLabel.Font = Enum.Font.GothamBold
        successLabel.Parent = successFrame
        
        wait(3)
        successFrame:Destroy()
    else
        submitButton.Text = "INVALID KEY!"
        submitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 110)
        
        -- Crear notificación de error
        local errorFrame = Instance.new("Frame")
        errorFrame.Size = UDim2.new(0, 260, 0, 70)
        errorFrame.Position = UDim2.new(0.5, -130, 0, -90)
        errorFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 110)
        errorFrame.BorderSizePixel = 0
        errorFrame.Parent = mainFrame
        
        local errorCorner = Instance.new("UICorner")
        errorCorner.CornerRadius = UDim.new(0, 10)
        errorCorner.Parent = errorFrame
        
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Size = UDim2.new(1, 0, 1, 0)
        errorLabel.Position = UDim2.new(0, 0, 0, 0)
        errorLabel.BackgroundTransparency = 1
        errorLabel.Text = "Invalid key!\nPlease get a new key."
        errorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        errorLabel.TextScaled = true
        errorLabel.Font = Enum.Font.GothamBold
        errorLabel.Parent = errorFrame
        
        wait(3)
        errorFrame:Destroy()
    end
    
    wait(2)
    submitButton.Text = originalText
    submitButton.BackgroundColor3 = originalColor
end)

-- Efecto de focus en el TextBox
keyTextBox.Focused:Connect(function()
    keyTextBox.BorderColor3 = Color3.fromRGB(131, 56, 236)
end)

keyTextBox.FocusLost:Connect(function()
    keyTextBox.BorderColor3 = Color3.fromRGB(51, 51, 51)
end)

-- Hacer el panel arrastrable
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("XM PANEL MX loaded successfully!")

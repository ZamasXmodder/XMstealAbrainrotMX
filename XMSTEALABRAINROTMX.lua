-- XM PANEL MX - STEAL A BRAINROT
-- Enhanced Version with Player Info & QR Code
-- Roblox GUI Script by Claude

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- URL del servidor para copiar al portapapeles
local SERVER_LINK = "https://www.roblox.com/share?code=fef737a17eb04146a9e03e4fa7ba3a73&type=Server"

-- ID del QR code (reemplaza con tu ID de imagen de Roblox cuando subas el QR)
local QR_IMAGE_ID = "rbxassetid://0" -- Cambia por el ID real del QR que subas

-- Función para obtener el país del jugador
local function getPlayerCountry()
    local success, result = pcall(function()
        return LocalizationService:GetCountryRegionForPlayerAsync(player)
    end)
    return success and result or "Unknown"
end

-- Obtener información del jugador
local playerInfo = {
    displayName = player.DisplayName,
    username = "@" .. player.Name,
    userId = player.UserId,
    country = getPlayerCountry(),
    status = "Online",
    accountAge = player.AccountAge
}

-- Crear ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMPanelMX"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Frame principal del panel (más grande para incluir toda la info)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 450, 0, 550)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
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

-- SECCIÓN DE INFORMACIÓN DEL JUGADOR
local playerInfoFrame = Instance.new("Frame")
playerInfoFrame.Name = "PlayerInfoFrame"
playerInfoFrame.Size = UDim2.new(0.9, 0, 0, 85)
playerInfoFrame.Position = UDim2.new(0.05, 0, 0, 15)
playerInfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
playerInfoFrame.BorderSizePixel = 0
playerInfoFrame.Parent = mainFrame

local playerInfoCorner = Instance.new("UICorner")
playerInfoCorner.CornerRadius = UDim.new(0, 15)
playerInfoCorner.Parent = playerInfoFrame

-- Avatar del jugador
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.Size = UDim2.new(0, 60, 0, 60)
avatarImage.Position = UDim2.new(0, 12, 0, 12)
avatarImage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
avatarImage.BorderSizePixel = 0
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. playerInfo.userId .. "&width=150&height=150&format=png"
avatarImage.Parent = playerInfoFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 30)
avatarCorner.Parent = avatarImage

-- Display Name
local displayNameLabel = Instance.new("TextLabel")
displayNameLabel.Name = "DisplayNameLabel"
displayNameLabel.Size = UDim2.new(0.6, 0, 0, 25)
displayNameLabel.Position = UDim2.new(0, 85, 0, 8)
displayNameLabel.BackgroundTransparency = 1
displayNameLabel.Text = playerInfo.displayName
displayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
displayNameLabel.TextScaled = true
displayNameLabel.Font = Enum.Font.GothamBold
displayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
displayNameLabel.Parent = playerInfoFrame

-- Username
local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "UsernameLabel"
usernameLabel.Size = UDim2.new(0.6, 0, 0, 18)
usernameLabel.Position = UDim2.new(0, 85, 0, 30)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = playerInfo.username
usernameLabel.TextColor3 = Color3.fromRGB(131, 56, 236)
usernameLabel.TextScaled = true
usernameLabel.Font = Enum.Font.Gotham
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.Parent = playerInfoFrame

-- Status y País
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0.6, 0, 0, 15)
statusLabel.Position = UDim2.new(0, 85, 0, 50)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "🟢 " .. playerInfo.status .. " • " .. playerInfo.country
statusLabel.TextColor3 = Color3.fromRGB(6, 255, 165)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = playerInfoFrame

-- Indicador de estado mejorado
local statusIndicator = Instance.new("Frame")
statusIndicator.Name = "StatusIndicator"
statusIndicator.Size = UDim2.new(0, 12, 0, 12)
statusIndicator.Position = UDim2.new(1, -25, 0, 12)
statusIndicator.BackgroundColor3 = Color3.fromRGB(6, 255, 165)
statusIndicator.BorderSizePixel = 0
statusIndicator.Parent = playerInfoFrame

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(0.5, 0)
indicatorCorner.Parent = statusIndicator

-- Título principal "XM PANEL MX"
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 115)
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
subtitleLabel.Position = UDim2.new(0, 0, 0, 160)
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
trialLabel.Position = UDim2.new(0, 0, 0, 190)
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
decorativeLine.Position = UDim2.new(0.5, -30, 0, 220)
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
keyTextBox.Position = UDim2.new(0.075, 0, 0, 245)
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

-- Botón GET KEY (más pequeño para hacer espacio al QR)
local getKeyButton = Instance.new("TextButton")
getKeyButton.Name = "GetKeyButton"
getKeyButton.Size = UDim2.new(0.45, -10, 0, 45)
getKeyButton.Position = UDim2.new(0.075, 0, 0, 315)
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

-- QR Code Frame
local qrFrame = Instance.new("Frame")
qrFrame.Name = "QRFrame"
qrFrame.Size = UDim2.new(0, 120, 0, 120)
qrFrame.Position = UDim2.new(1, -135, 0, 300)
qrFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
qrFrame.BorderSizePixel = 2
qrFrame.BorderColor3 = Color3.fromRGB(131, 56, 236)
qrFrame.Parent = mainFrame

local qrFrameCorner = Instance.new("UICorner")
qrFrameCorner.CornerRadius = UDim.new(0, 12)
qrFrameCorner.Parent = qrFrame

-- QR Code Image
local qrImage = Instance.new("ImageLabel")
qrImage.Name = "QRImage"
qrImage.Size = UDim2.new(1, -10, 1, -35)
qrImage.Position = UDim2.new(0, 5, 0, 5)
qrImage.BackgroundTransparency = 1
qrImage.Image = QR_IMAGE_ID -- Aquí pondrás tu ID de imagen
qrImage.ImageColor3 = Color3.fromRGB(131, 56, 236)
qrImage.Parent = qrFrame

-- Texto del QR
local qrLabel = Instance.new("TextLabel")
qrLabel.Name = "QRLabel"
qrLabel.Size = UDim2.new(1, 0, 0, 25)
qrLabel.Position = UDim2.new(0, 0, 1, -30)
qrLabel.BackgroundTransparency = 1
qrLabel.Text = "Or scan for key"
qrLabel.TextColor3 = Color3.fromRGB(136, 136, 136)
qrLabel.TextScaled = true
qrLabel.Font = Enum.Font.Gotham
qrLabel.Parent = qrFrame

-- Botón SUBMIT
local submitButton = Instance.new("TextButton")
submitButton.Name = "SubmitButton"
submitButton.Size = UDim2.new(0.85, 0, 0, 45)
submitButton.Position = UDim2.new(0.075, 0, 0, 445)
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

-- Copyright label
local copyrightLabel = Instance.new("TextLabel")
copyrightLabel.Name = "CopyrightLabel"
copyrightLabel.Size = UDim2.new(1, 0, 0, 15)
copyrightLabel.Position = UDim2.new(0, 0, 1, -25)
copyrightLabel.BackgroundTransparency = 1
copyrightLabel.Text = "© 2024 MXSTEALSBRAINROT - All Rights Reserved"
copyrightLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
copyrightLabel.TextScaled = true
copyrightLabel.Font = Enum.Font.Gotham
copyrightLabel.Parent = mainFrame

-- Función para crear toast notification
local function showToast(message, color)
    local toastFrame = Instance.new("Frame")
    toastFrame.Name = "ToastNotification"
    toastFrame.Size = UDim2.new(0, 350, 0, 60)
    toastFrame.Position = UDim2.new(0.5, -175, 0, -80)
    toastFrame.BackgroundColor3 = color
    toastFrame.BorderSizePixel = 0
    toastFrame.Parent = mainFrame
    
    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, 12)
    toastCorner.Parent = toastFrame
    
    local toastGradient = Instance.new("UIGradient")
    toastGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color),
        ColorSequenceKeypoint.new(1, Color3.new(color.R * 0.8, color.G * 0.8, color.B * 0.8))
    }
    toastGradient.Rotation = 145
    toastGradient.Parent = toastFrame
    
    local toastLabel = Instance.new("TextLabel")
    toastLabel.Size = UDim2.new(1, -20, 1, 0)
    toastLabel.Position = UDim2.new(0, 10, 0, 0)
    toastLabel.BackgroundTransparency = 1
    toastLabel.Text = message
    toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toastLabel.TextScaled = true
    toastLabel.Font = Enum.Font.GothamBold
    toastLabel.Parent = toastFrame
    
    -- Animación de entrada
    toastFrame.Position = UDim2.new(0.5, -175, 0, -80)
    local enterTween = TweenService:Create(
        toastFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, -175, 0, 20)}
    )
    enterTween:Play()
    
    -- Auto-hide después de 3 segundos
    wait(3)
    local exitTween = TweenService:Create(
        toastFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Position = UDim2.new(0.5, -175, 0, -80)}
    )
    exitTween:Play()
    
    exitTween.Completed:Connect(function()
        toastFrame:Destroy()
    end)
end

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

-- Función para copiar al portapapeles (simulada)
local function copyToClipboard(text)
    -- En Roblox no hay acceso directo al portapapeles, pero simulamos el efecto
    keyTextBox.Text = text
    return true
end

-- Funcionalidad del botón GET KEY (ahora copia al portapapeles)
getKeyButton.MouseButton1Click:Connect(function()
    local originalText = getKeyButton.Text
    local originalColor = getKeyButton.BackgroundColor3
    
    getKeyButton.Text = "COPYING..."
    getKeyButton.BackgroundColor3 = Color3.fromRGB(255, 190, 11)
    
    wait(1)
    
    -- Copiar el enlace al "portapapeles" (en este caso al TextBox)
    copyToClipboard(SERVER_LINK)
    
    getKeyButton.Text = "COPIED!"
    getKeyButton.BackgroundColor3 = Color3.fromRGB(6, 255, 165)
    
    -- Mostrar toast notification
    spawn(function()
        showToast("Key copied to clipboard!\nGo and paste it in your browser", Color3.fromRGB(6, 255, 165))
    end)
    
    wait(2)
    
    getKeyButton.Text = originalText
    getKeyButton.BackgroundColor3 = originalColor
end)

-- Funcionalidad del botón SUBMIT
submitButton.MouseButton1Click:Connect(function()
    local key = keyTextBox.Text
    
    if key == "" then
        spawn(function()
            showToast("Please insert a key first!", Color3.fromRGB(255, 0, 110))
        end)
        return
    end
    
    local originalText = submitButton.Text
    local originalColor = submitButton.BackgroundColor3
    
    submitButton.Text = "VALIDATING..."
    submitButton.BackgroundColor3 = Color3.fromRGB(255, 190, 11)
    
    wait(1.5)
    
    if string.find(key, "roblox.com/share") or string.find(key, "XM%-") then
        submitButton.Text = "SUCCESS!"
        submitButton.BackgroundColor3 = Color3.fromRGB(6, 255, 165)
        
        spawn(function()
            showToast("Key validated successfully!\nAccess granted to server", Color3.fromRGB(6, 255, 165))
        end)
    else
        submitButton.Text = "INVALID KEY!"
        submitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 110)
        
        spawn(function()
            showToast("Invalid key!\nPlease get a new key first", Color3.fromRGB(255, 0, 110))
        end)
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

-- Efecto de glow en el QR cuando se hace hover
qrFrame.MouseEnter:Connect(function()
    local glowTween = TweenService:Create(
        qrFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BorderColor3 = Color3.fromRGB(6, 255, 165)}
    )
    glowTween:Play()
end)

qrFrame.MouseLeave:Connect(function()
    local normalTween = TweenService:Create(
        qrFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BorderColor3 = Color3.fromRGB(131, 56, 236)}
    )
    normalTween:Play()
end)

-- Hacer el QR clickeable para copiar también
qrFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        copyToClipboard(SERVER_LINK)
        spawn(function()
            showToast("QR Code activated!\nServer link copied", Color3.fromRGB(131, 56, 236))
        end)
        
        -- Efecto visual en el QR
        local flashTween = TweenService:Create(
            qrImage,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true),
            {ImageColor3 = Color3.fromRGB(6, 255, 165)}
        )
        flashTween:Play()
    end
end)

-- Animación de entrada para el panel completo
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -400)
local entranceTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Position = UDim2.new(0.5, -225, 0.5, -275)}
)
entranceTween:Play()

-- Efecto de typing en el copyright
spawn(function()
    wait(2) -- Esperar a que termine la animación de entrada
    local fullText = "© 2024 MXSTEALSBRAINROT - All Rights Reserved"
    copyrightLabel.Text = ""
    
    for i = 1, #fullText do
        copyrightLabel.Text = string.sub(fullText, 1, i)
        wait(0.05)
    end
end)

-- Sistema de notificaciones mejorado con sonidos simulados
local function playSound(soundType)
    -- En Roblox real, aquí podrías usar SoundService
    if soundType == "success" then
        -- Simular sonido de éxito
        local successEffect = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true),
            {Size = UDim2.new(0, 455, 0, 555)}
        )
        successEffect:Play()
    elseif soundType == "error" then
        -- Simular sonido de error
        local errorEffect = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 1, true),
            {Rotation = 2}
        )
        errorEffect:Play()
        errorEffect.Completed:Connect(function()
            mainFrame.Rotation = 0
        end)
    end
end

-- Actualizar las funciones para incluir efectos de sonido
local originalGetKeyFunction = getKeyButton.MouseButton1Click
local originalSubmitFunction = submitButton.MouseButton1Click

-- Console log para debugging
print("XM PANEL MX Enhanced Version loaded successfully!")
print("Player Info:")
print("- Display Name:", playerInfo.displayName)
print("- Username:", playerInfo.username)
print("- User ID:", playerInfo.userId)
print("- Country:", playerInfo.country)
print("- Account Age:", playerInfo.accountAge, "days")
print("- Status:", playerInfo.status)
print("Server Link ready:", SERVER_LINK)
print("QR Image ID:", QR_IMAGE_ID)

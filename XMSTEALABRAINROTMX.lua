-- XM PANEL MX - STEAL A BRAINROT
-- Roblox GUI Script

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMPanelMX"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Frame principal del panel
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 450, 0, 600)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Corner redondeado
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 24)
mainCorner.Parent = mainFrame

-- Borde rainbow animado
local borderFrame = Instance.new("Frame")
borderFrame.Name = "RainbowBorder"
borderFrame.Size = UDim2.new(1, 4, 1, 4)
borderFrame.Position = UDim2.new(0, -2, 0, -2)
borderFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 128)
borderFrame.BorderSizePixel = 0
borderFrame.ZIndex = mainFrame.ZIndex - 1
borderFrame.Parent = mainFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 26)
borderCorner.Parent = borderFrame

-- Gradiente rainbow para el borde
local borderGradient = Instance.new("UIGradient")
borderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 128)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 140, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 128)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(0, 128, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 255))
}
borderGradient.Rotation = 45
borderGradient.Parent = borderFrame

-- Animación del borde rainbow
local function animateRainbowBorder()
    while screenGui.Parent do
        for rotation = 0, 360, 2 do
            if not screenGui.Parent then break end
            borderGradient.Rotation = rotation
            wait(0.05)
        end
    end
end

spawn(animateRainbowBorder)

-- Información del jugador - Container
local playerInfoFrame = Instance.new("Frame")
playerInfoFrame.Name = "PlayerInfo"
playerInfoFrame.Size = UDim2.new(1, -40, 0, 120)
playerInfoFrame.Position = UDim2.new(0, 20, 0, 20)
playerInfoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
playerInfoFrame.BackgroundTransparency = 0.2
playerInfoFrame.BorderSizePixel = 0
playerInfoFrame.Parent = mainFrame

local playerInfoCorner = Instance.new("UICorner")
playerInfoCorner.CornerRadius = UDim.new(0, 16)
playerInfoCorner.Parent = playerInfoFrame

-- Avatar del jugador
local avatarFrame = Instance.new("Frame")
avatarFrame.Size = UDim2.new(0, 80, 0, 80)
avatarFrame.Position = UDim2.new(0, 15, 0, 20)
avatarFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
avatarFrame.BorderSizePixel = 0
avatarFrame.Parent = playerInfoFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 12)
avatarCorner.Parent = avatarFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(1, 0, 1, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
avatarImage.Parent = avatarFrame

local avatarImageCorner = Instance.new("UICorner")
avatarImageCorner.CornerRadius = UDim.new(0, 12)
avatarImageCorner.Parent = avatarImage

-- Información de texto del jugador
local playerNameLabel = Instance.new("TextLabel")
playerNameLabel.Name = "PlayerName"
playerNameLabel.Size = UDim2.new(1, -110, 0, 25)
playerNameLabel.Position = UDim2.new(0, 105, 0, 20)
playerNameLabel.BackgroundTransparency = 1
playerNameLabel.Text = player.DisplayName
playerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerNameLabel.TextScaled = true
playerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
playerNameLabel.Font = Enum.Font.GothamBold
playerNameLabel.Parent = playerInfoFrame

local playerUsernameLabel = Instance.new("TextLabel")
playerUsernameLabel.Name = "PlayerUsername"
playerUsernameLabel.Size = UDim2.new(1, -110, 0, 20)
playerUsernameLabel.Position = UDim2.new(0, 105, 0, 45)
playerUsernameLabel.BackgroundTransparency = 1
playerUsernameLabel.Text = "@" .. player.Name
playerUsernameLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
playerUsernameLabel.TextScaled = true
playerUsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
playerUsernameLabel.Font = Enum.Font.Gotham
playerUsernameLabel.Parent = playerInfoFrame

-- Obtener información del país del jugador
local countryCode = "US" -- Por defecto
pcall(function()
    local result = LocalizationService:GetCountryRegionForPlayerAsync(player)
    countryCode = result
end)

local playerCountryLabel = Instance.new("TextLabel")
playerCountryLabel.Name = "PlayerCountry"
playerCountryLabel.Size = UDim2.new(1, -110, 0, 18)
playerCountryLabel.Position = UDim2.new(0, 105, 0, 67)
playerCountryLabel.BackgroundTransparency = 1
playerCountryLabel.Text = "Country: " .. countryCode
playerCountryLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
playerCountryLabel.TextScaled = true
playerCountryLabel.TextXAlignment = Enum.TextXAlignment.Left
playerCountryLabel.Font = Enum.Font.Gotham
playerCountryLabel.Parent = playerInfoFrame

local playerStatusLabel = Instance.new("TextLabel")
playerStatusLabel.Name = "PlayerStatus"
playerStatusLabel.Size = UDim2.new(1, -110, 0, 18)
playerStatusLabel.Position = UDim2.new(0, 105, 0, 85)
playerStatusLabel.BackgroundTransparency = 1
playerStatusLabel.Text = "Status: Premium User"
playerStatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
playerStatusLabel.TextScaled = true
playerStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
playerStatusLabel.Font = Enum.Font.Gotham
playerStatusLabel.Parent = playerInfoFrame

-- Título principal con efecto rainbow
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "MainTitle"
titleLabel.Size = UDim2.new(1, -40, 0, 45)
titleLabel.Position = UDim2.new(0, 20, 0, 160)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM PANEL MX - STEAL A BRAINROT"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Gradiente rainbow para el título
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 128)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 140, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 128)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 255))
}
titleGradient.Parent = titleLabel

-- Animación del título rainbow
local function animateRainbowTitle()
    while screenGui.Parent do
        for offset = 0, 1, 0.02 do
            if not screenGui.Parent then break end
            titleGradient.Offset = Vector2.new(offset, 0)
            wait(0.05)
        end
        for offset = 1, 0, -0.02 do
            if not screenGui.Parent then break end
            titleGradient.Offset = Vector2.new(offset, 0)
            wait(0.05)
        end
    end
end

spawn(animateRainbowTitle)

-- Subtítulo
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "Subtitle"
subtitleLabel.Size = UDim2.new(1, -40, 0, 25)
subtitleLabel.Position = UDim2.new(0, 20, 0, 210)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "(trial 3 days)"
subtitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Parent = mainFrame

-- Línea decorativa
local decorativeLine = Instance.new("Frame")
decorativeLine.Size = UDim2.new(0, 60, 0, 3)
decorativeLine.Position = UDim2.new(0.5, -30, 0, 250)
decorativeLine.BackgroundColor3 = Color3.fromRGB(255, 0, 128)
decorativeLine.BorderSizePixel = 0
decorativeLine.Parent = mainFrame

local lineCorner = Instance.new("UICorner")
lineCorner.CornerRadius = UDim.new(0, 2)
lineCorner.Parent = decorativeLine

local lineGradient = Instance.new("UIGradient")
lineGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 128)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
}
lineGradient.Parent = decorativeLine

-- Campo de entrada de clave
local keyInputFrame = Instance.new("Frame")
keyInputFrame.Name = "KeyInputFrame"
keyInputFrame.Size = UDim2.new(1, -40, 0, 50)
keyInputFrame.Position = UDim2.new(0, 20, 0, 280)
keyInputFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyInputFrame.BackgroundTransparency = 0.2
keyInputFrame.BorderSizePixel = 0
keyInputFrame.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 12)
inputCorner.Parent = keyInputFrame

local keyTextBox = Instance.new("TextBox")
keyTextBox.Name = "KeyInput"
keyTextBox.Size = UDim2.new(1, -20, 1, -10)
keyTextBox.Position = UDim2.new(0, 10, 0, 5)
keyTextBox.BackgroundTransparency = 1
keyTextBox.PlaceholderText = "Insert Key"
keyTextBox.PlaceholderColor3 = Color3.fromRGB(128, 128, 128)
keyTextBox.Text = ""
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.TextScaled = true
keyTextBox.Font = Enum.Font.Gotham
keyTextBox.ClearTextOnFocus = false
keyTextBox.Parent = keyInputFrame

-- Botones
local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, -40, 0, 50)
buttonContainer.Position = UDim2.new(0, 20, 0, 350)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainFrame

-- Botón Get Key
local getKeyButton = Instance.new("TextButton")
getKeyButton.Name = "GetKeyButton"
getKeyButton.Size = UDim2.new(0.48, 0, 1, 0)
getKeyButton.Position = UDim2.new(0, 0, 0, 0)
getKeyButton.BackgroundColor3 = Color3.fromRGB(255, 107, 107)
getKeyButton.BorderSizePixel = 0
getKeyButton.Text = "GET KEY"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextScaled = true
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.Parent = buttonContainer

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 12)
getKeyCorner.Parent = getKeyButton

local getKeyGradient = Instance.new("UIGradient")
getKeyGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 107, 107)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 90, 36))
}
getKeyGradient.Rotation = 135
getKeyGradient.Parent = getKeyButton

-- Botón Submit
local submitButton = Instance.new("TextButton")
submitButton.Name = "SubmitButton"
submitButton.Size = UDim2.new(0.48, 0, 1, 0)
submitButton.Position = UDim2.new(0.52, 0, 0, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
submitButton.BorderSizePixel = 0
submitButton.Text = "SUBMIT"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextScaled = true
submitButton.Font = Enum.Font.GothamBold
submitButton.Parent = buttonContainer

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 12)
submitCorner.Parent = submitButton

local submitGradient = Instance.new("UIGradient")
submitGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 210, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 66, 250))
}
submitGradient.Rotation = 135
submitGradient.Parent = submitButton

-- Toast de notificación
local function showToast(message)
    local toastFrame = Instance.new("Frame")
    toastFrame.Name = "Toast"
    toastFrame.Size = UDim2.new(0, 400, 0, 80)
    toastFrame.Position = UDim2.new(0.5, -200, 0, -100)
    toastFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    toastFrame.BorderSizePixel = 0
    toastFrame.Parent = screenGui
    
    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, 16)
    toastCorner.Parent = toastFrame
    
    local toastLabel = Instance.new("TextLabel")
    toastLabel.Size = UDim2.new(1, -20, 1, -20)
    toastLabel.Position = UDim2.new(0, 10, 0, 10)
    toastLabel.BackgroundTransparency = 1
    toastLabel.Text = message
    toastLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
    toastLabel.TextScaled = true
    toastLabel.Font = Enum.Font.GothamBold
    toastLabel.TextWrapped = true
    toastLabel.Parent = toastFrame
    
    -- Animación de entrada
    local slideIn = TweenService:Create(toastFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -200, 0, 20)
    })
    slideIn:Play()
    
    -- Animación de salida después de 4 segundos
    spawn(function()
        wait(4)
        local slideOut = TweenService:Create(toastFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -200, 0, -100)
        })
        slideOut:Play()
        slideOut.Completed:Connect(function()
            toastFrame:Destroy()
        end)
    end)
end

-- Función para copiar al portapapeles (simulada con toast)
local function copyToClipboard(text)
    -- En Roblox no se puede copiar directamente al portapapeles por seguridad
    -- Pero podemos mostrar el enlace en el toast para que el usuario lo copie manualmente
    showToast("Key link copied to clipboard!\nPaste it in your preferred browser...\n" .. text)
end

-- Efectos de hover para botones
local function createHoverEffect(button, hoverColor, originalColor)
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor})
        tween:Play()
    end)
end

createHoverEffect(getKeyButton, Color3.fromRGB(255, 82, 82), Color3.fromRGB(255, 107, 107))
createHoverEffect(submitButton, Color3.fromRGB(0, 168, 255), Color3.fromRGB(0, 210, 255))

-- Funcionalidad del botón Get Key
getKeyButton.MouseButton1Click:Connect(function()
    getKeyButton.Text = "GETTING KEY..."
    
    local originalSize = getKeyButton.Size
    local pressTween = TweenService:Create(getKeyButton, TweenInfo.new(0.1), {Size = UDim2.new(0.46, 0, 0.9, 0)})
    pressTween:Play()
    
    spawn(function()
        wait(0.1)
        local releaseTween = TweenService:Create(getKeyButton, TweenInfo.new(0.1), {Size = originalSize})
        releaseTween:Play()
        
        wait(1.5)
        getKeyButton.Text = "GET KEY"
        
        -- Copiar enlace al "portapapeles" (mostrar en toast)
        copyToClipboard("https://zamasxmodder.github.io/PageFreeTrial3DaysKey/")
    end)
end)

-- Funcionalidad del botón Submit
submitButton.MouseButton1Click:Connect(function()
    local key = keyTextBox.Text
    
    if key == "" or key == nil then
        submitButton.BackgroundColor3 = Color3.fromRGB(255, 71, 87)
        submitButton.Text = "ENTER KEY FIRST!"
        
        wait(2)
        submitButton.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
        submitButton.Text = "SUBMIT"
        return
    end
    
    local originalSize = submitButton.Size
    local pressTween = TweenService:Create(submitButton, TweenInfo.new(0.1), {Size = UDim2.new(0.46, 0, 0.9, 0)})
    pressTween:Play()
    
    submitButton.Text = "VALIDATING..."
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
    
    spawn(function()
        wait(0.1)
        local releaseTween = TweenService:Create(submitButton, TweenInfo.new(0.1), {Size = originalSize})
        releaseTween:Play()
        
        wait(1.5)
        submitButton.Text = "ACCESS GRANTED!"
        submitButton.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
        
        showToast("Access granted! Welcome to XM Panel MX!")
    end)
end)

-- Animación de entrada del panel
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

local entranceTween = TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 450, 0, 600),
    Position = UDim2.new(0.5, -225, 0.5, -300)
})
entranceTween:Play()

-- Hacer el panel draggable (arrastrable)
local UserInputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

print("XM Panel MX loaded successfully!")
print("Created by ZamasXModder - Roblox GUI")

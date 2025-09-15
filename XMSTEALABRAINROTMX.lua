-- XM StealAbrainrot MX GUI Panel - Fixed Version
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Función para debug
local function debugPrint(message)
    print("[XM GUI Debug] " .. tostring(message))
end

debugPrint("Starting GUI creation...")

-- Crear ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMStealAbrainrotPanel"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 100

debugPrint("ScreenGui created")

-- GUI de fondo que cubre toda la pantalla
local backgroundGui = Instance.new("Frame")
backgroundGui.Name = "BackgroundOverlay"
backgroundGui.Size = UDim2.new(1, 0, 1, 0)
backgroundGui.Position = UDim2.new(0, 0, 0, 0)
backgroundGui.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
backgroundGui.BackgroundTransparency = 0.3
backgroundGui.BorderSizePixel = 0
backgroundGui.Parent = screenGui
backgroundGui.ZIndex = 1

-- Efecto de blur/gradiente en el fondo
local backgroundGradient = Instance.new("UIGradient")
backgroundGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.2),
    NumberSequenceKeypoint.new(0.5, 0.4),
    NumberSequenceKeypoint.new(1, 0.2)
})
backgroundGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 50, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 50, 25))
})
backgroundGradient.Parent = backgroundGui

debugPrint("Background created")

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 450, 0, 550)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
mainFrame.ZIndex = 10

debugPrint("MainFrame created")

-- Crear esquinas redondeadas para el frame principal
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

-- Sombra del panel principal
local shadowFrame = Instance.new("Frame")
shadowFrame.Name = "ShadowFrame"
shadowFrame.Size = UDim2.new(1, 10, 1, 10)
shadowFrame.Position = UDim2.new(0, -5, 0, -5)
shadowFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
shadowFrame.BackgroundTransparency = 0.8
shadowFrame.BorderSizePixel = 0
shadowFrame.Parent = mainFrame
shadowFrame.ZIndex = mainFrame.ZIndex - 1

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 25)
shadowCorner.Parent = shadowFrame

-- Borde animado mejorado
local borderStroke = Instance.new("UIStroke")
borderStroke.Thickness = 4
borderStroke.Color = Color3.fromRGB(0, 255, 127)
borderStroke.Parent = mainFrame

local borderGradient = Instance.new("UIGradient")
borderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 255, 127)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 255, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
borderGradient.Parent = borderStroke

-- Efecto de brillo interno
local glowFrame = Instance.new("Frame")
glowFrame.Name = "GlowFrame"
glowFrame.Size = UDim2.new(1, -8, 1, -8)
glowFrame.Position = UDim2.new(0, 4, 0, 4)
glowFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
glowFrame.BackgroundTransparency = 0.95
glowFrame.BorderSizePixel = 0
glowFrame.Parent = mainFrame
glowFrame.ZIndex = mainFrame.ZIndex + 1

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 16)
glowCorner.Parent = glowFrame

debugPrint("Frame styling complete")

-- Título principal con efectos
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 15)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM StealAbrainrot MX"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame
titleLabel.ZIndex = 15

-- Efecto de sombra en el título
local titleStroke = Instance.new("UIStroke")
titleStroke.Thickness = 2
titleStroke.Color = Color3.fromRGB(0, 0, 0)
titleStroke.Parent = titleLabel

-- Subtítulo con efectos
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, 0, 0, 25)
subtitleLabel.Position = UDim2.new(0, 0, 0, 65)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "free trial 3 days"
subtitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Parent = mainFrame
subtitleLabel.ZIndex = 15

-- Línea decorativa bajo el título
local decorLine = Instance.new("Frame")
decorLine.Name = "DecorLine"
decorLine.Size = UDim2.new(0.8, 0, 0, 2)
decorLine.Position = UDim2.new(0.1, 0, 0, 95)
decorLine.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
decorLine.BorderSizePixel = 0
decorLine.Parent = mainFrame
decorLine.ZIndex = 15

local lineGradient = Instance.new("UIGradient")
lineGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 127)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
lineGradient.Parent = decorLine

debugPrint("Title elements created")

-- Frame de información del jugador mejorado
local playerFrame = Instance.new("Frame")
playerFrame.Name = "PlayerFrame"
playerFrame.Size = UDim2.new(0.9, 0, 0, 140)
playerFrame.Position = UDim2.new(0.05, 0, 0, 110)
playerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
playerFrame.BorderSizePixel = 0
playerFrame.Parent = mainFrame
playerFrame.ZIndex = 12

local playerCorner = Instance.new("UICorner")
playerCorner.CornerRadius = UDim.new(0, 15)
playerCorner.Parent = playerFrame

-- Borde del frame del jugador
local playerStroke = Instance.new("UIStroke")
playerStroke.Thickness = 1
playerStroke.Color = Color3.fromRGB(0, 255, 127)
playerStroke.Transparency = 0.7
playerStroke.Parent = playerFrame

-- Avatar del jugador con efectos
local avatarFrame = Instance.new("Frame")
avatarFrame.Name = "AvatarFrame"
avatarFrame.Size = UDim2.new(0, 90, 0, 90)
avatarFrame.Position = UDim2.new(0, 20, 0, 25)
avatarFrame.BackgroundTransparency = 1
avatarFrame.Parent = playerFrame
avatarFrame.ZIndex = 13

local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.Size = UDim2.new(1, 0, 1, 0)
avatarImage.Position = UDim2.new(0, 0, 0, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
avatarImage.Parent = avatarFrame
avatarImage.ZIndex = 14

-- Hacer el avatar circular
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatarImage

-- Borde brillante del avatar
local avatarStroke = Instance.new("UIStroke")
avatarStroke.Thickness = 3
avatarStroke.Color = Color3.fromRGB(0, 255, 127)
avatarStroke.Parent = avatarImage

debugPrint("Avatar created")

-- Información del jugador con efectos
local displayNameLabel = Instance.new("TextLabel")
displayNameLabel.Name = "DisplayNameLabel"
displayNameLabel.Size = UDim2.new(0.55, 0, 0, 30)
displayNameLabel.Position = UDim2.new(0.4, 10, 0, 25)
displayNameLabel.BackgroundTransparency = 1
displayNameLabel.Text = player.DisplayName
displayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
displayNameLabel.TextScaled = true
displayNameLabel.Font = Enum.Font.GothamBold
displayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
displayNameLabel.Parent = playerFrame
displayNameLabel.ZIndex = 15

local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "UsernameLabel"
usernameLabel.Size = UDim2.new(0.55, 0, 0, 25)
usernameLabel.Position = UDim2.new(0.4, 10, 0, 55)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = "@" .. player.Name
usernameLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
usernameLabel.TextScaled = true
usernameLabel.Font = Enum.Font.Gotham
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.Parent = playerFrame
usernameLabel.ZIndex = 15

local countryLabel = Instance.new("TextLabel")
countryLabel.Name = "CountryLabel"
countryLabel.Size = UDim2.new(0.55, 0, 0, 25)
countryLabel.Position = UDim2.new(0.4, 10, 0, 85)
countryLabel.BackgroundTransparency = 1
countryLabel.Text = "Colombia"
countryLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
countryLabel.TextScaled = true
countryLabel.Font = Enum.Font.Gotham
countryLabel.TextXAlignment = Enum.TextXAlignment.Left
countryLabel.Parent = playerFrame
countryLabel.ZIndex = 15

debugPrint("Player info labels created")

-- TextBox para la key con efectos
local keyTextBox = Instance.new("TextBox")
keyTextBox.Name = "KeyTextBox"
keyTextBox.Size = UDim2.new(0.9, 0, 0, 45)
keyTextBox.Position = UDim2.new(0.05, 0, 0, 270)
keyTextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
keyTextBox.BorderSizePixel = 0
keyTextBox.PlaceholderText = "paste your key here..."
keyTextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
keyTextBox.Text = ""
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.TextScaled = true
keyTextBox.Font = Enum.Font.Gotham
keyTextBox.Parent = mainFrame
keyTextBox.ZIndex = 15

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0, 10)
keyBoxCorner.Parent = keyTextBox

local keyBoxStroke = Instance.new("UIStroke")
keyBoxStroke.Thickness = 2
keyBoxStroke.Color = Color3.fromRGB(0, 255, 127)
keyBoxStroke.Transparency = 0.7
keyBoxStroke.Parent = keyTextBox

-- Botones con efectos mejorados
local getKeyButton = Instance.new("TextButton")
getKeyButton.Name = "GetKeyButton"
getKeyButton.Size = UDim2.new(0.43, 0, 0, 45)
getKeyButton.Position = UDim2.new(0.05, 0, 0, 335)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
getKeyButton.BorderSizePixel = 0
getKeyButton.Text = "Get Key"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextScaled = true
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.Parent = mainFrame
getKeyButton.ZIndex = 15

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 10)
getKeyCorner.Parent = getKeyButton

local getKeyStroke = Instance.new("UIStroke")
getKeyStroke.Thickness = 2
getKeyStroke.Color = Color3.fromRGB(0, 255, 127)
getKeyStroke.Parent = getKeyButton

local submitButton = Instance.new("TextButton")
submitButton.Name = "SubmitButton"
submitButton.Size = UDim2.new(0.43, 0, 0, 45)
submitButton.Position = UDim2.new(0.52, 0, 0, 335)
submitButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
submitButton.BorderSizePixel = 0
submitButton.Text = "Submit"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextScaled = true
submitButton.Font = Enum.Font.GothamBold
submitButton.TextSize = 16 -- Texto más pequeño
submitButton.Parent = mainFrame
submitButton.ZIndex = 15

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 10)
submitCorner.Parent = submitButton

local submitStroke = Instance.new("UIStroke")
submitStroke.Thickness = 2
submitStroke.Color = Color3.fromRGB(100, 100, 100)
submitStroke.Parent = submitButton

-- Botón de cerrar
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame
closeButton.ZIndex = 20

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

debugPrint("UI elements created")

-- Función para crear partículas flotantes
local function createFloatingParticles()
    for i = 1, 15 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle" .. i
        particle.Size = UDim2.new(0, math.random(4, 10), 0, math.random(4, 10))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromRGB(0, math.random(150, 255), math.random(100, 200))
        particle.BorderSizePixel = 0
        particle.BackgroundTransparency = math.random(30, 70) / 100
        particle.Parent = backgroundGui
        particle.ZIndex = 2
        
        local particleCorner = Instance.new("UICorner")
        particleCorner.CornerRadius = UDim.new(1, 0)
        particleCorner.Parent = particle
        
        -- Animación flotante continua
        spawn(function()
            while particle.Parent do
                local floatTween = TweenService:Create(
                    particle,
                    TweenInfo.new(math.random(8, 15), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    {
                        Position = UDim2.new(
                            math.random() * 0.8 + 0.1,
                            0,
                            math.random() * 0.8 + 0.1,
                            0
                        ),
                        BackgroundTransparency = math.random(10, 90) / 100
                    }
                )
                floatTween:Play()
                floatTween.Completed:Wait()
            end
        end)
    end
end

-- Crear decoraciones en las esquinas
local function createCornerDecorations()
    local corners = {
        {UDim2.new(0, 20, 0, 20), "TopLeft"},
        {UDim2.new(1, -120, 0, 20), "TopRight"},
        {UDim2.new(0, 20, 1, -120), "BottomLeft"},
        {UDim2.new(1, -120, 1, -120), "BottomRight"}
    }
    
    for _, corner in pairs(corners) do
        local decorFrame = Instance.new("Frame")
        decorFrame.Name = corner[2] .. "Decoration"
        decorFrame.Size = UDim2.new(0, 100, 0, 100)
        decorFrame.Position = corner[1]
        decorFrame.BackgroundTransparency = 1
        decorFrame.Parent = backgroundGui
        decorFrame.ZIndex = 2
        
        -- Crear círculos concéntricos
        for i = 1, 3 do
            local circle = Instance.new("Frame")
            circle.Name = "Circle" .. i
            circle.Size = UDim2.new(0, 30 + (i * 20), 0, 30 + (i * 20))
            circle.Position = UDim2.new(0.5, -(15 + i * 10), 0.5, -(15 + i * 10))
            circle.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
            circle.BackgroundTransparency = 0.3 + (i * 0.2)
            circle.BorderSizePixel = 0
            circle.Parent = decorFrame
            
            local circleCorner = Instance.new("UICorner")
            circleCorner.CornerRadius = UDim.new(1, 0)
            circleCorner.Parent = circle
            
            -- Animación de pulsación
            spawn(function()
                while circle.Parent do
                    local pulseTween = TweenService:Create(
                        circle,
                        TweenInfo.new(2 + i, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        {
                            Size = UDim2.new(0, (30 + i * 20) * 1.3, 0, (30 + i * 20) * 1.3),
                            BackgroundTransparency = 0.8
                        }
                    )
                    pulseTween:Play()
                    pulseTween.Completed:Wait()
                    
                    local pulseTweenBack = TweenService:Create(
                        circle,
                        TweenInfo.new(2 + i, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        {
                            Size = UDim2.new(0, 30 + (i * 20), 0, 30 + (i * 20)),
                            BackgroundTransparency = 0.3 + (i * 0.2)
                        }
                    )
                    pulseTweenBack:Play()
                    pulseTweenBack.Completed:Wait()
                end
            end)
        end
        
        -- Rotación del conjunto
        spawn(function()
            while decorFrame.Parent do
                local rotateTween = TweenService:Create(
                    decorFrame,
                    TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
                    {Rotation = 360}
                )
                rotateTween:Play()
                rotateTween.Completed:Wait()
                decorFrame.Rotation = 0
            end
        end)
    end
end

debugPrint("Effect functions created")

-- Función para crear toast mejorado
local function createToast(message)
    spawn(function()
        local toastGui = Instance.new("ScreenGui")
        toastGui.Name = "ToastNotification"
        toastGui.Parent = playerGui
        toastGui.DisplayOrder = 200
        
        local toastFrame = Instance.new("Frame")
        toastFrame.Size = UDim2.new(0, 450, 0, 70)
        toastFrame.Position = UDim2.new(0.5, -225, 1, -50)
        toastFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        toastFrame.BorderSizePixel = 0
        toastFrame.Parent = toastGui
        
        local toastCorner = Instance.new("UICorner")
        toastCorner.CornerRadius = UDim.new(0, 15)
        toastCorner.Parent = toastFrame
        
        local toastStroke = Instance.new("UIStroke")
        toastStroke.Thickness = 3
        toastStroke.Color = Color3.fromRGB(0, 255, 127)
        toastStroke.Parent = toastFrame
        
        local toastLabel = Instance.new("TextLabel")
        toastLabel.Size = UDim2.new(1, -20, 1, 0)
        toastLabel.Position = UDim2.new(0, 10, 0, 0)
        toastLabel.BackgroundTransparency = 1
        toastLabel.Text = message
        toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        toastLabel.TextScaled = true
        toastLabel.Font = Enum.Font.Gotham
        toastLabel.TextWrapped = true
        toastLabel.Parent = toastFrame
        
        -- Animación de entrada del toast
        local tweenIn = TweenService:Create(
            toastFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.5, -225, 1, -160)}
        )
        tweenIn:Play()
        
        -- Esperar y hacer animación de salida
        wait(4)
        local tweenOut = TweenService:Create(
            toastFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Position = UDim2.new(0.5, -225, 1, 50)}
        )
        tweenOut:Play()
        
        tweenOut.Completed:Connect(function()
            toastGui:Destroy()
        end)
    end)
end

-- Event listeners con efectos mejorados
getKeyButton.MouseButton1Click:Connect(function()
    local keyUrl = "https://zamasxmodder.github.io/Maintenanse/"
    
    pcall(function()
        setclipboard(keyUrl)
    end)
    
    createToast("Key copied to clipboard! Go to your preferred browser and paste it there...")
    
    -- Animación de click
    local originalSize = getKeyButton.Size
    local clickTween1 = TweenService:Create(
        getKeyButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {
            Size = UDim2.new(originalSize.X.Scale * 0.95, 0, originalSize.Y.Scale, originalSize.Y.Offset * 0.95),
            BackgroundColor3 = Color3.fromRGB(0, 255, 127)
        }
    )
    clickTween1:Play()
    
    clickTween1.Completed:Connect(function()
        local clickTween2 = TweenService:Create(
            getKeyButton,
            TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {
                Size = originalSize,
                BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            }
        )
        clickTween2:Play()
    end)
end)

submitButton.MouseButton1Click:Connect(function()
    local keyText = keyTextBox.Text
    if keyText ~= "" and keyText ~= keyTextBox.PlaceholderText then
        createToast("Key submitted successfully! Validating...")
        debugPrint("Key submitted: " .. keyText)
    else
        createToast("Please enter a valid key!")
    end
end)

-- Efectos hover
getKeyButton.MouseEnter:Connect(function()
    TweenService:Create(getKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 220, 110)}):Play()
end)

getKeyButton.MouseLeave:Connect(function()
    TweenService:Create(getKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
end)

submitButton.MouseEnter:Connect(function()
    TweenService:Create(submitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}):Play()
end)

submitButton.MouseLeave:Connect(function()
    TweenService:Create(submitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
end)

-- Botón de cerrar
closeButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    closeTween:Play()
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

-- Animaciones automáticas
spawn(function()
    while screenGui.Parent do
        -- Animación del borde
        local borderTween = TweenService:Create(
            borderGradient,
            TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
            {Rotation = 360}
        )
        borderTween:Play()
        borderTween.Completed:Wait()
        borderGradient.Rotation = 0
    end
end)

-- Crear efectos
createFloatingParticles()
createCornerDecorations()

debugPrint("GUI loaded successfully!")

print("XM StealAbrainrot MX GUI Enhanced loaded successfully!")

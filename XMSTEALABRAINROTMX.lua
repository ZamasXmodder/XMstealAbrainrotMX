local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- VERIFICACIÓN DE CUENTA NUEVA
local function checkAccountAge()
    local accountAge = player.AccountAge -- Días desde que se creó la cuenta
    local minimumDays = 2
    
    if accountAge < minimumDays then
        return false -- Cuenta muy nueva
    end
    return true -- Cuenta válida
end

-- Función para mostrar mensaje de cuenta no autorizada
local function showUnauthorizedMessage()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UnauthorizedGUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui
    
    -- Fondo rojo semi-transparente
    local backgroundFrame = Instance.new("Frame")
    backgroundFrame.Name = "BackgroundFrame"
    backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
    backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
    backgroundFrame.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
    backgroundFrame.BackgroundTransparency = 0.4
    backgroundFrame.BorderSizePixel = 0
    backgroundFrame.Parent = screenGui
    
    -- Decoraciones de advertencia en las esquinas
    local function createWarningDecoration(position, rotation)
        local decoration = Instance.new("Frame")
        decoration.Size = UDim2.new(0, 80, 0, 80)
        decoration.Position = position
        decoration.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        decoration.BorderSizePixel = 0
        decoration.Rotation = rotation
        decoration.Parent = backgroundFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 15)
        corner.Parent = decoration
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255, 50, 50)
        stroke.Thickness = 3
        stroke.Parent = decoration
        
        return decoration
    end
    
    -- Crear decoraciones de advertencia
    local warnDecor1 = createWarningDecoration(UDim2.new(0, 20, 0, 20), 45)
    local warnDecor2 = createWarningDecoration(UDim2.new(1, -100, 0, 20), 45)
    local warnDecor3 = createWarningDecoration(UDim2.new(0, 20, 1, -100), 45)
    local warnDecor4 = createWarningDecoration(UDim2.new(1, -100, 1, -100), 45)
    
    -- Panel de mensaje
    local messagePanel = Instance.new("Frame")
    messagePanel.Name = "MessagePanel"
    messagePanel.Size = UDim2.new(0, 450, 0, 350)
    messagePanel.Position = UDim2.new(0.5, -225, 0.5, -175)
    messagePanel.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    messagePanel.BorderSizePixel = 0
    messagePanel.Parent = screenGui
    
    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 20)
    panelCorner.Parent = messagePanel
    
    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = Color3.fromRGB(255, 0, 0)
    panelStroke.Thickness = 4
    panelStroke.Parent = messagePanel
    
    -- Sombra del panel
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    shadow.BackgroundTransparency = 0.8
    shadow.BorderSizePixel = 0
    shadow.ZIndex = messagePanel.ZIndex - 1
    shadow.Parent = messagePanel
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 25)
    shadowCorner.Parent = shadow
    
    -- Contenedor para organizar elementos
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -40, 1, -40)
    container.Position = UDim2.new(0, 20, 0, 20)
    container.BackgroundTransparency = 1
    container.Parent = messagePanel
    
    -- Icono de advertencia grande
    local warningIcon = Instance.new("TextLabel")
    warningIcon.Size = UDim2.new(0, 100, 0, 100)
    warningIcon.Position = UDim2.new(0.5, -50, 0, 10)
    warningIcon.BackgroundTransparency = 1
    warningIcon.Text = "⚠️"
    warningIcon.TextColor3 = Color3.fromRGB(255, 0, 0)
    warningIcon.TextSize = 60
    warningIcon.Font = Enum.Font.GothamBold
    warningIcon.Parent = container
    
    -- Título del mensaje
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 120)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "CUENTA NUEVA NO AUTORIZADA"
    titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = container
    
    -- Mensaje descriptivo
    local descriptionLabel = Instance.new("TextLabel")
    descriptionLabel.Size = UDim2.new(1, 0, 0, 80)
    descriptionLabel.Position = UDim2.new(0, 0, 0, 180)
    descriptionLabel.BackgroundTransparency = 1
    descriptionLabel.Text = "Tu cuenta debe tener al menos 2 días de antigüedad\npara usar este script.\n\nDías de tu cuenta: " .. player.AccountAge .. " días"
    descriptionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    descriptionLabel.TextSize = 14
    descriptionLabel.Font = Enum.Font.Gotham
    descriptionLabel.TextWrapped = true
    descriptionLabel.TextXAlignment = Enum.TextXAlignment.Center
    descriptionLabel.Parent = container
    
    -- Botón de cerrar
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 150, 0, 45)
    closeButton.Position = UDim2.new(0.5, -75, 1, -65)
    closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "CERRAR"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = container
    
    local closeButtonCorner = Instance.new("UICorner")
    closeButtonCorner.CornerRadius = UDim.new(0, 10)
    closeButtonCorner.Parent = closeButton
    
    local closeButtonStroke = Instance.new("UIStroke")
    closeButtonStroke.Color = Color3.fromRGB(255, 0, 0)
    closeButtonStroke.Thickness = 2
    closeButtonStroke.Parent = closeButton
    
    -- Efecto hover para el botón cerrar
    closeButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        })
        tween:Play()
    end)
    
    closeButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        })
        tween:Play()
    end)
    
    -- Funcionalidad del botón cerrar
    closeButton.MouseButton1Click:Connect(function()
        local exitTween = TweenService:Create(messagePanel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -225, -1.5, 0)
        })
        exitTween:Play()
        exitTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
    
    -- Animación de entrada del panel
    messagePanel.Position = UDim2.new(0.5, -225, -1.5, 0)
    local panelTween = TweenService:Create(messagePanel, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -225, 0.5, -175)
    })
    panelTween:Play()
    
    -- Animación de las decoraciones
    for i, decoration in pairs({warnDecor1, warnDecor2, warnDecor3, warnDecor4}) do
        decoration.Size = UDim2.new(0, 0, 0, 0)
        spawn(function()
            wait(i * 0.1)
            local sizeTween = TweenService:Create(decoration, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 80, 0, 80)
            })
            sizeTween:Play()
        end)
    end
    
    -- Efecto pulsante del borde
    spawn(function()
        while messagePanel.Parent do
            local tween1 = TweenService:Create(panelStroke, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Transparency = 0.5
            })
            tween1:Play()
            tween1.Completed:Wait()
            
            local tween2 = TweenService:Create(panelStroke, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Transparency = 0
            })
            tween2:Play()
            tween2.Completed:Wait()
        end
    end)
    
    -- Rotación de las decoraciones
    spawn(function()
        while backgroundFrame.Parent do
            for _, decoration in pairs({warnDecor1, warnDecor2, warnDecor3, warnDecor4}) do
                local rotateTween = TweenService:Create(decoration, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                    Rotation = decoration.Rotation + 360
                })
                rotateTween:Play()
            end
            wait(3)
        end
    end)
    
    return
end

-- VERIFICAR EDAD DE LA CUENTA ANTES DE CONTINUAR
if not checkAccountAge() then
    showUnauthorizedMessage()
    return -- Detener la ejecución del script principal
end

-- ================================
-- AQUÍ CONTINÚA EL SCRIPT ORIGINAL
-- ================================

-- Crear ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModernPanelGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Background que cubre toda la pantalla
local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
background.BackgroundTransparency = 0.3
background.BorderSizePixel = 0
background.Parent = screenGui

-- Función para crear decoraciones en las esquinas (sin ImageLabel)
local function createCornerDecoration(position, rotation)
    local decoration = Instance.new("Frame")
    decoration.Size = UDim2.new(0, 60, 0, 60)
    decoration.Position = position
    decoration.BackgroundColor3 = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
    decoration.BorderSizePixel = 0
    decoration.Rotation = rotation
    decoration.Parent = background
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = decoration
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
    stroke.Thickness = 2
    stroke.Parent = decoration
    
    return decoration
end

-- Crear decoraciones en las esquinas
local topLeft = createCornerDecoration(UDim2.new(0, 20, 0, 20), 45)
local topRight = createCornerDecoration(UDim2.new(1, -80, 0, 20), 45)
local bottomLeft = createCornerDecoration(UDim2.new(0, 20, 1, -80), 45)
local bottomRight = createCornerDecoration(UDim2.new(1, -80, 1, -80), 45)

-- Decoraciones adicionales en los bordes
local function createEdgeDecoration(position, size)
    local decoration = Instance.new("Frame")
    decoration.Size = size
    decoration.Position = position
    decoration.BackgroundColor3 = Color3.fromRGB(100, 0, 0) -- Rojo más oscuro
    decoration.BorderSizePixel = 0
    decoration.Rotation = 45
    decoration.Parent = background
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = decoration
end

-- Decoraciones adicionales
createEdgeDecoration(UDim2.new(0.5, -15, 0, 10), UDim2.new(0, 30, 0, 30))
createEdgeDecoration(UDim2.new(0.5, -15, 1, -40), UDim2.new(0, 30, 0, 30))
createEdgeDecoration(UDim2.new(0, 10, 0.5, -15), UDim2.new(0, 30, 0, 30))
createEdgeDecoration(UDim2.new(1, -40, 0.5, -15), UDim2.new(0, 30, 0, 30))

-- Panel principal
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 400, 0, 500)
mainPanel.Position = UDim2.new(0.5, -200, 0.5, -250)
mainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui

-- Esquinas redondeadas del panel
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 20)
panelCorner.Parent = mainPanel

-- Borde neon del panel
local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
panelStroke.Thickness = 3
panelStroke.Parent = mainPanel

-- Efecto de sombra del panel
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
shadow.BackgroundTransparency = 0.8
shadow.BorderSizePixel = 0
shadow.ZIndex = mainPanel.ZIndex - 1
shadow.Parent = mainPanel

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 25)
shadowCorner.Parent = shadow

-- Contenedor para organizar elementos
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -40, 1, -40)
container.Position = UDim2.new(0, 20, 0, 20)
container.BackgroundTransparency = 1
container.Parent = mainPanel

-- Headshot del jugador
local headshot = Instance.new("ImageLabel")
headshot.Size = UDim2.new(0, 80, 0, 80)
headshot.Position = UDim2.new(0, 0, 0, 0)
headshot.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
headshot.BorderSizePixel = 0
headshot.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
headshot.Parent = container

local headshotCorner = Instance.new("UICorner")
headshotCorner.CornerRadius = UDim.new(0, 15)
headshotCorner.Parent = headshot

local headshotStroke = Instance.new("UIStroke")
headshotStroke.Color = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
headshotStroke.Thickness = 2
headshotStroke.Parent = headshot

-- Información del jugador
local playerInfo = Instance.new("Frame")
playerInfo.Size = UDim2.new(1, -100, 0, 80)
playerInfo.Position = UDim2.new(0, 100, 0, 0)
playerInfo.BackgroundTransparency = 1
playerInfo.Parent = container

-- Nombre del jugador (texto más pequeño)
local playerName = Instance.new("TextLabel")
playerName.Size = UDim2.new(1, 0, 0, 22)
playerName.Position = UDim2.new(0, 0, 0, 0)
playerName.BackgroundTransparency = 1
playerName.Text = player.DisplayName
playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
playerName.TextSize = 16
playerName.Font = Enum.Font.GothamBold
playerName.TextXAlignment = Enum.TextXAlignment.Left
playerName.Parent = playerInfo

-- Username del jugador (texto más pequeño)
local username = Instance.new("TextLabel")
username.Size = UDim2.new(1, 0, 0, 18)
username.Position = UDim2.new(0, 0, 0, 22)
username.BackgroundTransparency = 1
username.Text = "@" .. player.Name
username.TextColor3 = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
username.TextSize = 12
username.Font = Enum.Font.Gotham
username.TextXAlignment = Enum.TextXAlignment.Left
username.Parent = playerInfo

-- País (simulado) (texto más pequeño)
local country = Instance.new("TextLabel")
country.Size = UDim2.new(1, 0, 0, 15)
country.Position = UDim2.new(0, 0, 0, 40)
country.BackgroundTransparency = 1
country.Text = "🌍 Global"
country.TextColor3 = Color3.fromRGB(200, 200, 200)
country.TextSize = 10
country.Font = Enum.Font.Gotham
country.TextXAlignment = Enum.TextXAlignment.Left
country.Parent = playerInfo

-- Status (texto más pequeño)
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 15)
status.Position = UDim2.new(0, 0, 0, 55)
status.BackgroundTransparency = 1
status.Text = "🔴 Online"
status.TextColor3 = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
status.TextSize = 10
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = playerInfo

-- Título principal (texto más pequeño)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 110)
title.BackgroundTransparency = 1
title.Text = "XMStealAbrainrotMX"
title.TextColor3 = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = container

-- Subtítulo (texto más pequeño)
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 155)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Trial 3 days..."
subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.Parent = container

-- Campo de entrada de clave
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, 0, 0, 50)
keyInput.Position = UDim2.new(0, 0, 0, 210)
keyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
keyInput.BorderSizePixel = 0
keyInput.Text = ""
keyInput.PlaceholderText = "Place your key here..."
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyInput.TextSize = 14
keyInput.Font = Enum.Font.Gotham
keyInput.Parent = container

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 10)
keyInputCorner.Parent = keyInput

local keyInputStroke = Instance.new("UIStroke")
keyInputStroke.Color = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
keyInputStroke.Thickness = 2
keyInputStroke.Parent = keyInput

-- Función para crear toast notification
local function showToast(message)
    local toast = Instance.new("Frame")
    toast.Size = UDim2.new(0, 350, 0, 60)
    toast.Position = UDim2.new(0.5, -175, 1, -120)
    toast.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    toast.BorderSizePixel = 0
    toast.Parent = screenGui
    
    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, 15)
    toastCorner.Parent = toast
    
    local toastStroke = Instance.new("UIStroke")
    toastStroke.Color = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
    toastStroke.Thickness = 2
    toastStroke.Parent = toast
    
    local toastText = Instance.new("TextLabel")
    toastText.Size = UDim2.new(1, -20, 1, -20)
    toastText.Position = UDim2.new(0, 10, 0, 10)
    toastText.BackgroundTransparency = 1
    toastText.Text = message
    toastText.TextColor3 = Color3.fromRGB(255, 255, 255)
    toastText.TextSize = 12
    toastText.Font = Enum.Font.Gotham
    toastText.TextWrapped = true
    toastText.TextXAlignment = Enum.TextXAlignment.Center
    toastText.TextYAlignment = Enum.TextYAlignment.Center
    toastText.Parent = toast
    
    -- Animación de entrada
    toast.Position = UDim2.new(0.5, -175, 1, 50)
    local enterTween = TweenService:Create(toast, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -175, 1, -120)
    })
    enterTween:Play()
    
    -- Auto-destruir después de 4 segundos
    wait(4)
    local exitTween = TweenService:Create(toast, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -175, 1, 50)
    })
    exitTween:Play()
    exitTween.Completed:Connect(function()
        toast:Destroy()
    end)
end

-- Función para crear botones
local function createButton(text, position, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.45, 0, 0, 45)
    button.Position = position
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = container
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
    buttonStroke.Thickness = 2
    buttonStroke.Parent = button
    
    -- Efecto hover
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(color.R * 255 + 20, color.G * 255 + 20, color.B * 255 + 20)})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = color})
        tween:Play()
    end)
    
    return button
end

-- Botón Get Key
local getKeyButton = createButton("Get Key", UDim2.new(0, 0, 0, 280), Color3.fromRGB(50, 50, 70))

-- Botón Submit
local submitButton = createButton("Submit", UDim2.new(0.55, 0, 0, 280), Color3.fromRGB(100, 0, 0)) -- Rojo oscuro

-- Animación de entrada
mainPanel.Position = UDim2.new(0.5, -200, 1.5, 0)
local enterTween = TweenService:Create(mainPanel, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -200, 0.5, -250)
})
enterTween:Play()

-- Animación de las decoraciones
for i, decoration in pairs({topLeft, topRight, bottomLeft, bottomRight}) do
    decoration.Size = UDim2.new(0, 0, 0, 0)
    wait(0.1)
    local sizeTween = TweenService:Create(decoration, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 60, 0, 60)
    })
    sizeTween:Play()
end

-- Funcionalidad del botón Get Key
getKeyButton.MouseButton1Click:Connect(function()
    -- Animación de click
    local clickTween = TweenService:Create(getKeyButton, TweenInfo.new(0.1), {Size = UDim2.new(0.43, 0, 0, 43)})
    clickTween:Play()
    clickTween.Completed:Connect(function()
        local returnTween = TweenService:Create(getKeyButton, TweenInfo.new(0.1), {Size = UDim2.new(0.45, 0, 0, 45)})
        returnTween:Play()
    end)
    
    -- Copiar enlace al portapapeles
    local linkToCopy = "https://zamasxmodder.github.io/Page404StealScript/"
    setclipboard(linkToCopy)
    
    -- Mostrar toast notification
    spawn(function()
        showToast("Link copied! Go and paste it in your preferred browser...")
    end)
    
    print("Get Key button clicked! Link copied to clipboard.")
end)

-- Funcionalidad del botón Submit
submitButton.MouseButton1Click:Connect(function()
    -- Animación de click
    local clickTween = TweenService:Create(submitButton, TweenInfo.new(0.1), {Size = UDim2.new(0.43, 0, 0, 43)})
    clickTween:Play()
    clickTween.Completed:Connect(function()
        local returnTween = TweenService:Create(submitButton, TweenInfo.new(0.1), {Size = UDim2.new(0.45, 0, 0, 45)})
        returnTween:Play()
    end)
    
    -- Validar la clave ingresada
    local enteredKey = keyInput.Text
    if enteredKey ~= "" then
        print("Key submitted:", enteredKey)
        -- Aquí puedes agregar la lógica de validación de la clave
        
        -- Ejemplo de validación simple
        if enteredKey == "VALID_KEY_123" then
            -- Clave válida - cerrar el panel con animación
            local exitTween = TweenService:Create(mainPanel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, -200, -1.5, 0)
            })
            exitTween:Play()
            exitTween.Completed:Connect(function()
                screenGui:Destroy()
            end)
        else
            -- Clave inválida - efecto de error
            local originalColor = keyInputStroke.Color
            keyInputStroke.Color = Color3.fromRGB(255, 50, 50)
            keyInput.Text = ""
            keyInput.PlaceholderText = "Invalid key! Try again..."
            
            wait(2)
            keyInputStroke.Color = originalColor
            keyInput.PlaceholderText = "Place your key here..."
        end
    else
        -- Campo vacío - efecto de advertencia
        keyInput.PlaceholderText = "Please enter a key first!"
        local shakeTween = TweenService:Create(keyInput, TweenInfo.new(0.1), {Position = UDim2.new(0, 5, 0, 210)})
        shakeTween:Play()
        shakeTween.Completed:Connect(function()
            local returnTween = TweenService:Create(keyInput, TweenInfo.new(0.1), {Position = UDim2.new(0, 0, 0, 210)})
            returnTween:Play()
        end)
    end
end)

-- Efecto de respiración para el borde del panel
spawn(function()
    while mainPanel.Parent do
        local breatheTween1 = TweenService:Create(panelStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.3
        })
        breatheTween1:Play()
        breatheTween1.Completed:Wait()
        
        local breatheTween2 = TweenService:Create(panelStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0
        })
        breatheTween2:Play()
        breatheTween2.Completed:Wait()
    end
end)

-- Efecto de rotación para las decoraciones de las esquinas
spawn(function()
    while background.Parent do
        for _, decoration in pairs({topLeft, topRight, bottomLeft, bottomRight}) do
            local rotateTween = TweenService:Create(decoration, TweenInfo.new(4, Enum.EasingStyle.Linear), {
                Rotation = decoration.Rotation + 360
            })
            rotateTween:Play()
        end
        wait(4)
    end
end)

-- Efecto de partículas en el fondo
local function createParticle()
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
    particle.Position = UDim2.new(math.random(), 0, 1.1, 0)
    particle.BackgroundColor3 = Color3.fromRGB(139, 0, 0) -- Rojo oscuro
    particle.BackgroundTransparency = 0.7
    particle.BorderSizePixel = 0
    particle.Parent = background
    
    local particleCorner = Instance.new("UICorner")
    particleCorner.CornerRadius = UDim.new(1, 0)
    particleCorner.Parent = particle
    
    local moveTween = TweenService:Create(particle, TweenInfo.new(math.random(3, 8)), {
        Position = UDim2.new(math.random(), 0, -0.1, 0),
        BackgroundTransparency = 1
    })
    moveTween:Play()
    moveTween.Completed:Connect(function()
        particle:Destroy()
    end)
end

-- Generar partículas continuamente
spawn(function()
    while background.Parent do
        createParticle()
        wait(math.random(1, 3))
    end
end)

-- Responsive design - ajustar para diferentes tamaños de pantalla
local function updateLayout()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local isSmallScreen = viewportSize.X < 800 or viewportSize.Y < 600
    
    if isSmallScreen then
        -- Ajustes para pantallas pequeñas (móvil)
        mainPanel.Size = UDim2.new(0.9, 0, 0.8, 0)
        mainPanel.Position = UDim2.new(0.05, 0, 0.1, 0)
        
        -- Ajustar decoraciones para pantallas pequeñas
        for _, decoration in pairs({topLeft, topRight, bottomLeft, bottomRight}) do
            decoration.Size = UDim2.new(0, 40, 0, 40)
        end
        
        -- Ajustar tamaños de texto para móvil
        playerName.TextSize = 14
        username.TextSize = 10
        country.TextSize = 8
        status.TextSize = 8
        title.TextSize = 20
        subtitle.TextSize = 10
        keyInput.TextSize = 12
        getKeyButton.TextSize = 12
        submitButton.TextSize = 12
    else
        -- Ajustes para pantallas grandes (PC)
        mainPanel.Size = UDim2.new(0, 400, 0, 500)
        mainPanel.Position = UDim2.new(0.5, -200, 0.5, -250)
        
        -- Restaurar tamaño original de decoraciones
        for _, decoration in pairs({topLeft, topRight, bottomLeft, bottomRight}) do
            decoration.Size = UDim2.new(0, 60, 0, 60)
        end
        
        -- Restaurar tamaños de texto originales
        playerName.TextSize = 16
        username.TextSize = 12
        country.TextSize = 10
        status.TextSize = 10
        title.TextSize = 24
        subtitle.TextSize = 12
        keyInput.TextSize = 14
        getKeyButton.TextSize = 14
        submitButton.TextSize = 14
    end
end

-- Actualizar layout al cambiar el tamaño de la ventana
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateLayout)
updateLayout() -- Aplicar ajustes iniciales

-- Cerrar panel con tecla ESC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        local exitTween = TweenService:Create(mainPanel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -200, 1.5, 0)
        })
        exitTween:Play()
        exitTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end
end)

print("Modern Panel GUI loaded successfully! Account verified: " .. player.AccountAge .. " days old.")

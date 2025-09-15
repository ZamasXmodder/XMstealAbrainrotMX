-- XM StealAbrainrot MX GUI
-- Professional Roblox GUI with neon green theme

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalizationService = game:GetService("LocalizationService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMStealAbrainrotGUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Background Frame (covers entire screen including TopBar)
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "BackgroundFrame"
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
backgroundFrame.BorderSizePixel = 0
backgroundFrame.Parent = screenGui

-- Create decorative elements in corners
local function createDecorativeSquare(parent, position, rotation)
    local square = Instance.new("Frame")
    square.Size = UDim2.new(0, 80, 0, 80)
    square.Position = position
    square.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    square.BorderSizePixel = 0
    square.Rotation = rotation
    square.Parent = parent
    
    -- Add rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = square
    
    -- Add neon glow effect
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 255, 127)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = square
    
    return square
end

-- Add decorative squares in corners
createDecorativeSquare(backgroundFrame, UDim2.new(0, -40, 0, -40), 45)
createDecorativeSquare(backgroundFrame, UDim2.new(1, -40, 0, -40), 45)
createDecorativeSquare(backgroundFrame, UDim2.new(0, -40, 1, -40), 45)
createDecorativeSquare(backgroundFrame, UDim2.new(1, -40, 1, -40), 45)

-- Add some additional decorative elements
for i = 1, 6 do
    local randomX = math.random(0, 100) / 100
    local randomY = math.random(0, 100) / 100
    local randomRotation = math.random(0, 360)
    local randomSize = math.random(30, 60)
    
    local decorSquare = Instance.new("Frame")
    decorSquare.Size = UDim2.new(0, randomSize, 0, randomSize)
    decorSquare.Position = UDim2.new(randomX, 0, randomY, 0)
    decorSquare.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    decorSquare.BackgroundTransparency = 0.8
    decorSquare.BorderSizePixel = 0
    decorSquare.Rotation = randomRotation
    decorSquare.Parent = backgroundFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = decorSquare
end

-- Main Panel
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 400, 0, 550)
mainPanel.Position = UDim2.new(0.5, -200, 0.5, -275)
mainPanel.BackgroundColor3 = Color3.fromRGB(20, 40, 25)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui

-- Add rounded corners to main panel
local mainPanelCorner = Instance.new("UICorner")
mainPanelCorner.CornerRadius = UDim.new(0, 15)
mainPanelCorner.Parent = mainPanel

-- Add neon border to main panel
local mainPanelStroke = Instance.new("UIStroke")
mainPanelStroke.Color = Color3.fromRGB(0, 255, 127)
mainPanelStroke.Thickness = 3
mainPanelStroke.Transparency = 0.2
mainPanelStroke.Parent = mainPanel

-- Player Profile Section
local profileFrame = Instance.new("Frame")
profileFrame.Name = "ProfileFrame"
profileFrame.Size = UDim2.new(1, -20, 0, 120)
profileFrame.Position = UDim2.new(0, 10, 0, 10)
profileFrame.BackgroundColor3 = Color3.fromRGB(15, 30, 20)
profileFrame.BorderSizePixel = 0
profileFrame.Parent = mainPanel

local profileCorner = Instance.new("UICorner")
profileCorner.CornerRadius = UDim.new(0, 10)
profileCorner.Parent = profileFrame

-- Player Headshot
local headshot = Instance.new("ImageLabel")
headshot.Name = "Headshot"
headshot.Size = UDim2.new(0, 80, 0, 80)
headshot.Position = UDim2.new(0, 15, 0, 20)
headshot.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
headshot.BorderSizePixel = 0
headshot.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=420&height=420&format=png"
headshot.Parent = profileFrame

local headshotCorner = Instance.new("UICorner")
headshotCorner.CornerRadius = UDim.new(0, 40)
headshotCorner.Parent = headshot

-- Player Name
local playerName = Instance.new("TextLabel")
playerName.Name = "PlayerName"
playerName.Size = UDim2.new(0, 270, 0, 25)
playerName.Position = UDim2.new(0, 110, 0, 20)
playerName.BackgroundTransparency = 1
playerName.Text = player.DisplayName
playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
playerName.TextScaled = true
playerName.Font = Enum.Font.GothamBold
playerName.Parent = profileFrame

-- Player Username
local playerUsername = Instance.new("TextLabel")
playerUsername.Name = "PlayerUsername"
playerUsername.Size = UDim2.new(0, 270, 0, 20)
playerUsername.Position = UDim2.new(0, 110, 0, 45)
playerUsername.BackgroundTransparency = 1
playerUsername.Text = "@"..player.Name
playerUsername.TextColor3 = Color3.fromRGB(0, 255, 127)
playerUsername.TextScaled = true
playerUsername.Font = Enum.Font.Gotham
playerUsername.Parent = profileFrame

-- Get player's country (simplified approach)
local playerCountry = Instance.new("TextLabel")
playerCountry.Name = "PlayerCountry"
playerCountry.Size = UDim2.new(0, 270, 0, 18)
playerCountry.Position = UDim2.new(0, 110, 0, 65)
playerCountry.BackgroundTransparency = 1
playerCountry.Text = "Country: Unknown"
playerCountry.TextColor3 = Color3.fromRGB(200, 200, 200)
playerCountry.TextScaled = true
playerCountry.Font = Enum.Font.Gotham
playerCountry.Parent = profileFrame

-- Player Status
local playerStatus = Instance.new("TextLabel")
playerStatus.Name = "PlayerStatus"
playerStatus.Size = UDim2.new(0, 270, 0, 18)
playerStatus.Position = UDim2.new(0, 110, 0, 83)
playerStatus.BackgroundTransparency = 1
playerStatus.Text = "Status: Online"
playerStatus.TextColor3 = Color3.fromRGB(0, 255, 127)
playerStatus.TextScaled = true
playerStatus.Font = Enum.Font.Gotham
playerStatus.Parent = profileFrame

-- Title Section
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -20, 0, 40)
titleLabel.Position = UDim2.new(0, 10, 0, 140)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM StealAbrainrot MX"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainPanel

-- Subtitle
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, -20, 0, 25)
subtitleLabel.Position = UDim2.new(0, 10, 0, 180)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "(Trial panel 3 days)"
subtitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Parent = mainPanel

-- Key Input Section
local keyInputFrame = Instance.new("Frame")
keyInputFrame.Name = "KeyInputFrame"
keyInputFrame.Size = UDim2.new(1, -20, 0, 200)
keyInputFrame.Position = UDim2.new(0, 10, 0, 220)
keyInputFrame.BackgroundColor3 = Color3.fromRGB(15, 30, 20)
keyInputFrame.BorderSizePixel = 0
keyInputFrame.Parent = mainPanel

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 10)
keyInputCorner.Parent = keyInputFrame

-- Key Input TextBox
local keyTextBox = Instance.new("TextBox")
keyTextBox.Name = "KeyTextBox"
keyTextBox.Size = UDim2.new(1, -20, 0, 40)
keyTextBox.Position = UDim2.new(0, 10, 0, 20)
keyTextBox.BackgroundColor3 = Color3.fromRGB(30, 50, 35)
keyTextBox.BorderSizePixel = 0
keyTextBox.PlaceholderText = "Place your key here..."
keyTextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
keyTextBox.Text = ""
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.TextScaled = true
keyTextBox.Font = Enum.Font.Gotham
keyTextBox.Parent = keyInputFrame

local keyTextBoxCorner = Instance.new("UICorner")
keyTextBoxCorner.CornerRadius = UDim.new(0, 8)
keyTextBoxCorner.Parent = keyTextBox

local keyTextBoxStroke = Instance.new("UIStroke")
keyTextBoxStroke.Color = Color3.fromRGB(0, 255, 127)
keyTextBoxStroke.Thickness = 1
keyTextBoxStroke.Transparency = 0.6
keyTextBoxStroke.Parent = keyTextBox

-- Get Key Button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Name = "GetKeyButton"
getKeyButton.Size = UDim2.new(0.45, -5, 0, 45)
getKeyButton.Position = UDim2.new(0, 10, 0, 80)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
getKeyButton.BorderSizePixel = 0
getKeyButton.Text = "Get Key"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextScaled = true
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.Parent = keyInputFrame

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 8)
getKeyCorner.Parent = getKeyButton

local getKeyStroke = Instance.new("UIStroke")
getKeyStroke.Color = Color3.fromRGB(0, 255, 127)
getKeyStroke.Thickness = 2
getKeyStroke.Transparency = 0.3
getKeyStroke.Parent = getKeyButton

-- Submit Button
local submitButton = Instance.new("TextButton")
submitButton.Name = "SubmitButton"
submitButton.Size = UDim2.new(0.45, -5, 0, 45)
submitButton.Position = UDim2.new(0.55, 5, 0, 80)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
submitButton.BorderSizePixel = 0
submitButton.Text = "Submit"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextScaled = true
submitButton.Font = Enum.Font.GothamBold
submitButton.Parent = keyInputFrame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 8)
submitCorner.Parent = submitButton

local submitStroke = Instance.new("UIStroke")
submitStroke.Color = Color3.fromRGB(0, 255, 127)
submitStroke.Thickness = 2
submitStroke.Transparency = 0.3
submitStroke.Parent = submitButton

-- Toast Notification
local toastFrame = Instance.new("Frame")
toastFrame.Name = "ToastFrame"
toastFrame.Size = UDim2.new(0, 350, 0, 60)
toastFrame.Position = UDim2.new(0.5, -175, 1, -120)
toastFrame.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
toastFrame.BorderSizePixel = 0
toastFrame.Visible = false
toastFrame.Parent = screenGui

local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 10)
toastCorner.Parent = toastFrame

local toastStroke = Instance.new("UIStroke")
toastStroke.Color = Color3.fromRGB(0, 255, 127)
toastStroke.Thickness = 2
toastStroke.Transparency = 0.2
toastStroke.Parent = toastFrame

local toastLabel = Instance.new("TextLabel")
toastLabel.Name = "ToastLabel"
toastLabel.Size = UDim2.new(1, -20, 1, 0)
toastLabel.Position = UDim2.new(0, 10, 0, 0)
toastLabel.BackgroundTransparency = 1
toastLabel.Text = "Your key has been copied! Go paste it in your preferred browser..."
toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toastLabel.TextWrapped = true
toastLabel.TextScaled = true
toastLabel.Font = Enum.Font.GothamMedium
toastLabel.Parent = toastFrame

-- Button Animations
local function animateButton(button, hoverScale, clickScale)
    local originalSize = button.Size
    local hoverTween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(originalSize.X.Scale * hoverScale, originalSize.X.Offset, originalSize.Y.Scale * hoverScale, originalSize.Y.Offset)
    })
    local normalTween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = originalSize
    })
    local clickTween = TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(originalSize.X.Scale * clickScale, originalSize.X.Offset, originalSize.Y.Scale * clickScale, originalSize.Y.Offset)
    })
    
    button.MouseEnter:Connect(function()
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        normalTween:Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        clickTween:Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        hoverTween:Play()
    end)
end

-- Apply animations to buttons
animateButton(getKeyButton, 1.05, 0.95)
animateButton(submitButton, 1.05, 0.95)

-- Toast Animation Function
local function showToast()
    toastFrame.Visible = true
    toastFrame.Position = UDim2.new(0.5, -175, 1, 0)
    
    local slideIn = TweenService:Create(toastFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -175, 1, -120)
    })
    
    slideIn:Play()
    
    wait(3)
    
    local slideOut = TweenService:Create(toastFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -175, 1, 0)
    })
    
    slideOut:Play()
    
    slideOut.Completed:Connect(function()
        toastFrame.Visible = false
    end)
end

-- Get Key Button Functionality
getKeyButton.MouseButton1Click:Connect(function()
    -- Copy to clipboard (Roblox method)
    setclipboard("https://zamasxmodder.github.io/PageFreeTrial3DaysKey/")
    
    -- Show toast notification
    spawn(showToast)
end)

-- Submit Button Functionality (placeholder for now)
submitButton.MouseButton1Click:Connect(function()
    print("Submit button clicked - Key:", keyTextBox.Text)
end)

-- Close GUI functionality (optional)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        screenGui:Destroy()
    end)

print("XM StealAbrainrot MX GUI Loaded Successfully!")

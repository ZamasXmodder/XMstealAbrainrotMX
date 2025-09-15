-- XM StealAbrainrot MX GUI System - Corrected Version
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove existing GUI if present
if playerGui:FindFirstChild("XMStealAbrainrotGUI") then
    playerGui:FindFirstChild("XMStealAbrainrotGUI"):Destroy()
end

-- Color scheme
local neonGreen = Color3.new(0, 1, 0.3)
local backgroundColor = Color3.new(0.08, 0.08, 0.08)
local frameColor = Color3.new(0.12, 0.12, 0.12)

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMStealAbrainrotGUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Full screen decorative background
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "Background"
backgroundFrame.Parent = screenGui
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.new(0, 0, 0)
backgroundFrame.BackgroundTransparency = 0.4
backgroundFrame.BorderSizePixel = 0

-- Add corner decorations
for i = 1, 4 do
    local corner = Instance.new("Frame")
    corner.Parent = backgroundFrame
    corner.Size = UDim2.new(0, 70, 0, 70)
    corner.BackgroundColor3 = neonGreen
    corner.BackgroundTransparency = 0.7
    corner.BorderSizePixel = 0
    corner.Rotation = 45
    
    local cornerRadius = Instance.new("UICorner")
    cornerRadius.CornerRadius = UDim.new(0, 15)
    cornerRadius.Parent = corner
    
    if i == 1 then corner.Position = UDim2.new(0, -35, 0, -35) end
    if i == 2 then corner.Position = UDim2.new(1, -35, 0, -35) end
    if i == 3 then corner.Position = UDim2.new(0, -35, 1, -35) end
    if i == 4 then corner.Position = UDim2.new(1, -35, 1, -35) end
end

-- Main panel
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Parent = screenGui
mainPanel.Size = UDim2.new(0, 450, 0, 600)
mainPanel.Position = UDim2.new(0.5, -225, 0.5, -300)
mainPanel.BackgroundColor3 = backgroundColor
mainPanel.BorderSizePixel = 0

-- Panel rounded corners
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 25)
panelCorner.Parent = mainPanel

-- Panel border
local panelStroke = Instance.new("UIStroke")
panelStroke.Color = neonGreen
panelStroke.Thickness = 4
panelStroke.Parent = mainPanel

-- Player info container
local playerContainer = Instance.new("Frame")
playerContainer.Name = "PlayerContainer"
playerContainer.Parent = mainPanel
playerContainer.Size = UDim2.new(1, -40, 0, 130)
playerContainer.Position = UDim2.new(0, 20, 0, 20)
playerContainer.BackgroundTransparency = 1

-- Player headshot
local headshot = Instance.new("ImageLabel")
headshot.Name = "Headshot"
headshot.Parent = playerContainer
headshot.Size = UDim2.new(0, 100, 0, 100)
headshot.Position = UDim2.new(0, 15, 0, 15)
headshot.BackgroundColor3 = frameColor
headshot.BorderSizePixel = 0

-- Headshot styling
local headshotCorner = Instance.new("UICorner")
headshotCorner.CornerRadius = UDim.new(0, 20)
headshotCorner.Parent = headshot

local headshotBorder = Instance.new("UIStroke")
headshotBorder.Color = neonGreen
headshotBorder.Thickness = 3
headshotBorder.Parent = headshot

-- Load headshot image
spawn(function()
    local success, thumbnailUrl = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)
    if success then
        headshot.Image = thumbnailUrl
    end
end)

-- Player display name
local displayName = Instance.new("TextLabel")
displayName.Name = "DisplayName"
displayName.Parent = playerContainer
displayName.Size = UDim2.new(0, 300, 0, 30)
displayName.Position = UDim2.new(0, 130, 0, 20)
displayName.BackgroundTransparency = 1
displayName.Text = player.DisplayName or player.Name
displayName.Font = Enum.Font.GothamBold
displayName.TextSize = 20
displayName.TextColor3 = Color3.white
displayName.TextXAlignment = Enum.TextXAlignment.Left

-- Player username with @
local username = Instance.new("TextLabel")
username.Name = "Username"
username.Parent = playerContainer
username.Size = UDim2.new(0, 300, 0, 25)
username.Position = UDim2.new(0, 130, 0, 45)
username.BackgroundTransparency = 1
username.Text = "@" .. player.Name
username.Font = Enum.Font.Gotham
username.TextSize = 16
username.TextColor3 = Color3.new(0.7, 0.7, 0.7)
username.TextXAlignment = Enum.TextXAlignment.Left

-- Player country
local country = Instance.new("TextLabel")
country.Name = "Country"
country.Parent = playerContainer
country.Size = UDim2.new(0, 300, 0, 20)
country.Position = UDim2.new(0, 130, 0, 70)
country.BackgroundTransparency = 1
country.Text = "Country: Global"
country.Font = Enum.Font.Gotham
country.TextSize = 14
country.TextColor3 = Color3.new(0.6, 0.6, 0.6)
country.TextXAlignment = Enum.TextXAlignment.Left

-- Player status
local status = Instance.new("TextLabel")
status.Name = "Status"
status.Parent = playerContainer
status.Size = UDim2.new(0, 300, 0, 20)
status.Position = UDim2.new(0, 130, 0, 90)
status.BackgroundTransparency = 1
status.Text = "Status: Online"
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextColor3 = neonGreen
status.TextXAlignment = Enum.TextXAlignment.Left

-- Main title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Parent = mainPanel
titleLabel.Size = UDim2.new(1, -40, 0, 50)
titleLabel.Position = UDim2.new(0, 20, 0, 170)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM StealAbrainrot MX"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 32
titleLabel.TextColor3 = neonGreen
titleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Parent = mainPanel
subtitle.Size = UDim2.new(1, -40, 0, 30)
subtitle.Position = UDim2.new(0, 20, 0, 215)
subtitle.BackgroundTransparency = 1
subtitle.Text = "(TRIAL 3 DAYS)"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 16
subtitle.TextColor3 = Color3.new(0.7, 0.7, 0.7)
subtitle.TextXAlignment = Enum.TextXAlignment.Center

-- Key input frame
local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Parent = mainPanel
inputFrame.Size = UDim2.new(1, -60, 0, 70)
inputFrame.Position = UDim2.new(0, 30, 0, 280)
inputFrame.BackgroundColor3 = frameColor
inputFrame.BorderSizePixel = 0

-- Input frame styling
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 18)
inputCorner.Parent = inputFrame

local inputBorder = Instance.new("UIStroke")
inputBorder.Color = Color3.new(0.4, 0.4, 0.4)
inputBorder.Thickness = 2
inputBorder.Parent = inputFrame

-- Key input textbox
local keyInput = Instance.new("TextBox")
keyInput.Name = "KeyInput"
keyInput.Parent = inputFrame
keyInput.Size = UDim2.new(1, -30, 1, -20)
keyInput.Position = UDim2.new(0, 15, 0, 10)
keyInput.BackgroundTransparency = 1
keyInput.PlaceholderText = "Type your key here..."
keyInput.Text = ""
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 18
keyInput.TextColor3 = Color3.white
keyInput.PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5)
keyInput.TextXAlignment = Enum.TextXAlignment.Left
keyInput.ClearTextOnFocus = false

-- Button container
local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Parent = mainPanel
buttonContainer.Size = UDim2.new(1, -60, 0, 70)
buttonContainer.Position = UDim2.new(0, 30, 0, 380)
buttonContainer.BackgroundTransparency = 1

-- Toast notification function
local function showToast(message)
    local toastFrame = Instance.new("Frame")
    toastFrame.Name = "Toast"
    toastFrame.Parent = screenGui
    toastFrame.Size = UDim2.new(0, 420, 0, 80)
    toastFrame.Position = UDim2.new(0.5, -210, 1, -150)
    toastFrame.BackgroundColor3 = frameColor
    toastFrame.BorderSizePixel = 0
    
    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, 20)
    toastCorner.Parent = toastFrame
    
    local toastBorder = Instance.new("UIStroke")
    toastBorder.Color = neonGreen
    toastBorder.Thickness = 3
    toastBorder.Parent = toastFrame
    
    local toastText = Instance.new("TextLabel")
    toastText.Parent = toastFrame
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
    
    -- Animate toast
    toastFrame.Position = UDim2.new(0.5, -210, 1, 20)
    local slideIn = TweenService:Create(toastFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
        {Position = UDim2.new(0.5, -210, 1, -150)})
    slideIn:Play()
    
    spawn(function()
        wait(4)
        local slideOut = TweenService:Create(toastFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
            {Position = UDim2.new(0.5, -210, 1, 20)})
        slideOut:Play()
        slideOut.Completed:Connect(function()
            toastFrame:Destroy()
        end)
    end)
end

-- Create button function
local function createButton(parent, name, text, position, size, clickFunction)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = parent
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.BorderSizePixel = 0
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.TextColor3 = Color3.white
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 18)
    buttonCorner.Parent = button
    
    local buttonBorder = Instance.new("UIStroke")
    buttonBorder.Color = neonGreen
    buttonBorder.Thickness = 3
    buttonBorder.Parent = button
    
    -- Button hover effects
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)}):Play()
        TweenService:Create(buttonBorder, TweenInfo.new(0.3), {Color = Color3.new(0.2, 1, 0.5)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)}):Play()
        TweenService:Create(buttonBorder, TweenInfo.new(0.3), {Color = neonGreen}):Play()
    end)
    
    if clickFunction then
        button.MouseButton1Click:Connect(clickFunction)
    end
    
    return button
end

-- Get Key button
local getKeyButton = createButton(
    buttonContainer,
    "GetKeyButton", 
    "Get Key",
    UDim2.new(0, 0, 0, 0),
    UDim2.new(0.48, 0, 1, 0),
    function()
        setclipboard("https://zamasxmodder.github.io/PageFreeTrial3DaysKey/")
        showToast("Your key has been copied! Go and paste it in your preferred browser...")
    end
)

-- Submit button
local submitButton = createButton(
    buttonContainer,
    "SubmitButton",
    "Submit",
    UDim2.new(0.52, 0, 0, 0),
    UDim2.new(0.48, 0, 1, 0),
    function()
        local enteredKey = keyInput.Text
        if enteredKey and enteredKey ~= "" then
            showToast("Key submitted: " .. enteredKey)
        else
            showToast("Please enter a key first!")
        end
    end
)

-- Panel entrance animation
mainPanel.Position = UDim2.new(0.5, -225, -1, 0)
wait(0.8)
local entranceAnimation = TweenService:Create(mainPanel, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
    {Position = UDim2.new(0.5, -225, 0.5, -300)})
entranceAnimation:Play()

-- Border glow effect
spawn(function()
    while mainPanel.Parent do
        local glowIn = TweenService:Create(panelStroke, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {Transparency = 0.6})
        glowIn:Play()
        glowIn.Completed:Wait()
        
        local glowOut = TweenService:Create(panelStroke, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {Transparency = 0})
        glowOut:Play()
        glowOut.Completed:Wait()
    end
end)

print("XM StealAbrainrot MX GUI loaded successfully!")

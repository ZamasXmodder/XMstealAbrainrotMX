-- Trial Steal a brainrot - Halloween Event GUI
-- Created for Roblox

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TrialStealHalloweenGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 380)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Main Frame Corner
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

-- Main Frame Border
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 107, 0)
mainStroke.Thickness = 3
mainStroke.Parent = mainFrame

-- Glow Effect
local glowEffect = Instance.new("ImageLabel")
glowEffect.Name = "Glow"
glowEffect.Size = UDim2.new(1, 50, 1, 50)
glowEffect.Position = UDim2.new(0, -25, 0, -25)
glowEffect.BackgroundTransparency = 1
glowEffect.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
glowEffect.ImageColor3 = Color3.fromRGB(255, 107, 0)
glowEffect.ImageTransparency = 0.7
glowEffect.ScaleType = Enum.ScaleType.Slice
glowEffect.SliceCenter = Rect.new(10, 10, 90, 90)
glowEffect.ZIndex = 0
glowEffect.Parent = mainFrame

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.Position = UDim2.new(0, 0, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "👻 TRIAL STEAL 👻"
titleLabel.TextColor3 = Color3.fromRGB(255, 107, 0)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextStrokeTransparency = 0
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Parent = mainFrame

-- Subtitle Label
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, 0, 0, 22)
subtitleLabel.Position = UDim2.new(0, 0, 0, 55)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "a brainrot"
subtitleLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
subtitleLabel.TextSize = 14
subtitleLabel.Font = Enum.Font.GothamBold
subtitleLabel.Parent = mainFrame

-- Event Label
local eventLabel = Instance.new("TextLabel")
eventLabel.Name = "EventLabel"
eventLabel.Size = UDim2.new(1, 0, 0, 28)
eventLabel.Position = UDim2.new(0, 0, 0, 77)
eventLabel.BackgroundTransparency = 1
eventLabel.Text = "🎃 Halloween Event 🎃"
eventLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
eventLabel.TextSize = 16
eventLabel.Font = Enum.Font.GothamBold
eventLabel.TextStrokeTransparency = 0.5
eventLabel.Parent = mainFrame

-- Spider Decoration 1
local spider1 = Instance.new("TextLabel")
spider1.Size = UDim2.new(0, 40, 0, 40)
spider1.Position = UDim2.new(0, 20, 0, 20)
spider1.BackgroundTransparency = 1
spider1.Text = "🕷️"
spider1.TextSize = 30
spider1.Parent = mainFrame

-- Spider Decoration 2
local spider2 = Instance.new("TextLabel")
spider2.Size = UDim2.new(0, 40, 0, 40)
spider2.Position = UDim2.new(1, -60, 0, 20)
spider2.BackgroundTransparency = 1
spider2.Text = "🕸️"
spider2.TextSize = 30
spider2.Parent = mainFrame

-- Web Decoration 1
local web1 = Instance.new("TextLabel")
web1.Size = UDim2.new(0, 50, 0, 50)
web1.Position = UDim2.new(0, 10, 1, -60)
web1.BackgroundTransparency = 1
web1.Text = "🕸️"
web1.TextSize = 40
web1.TextTransparency = 0.3
web1.Parent = mainFrame

-- Web Decoration 2
local web2 = Instance.new("TextLabel")
web2.Size = UDim2.new(0, 50, 0, 50)
web2.Position = UDim2.new(1, -60, 1, -60)
web2.BackgroundTransparency = 1
web2.Text = "🕷️"
web2.TextSize = 40
web2.TextTransparency = 0.3
web2.Parent = mainFrame

-- Key Input Frame
local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Size = UDim2.new(0, 260, 0, 45)
inputFrame.Position = UDim2.new(0.5, -130, 0, 125)
inputFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
inputFrame.BackgroundTransparency = 0.4
inputFrame.BorderSizePixel = 0
inputFrame.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 12)
inputCorner.Parent = inputFrame

local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(255, 107, 0)
inputStroke.Thickness = 2
inputStroke.Parent = inputFrame

-- Key TextBox
local keyInput = Instance.new("TextBox")
keyInput.Name = "KeyInput"
keyInput.Size = UDim2.new(1, -20, 1, -20)
keyInput.Position = UDim2.new(0, 10, 0, 10)
keyInput.BackgroundTransparency = 1
keyInput.Text = ""
keyInput.PlaceholderText = "Enter Key Here..."
keyInput.TextColor3 = Color3.fromRGB(0, 255, 0)
keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyInput.TextSize = 14
keyInput.Font = Enum.Font.Code
keyInput.TextXAlignment = Enum.TextXAlignment.Center
keyInput.ClearTextOnFocus = false
keyInput.Parent = inputFrame

-- Submit Button
local submitButton = Instance.new("TextButton")
submitButton.Name = "SubmitButton"
submitButton.Size = UDim2.new(0, 260, 0, 42)
submitButton.Position = UDim2.new(0.5, -130, 0, 190)
submitButton.BackgroundColor3 = Color3.fromRGB(255, 107, 0)
submitButton.BorderSizePixel = 0
submitButton.Text = "🎃 SUBMIT 🎃"
submitButton.TextColor3 = Color3.fromRGB(0, 0, 0)
submitButton.TextSize = 18
submitButton.Font = Enum.Font.GothamBold
submitButton.Parent = mainFrame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 12)
submitCorner.Parent = submitButton

local submitStroke = Instance.new("UIStroke")
submitStroke.Color = Color3.fromRGB(255, 140, 0)
submitStroke.Thickness = 2
submitStroke.Parent = submitButton

-- Get Key Button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Name = "GetKeyButton"
getKeyButton.Size = UDim2.new(0, 260, 0, 42)
getKeyButton.Position = UDim2.new(0.5, -130, 0, 247)
getKeyButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
getKeyButton.BorderSizePixel = 0
getKeyButton.Text = "👻 GET KEY 👻"
getKeyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
getKeyButton.TextSize = 18
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.Parent = mainFrame

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 12)
getKeyCorner.Parent = getKeyButton

local getKeyStroke = Instance.new("UIStroke")
getKeyStroke.Color = Color3.fromRGB(255, 165, 0)
getKeyStroke.Thickness = 2
getKeyStroke.Parent = getKeyButton

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -50, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 24
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Premium Badge
local premiumBadge = Instance.new("TextLabel")
premiumBadge.Name = "PremiumBadge"
premiumBadge.Size = UDim2.new(0, 260, 0, 28)
premiumBadge.Position = UDim2.new(0.5, -130, 0, 302)
premiumBadge.BackgroundTransparency = 1
premiumBadge.Text = "⭐ ONLY PREMIUM USERS ⭐"
premiumBadge.TextColor3 = Color3.fromRGB(255, 215, 0)
premiumBadge.TextSize = 13
premiumBadge.Font = Enum.Font.GothamBold
premiumBadge.TextStrokeTransparency = 0.5
premiumBadge.Parent = mainFrame

-- Credits
local creditsLabel = Instance.new("TextLabel")
creditsLabel.Name = "CreditsLabel"
creditsLabel.Size = UDim2.new(1, 0, 0, 22)
creditsLabel.Position = UDim2.new(0, 0, 1, -27)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "🕸️ Halloween Special Edition 🕸️"
creditsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
creditsLabel.TextSize = 11
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.Parent = mainFrame

-- Toast Notification
local toastFrame = Instance.new("Frame")
toastFrame.Name = "ToastFrame"
toastFrame.Size = UDim2.new(0, 400, 0, 60)
toastFrame.Position = UDim2.new(0.5, -200, 0, -100)
toastFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
toastFrame.BorderSizePixel = 0
toastFrame.Visible = false
toastFrame.Parent = screenGui

local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 12)
toastCorner.Parent = toastFrame

local toastStroke = Instance.new("UIStroke")
toastStroke.Color = Color3.fromRGB(0, 255, 0)
toastStroke.Thickness = 2
toastStroke.Parent = toastFrame

local toastLabel = Instance.new("TextLabel")
toastLabel.Size = UDim2.new(1, -20, 1, 0)
toastLabel.Position = UDim2.new(0, 10, 0, 0)
toastLabel.BackgroundTransparency = 1
toastLabel.Text = "✅ Key link copied to clipboard!"
toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toastLabel.TextSize = 20
toastLabel.Font = Enum.Font.GothamBold
toastLabel.TextXAlignment = Enum.TextXAlignment.Center
toastLabel.Parent = toastFrame

-- Make GUI Draggable (REMOVED - GUI is now fixed in position)

-- Button Animations
local function animateButton(button, hoverColor, normalColor)
	button.MouseEnter:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor})
		tween:Play()
	end)
	
	button.MouseLeave:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor})
		tween:Play()
	end)
end

animateButton(submitButton, Color3.fromRGB(255, 140, 0), Color3.fromRGB(255, 107, 0))
animateButton(getKeyButton, Color3.fromRGB(255, 165, 0), Color3.fromRGB(255, 140, 0))
animateButton(closeButton, Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 0, 0))

-- Spider Animation
local function animateSpider(spider)
	spawn(function()
		while wait(3) do
			local tween = TweenService:Create(spider, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 15})
			tween:Play()
			wait(2)
			local tween2 = TweenService:Create(spider, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = -15})
			tween2:Play()
		end
	end)
end

animateSpider(spider1)
animateSpider(spider2)

-- Toast Function
local function showToast()
	toastFrame.Visible = true
	toastFrame.Position = UDim2.new(0.5, -200, 0, -100)
	
	local tweenIn = TweenService:Create(toastFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 0, 20)})
	tweenIn:Play()
	
	wait(3)
	
	local tweenOut = TweenService:Create(toastFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -200, 0, -100)})
	tweenOut:Play()
	
	wait(0.5)
	toastFrame.Visible = false
end

-- Button Functions
submitButton.MouseButton1Click:Connect(function()
	local key = keyInput.Text
	
	if key ~= "" then
		-- Add your key validation logic here
		print("Submitted Key: " .. key)
		
		-- Example validation
		local toastTemp = toastFrame:Clone()
		toastTemp.Parent = screenGui
		local label = toastTemp:FindFirstChildOfClass("TextLabel")
		label.Text = "🎃 Validating key..."
		label.TextColor3 = Color3.fromRGB(255, 165, 0)
		toastTemp.BackgroundColor3 = Color3.fromRGB(255, 107, 0)
		toastTemp.Visible = true
		toastTemp.Position = UDim2.new(0.5, -200, 0, 20)
		
		wait(2)
		toastTemp:Destroy()
	else
		local toastTemp = toastFrame:Clone()
		toastTemp.Parent = screenGui
		local label = toastTemp:FindFirstChildOfClass("TextLabel")
		label.Text = "⚠️ Please enter a key!"
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		toastTemp.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		toastTemp.Visible = true
		toastTemp.Position = UDim2.new(0.5, -200, 0, 20)
		
		wait(2)
		toastTemp:Destroy()
	end
end)

getKeyButton.MouseButton1Click:Connect(function()
	setclipboard("https://zamasxmodder.github.io/HalloweenScriptStealAbrainrotTrial/")
	showToast()
end)

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Entrance Animation
mainFrame.Position = UDim2.new(0.5, 0, -1, 0)
local entranceTween = TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)})
entranceTween:Play()

print("👻 Trial Steal Halloween GUI Loaded! 🎃")

-- XM StealAbrainrot MX GUI Panel
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XMStealAbrainrotPanel"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Crear esquinas redondeadas para el frame principal
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- Frame del borde animado
local borderFrame = Instance.new("Frame")
borderFrame.Name = "BorderFrame"
borderFrame.Size = UDim2.new(1, 4, 1, 4)
borderFrame.Position = UDim2.new(0, -2, 0, -2)
borderFrame.BackgroundTransparency = 1
borderFrame.Parent = mainFrame
borderFrame.ZIndex = mainFrame.ZIndex - 1

-- Crear el borde gradiente animado
local borderGradient = Instance.new("UIGradient")
borderGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.5, 0),
    NumberSequenceKeypoint.new(1, 0)
})
borderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 127)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
borderGradient.Parent = borderFrame

local borderStroke = Instance.new("UIStroke")
borderStroke.Thickness = 3
borderStroke.Color = Color3.fromRGB(0, 255, 127)
borderStroke.Parent = mainFrame

-- Animación del borde
local borderTween = TweenService:Create(
    borderGradient,
    TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
    {Rotation = 360}
)
borderTween:Play()

-- Título principal
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XM StealAbrainrot MX"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Subtítulo
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, 0, 0, 20)
subtitleLabel.Position = UDim2.new(0, 0, 0, 50)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "free trial 3 days"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Parent = mainFrame

-- Frame de información del jugador
local playerFrame = Instance.new("Frame")
playerFrame.Name = "PlayerFrame"
playerFrame.Size = UDim2.new(0.9, 0, 0, 120)
playerFrame.Position = UDim2.new(0.05, 0, 0, 80)
playerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
playerFrame.BorderSizePixel = 0
playerFrame.Parent = mainFrame

local playerCorner = Instance.new("UICorner")
playerCorner.CornerRadius = UDim.new(0, 10)
playerCorner.Parent = playerFrame

-- Avatar del jugador (headshot circular)
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.Size = UDim2.new(0, 80, 0, 80)
avatarImage.Position = UDim2.new(0, 15, 0, 20)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
avatarImage.Parent = playerFrame

-- Hacer el avatar circular
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatarImage

-- Información del jugador
local displayNameLabel = Instance.new("TextLabel")
displayNameLabel.Name = "DisplayNameLabel"
displayNameLabel.Size = UDim2.new(0.6, 0, 0, 25)
displayNameLabel.Position = UDim2.new(0.3, 10, 0, 20)
displayNameLabel.BackgroundTransparency = 1
displayNameLabel.Text = player.DisplayName
displayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
displayNameLabel.TextScaled = true
displayNameLabel.Font = Enum.Font.GothamBold
displayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
displayNameLabel.Parent = playerFrame

local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "UsernameLabel"
usernameLabel.Size = UDim2.new(0.6, 0, 0, 20)
usernameLabel.Position = UDim2.new(0.3, 10, 0, 45)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = "@" .. player.Name
usernameLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
usernameLabel.TextScaled = true
usernameLabel.Font = Enum.Font.Gotham
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.Parent = playerFrame

-- Label del país (placeholder)
local countryLabel = Instance.new("TextLabel")
countryLabel.Name = "CountryLabel"
countryLabel.Size = UDim2.new(0.6, 0, 0, 20)
countryLabel.Position = UDim2.new(0.3, 10, 0, 70)
countryLabel.BackgroundTransparency = 1
countryLabel.Text = "Country: Unknown"
countryLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
countryLabel.TextScaled = true
countryLabel.Font = Enum.Font.Gotham
countryLabel.TextXAlignment = Enum.TextXAlignment.Left
countryLabel.Parent = playerFrame

-- TextBox para la key
local keyTextBox = Instance.new("TextBox")
keyTextBox.Name = "KeyTextBox"
keyTextBox.Size = UDim2.new(0.9, 0, 0, 40)
keyTextBox.Position = UDim2.new(0.05, 0, 0, 220)
keyTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyTextBox.BorderSizePixel = 0
keyTextBox.PlaceholderText = "paste your key here..."
keyTextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyTextBox.Text = ""
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.TextScaled = true
keyTextBox.Font = Enum.Font.Gotham
keyTextBox.Parent = mainFrame

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0, 8)
keyBoxCorner.Parent = keyTextBox

-- Botón Get Key
local getKeyButton = Instance.new("TextButton")
getKeyButton.Name = "GetKeyButton"
getKeyButton.Size = UDim2.new(0.43, 0, 0, 40)
getKeyButton.Position = UDim2.new(0.05, 0, 0, 280)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
getKeyButton.BorderSizePixel = 0
getKeyButton.Text = "Get Key"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextScaled = true
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.Parent = mainFrame

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 8)
getKeyCorner.Parent = getKeyButton

-- Botón Submit
local submitButton = Instance.new("TextButton")
submitButton.Name = "SubmitButton"
submitButton.Size = UDim2.new(0.43, 0, 0, 40)
submitButton.Position = UDim2.new(0.52, 0, 0, 280)
submitButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
submitButton.BorderSizePixel = 0
submitButton.Text = "Submit"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextScaled = true
submitButton.Font = Enum.Font.GothamBold
submitButton.Parent = mainFrame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 8)
submitCorner.Parent = submitButton

-- Función para crear toast
local function createToast(message)
    local toastGui = Instance.new("ScreenGui")
    toastGui.Name = "ToastNotification"
    toastGui.Parent = playerGui
    
    local toastFrame = Instance.new("Frame")
    toastFrame.Size = UDim2.new(0, 400, 0, 60)
    toastFrame.Position = UDim2.new(0.5, -200, 1, -150)
    toastFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    toastFrame.BorderSizePixel = 0
    toastFrame.Parent = toastGui
    
    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, 10)
    toastCorner.Parent = toastFrame
    
    local toastStroke = Instance.new("UIStroke")
    toastStroke.Thickness = 2
    toastStroke.Color = Color3.fromRGB(0, 255, 127)
    toastStroke.Parent = toastFrame
    
    local toastLabel = Instance.new("TextLabel")
    toastLabel.Size = UDim2.new(1, -20, 1, 0)
    toastLabel.Position = UDim2.new(0, 10, 0, 0)
    toastLabel.BackgroundTransparency = 1
    toastLabel.Text = message
    toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toastLabel.TextScaled = true
    toastLabel.Font = Enum.Font.Gotham
    toastLabel.TextWrapped = true
    toastLabel.Parent = toastFrame
    
    -- Animación de entrada
    local tweenIn = TweenService:Create(
        toastFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, -200, 1, -210)}
    )
    tweenIn:Play()
    
    -- Esperar y hacer animación de salida
    wait(3)
    local tweenOut = TweenService:Create(
        toastFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Position = UDim2.new(0.5, -200, 1, -50)}
    )
    tweenOut:Play()
    
    tweenOut.Completed:Connect(function()
        toastGui:Destroy()
    end)
end

-- Función del botón Get Key
getKeyButton.MouseButton1Click:Connect(function()
    local keyUrl = "https://zamasxmodder.github.io/PageFreeTrial3DaysKey/"
    
    -- Copiar al portapapeles (esto requiere que el juego tenga permisos)
    pcall(function()
        setclipboard(keyUrl)
    end)
    
    -- Mostrar toast
    spawn(function()
        createToast("Key copied to clipboard! Go to your preferred browser and paste it there...")
    end)
    
    -- Animación del botón
    local buttonTween = TweenService:Create(
        getKeyButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = UDim2.new(0.41, 0, 0, 38)}
    )
    buttonTween:Play()
    
    buttonTween.Completed:Connect(function()
        local buttonTween2 = TweenService:Create(
            getKeyButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            {Size = UDim2.new(0.43, 0, 0, 40)}
        )
        buttonTween2:Play()
    end)
end)

-- Función del botón Submit
submitButton.MouseButton1Click:Connect(function()
    local keyText = keyTextBox.Text
    if keyText ~= "" then
        -- Aquí puedes agregar la lógica para validar la key
        print("Key submitted: " .. keyText)
        
        -- Animación del botón
        local buttonTween = TweenService:Create(
            submitButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            {Size = UDim2.new(0.41, 0, 0, 38)}
        )
        buttonTween:Play()
        
        buttonTween.Completed:Connect(function()
            local buttonTween2 = TweenService:Create(
                submitButton,
                TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Size = UDim2.new(0.43, 0, 0, 40)}
            )
            buttonTween2:Play()
        end)
    else
        spawn(function()
            createToast("Please enter a valid key!")
        end)
    end
end)

-- Efectos de hover para los botones
getKeyButton.MouseEnter:Connect(function()
    local hoverTween = TweenService:Create(
        getKeyButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}
    )
    hoverTween:Play()
end)

getKeyButton.MouseLeave:Connect(function()
    local hoverTween = TweenService:Create(
        getKeyButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 180, 90)}
    )
    hoverTween:Play()
end)

submitButton.MouseEnter:Connect(function()
    local hoverTween = TweenService:Create(
        submitButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
    )
    hoverTween:Play()
end)

submitButton.MouseLeave:Connect(function()
    local hoverTween = TweenService:Create(
        submitButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
    )
    hoverTween:Play()
end)

print("XM StealAbrainrot MX GUI loaded successfully!")

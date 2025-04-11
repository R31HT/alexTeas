local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer

-- Check device type
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

-- UI CONSTANTS
local COLORS = {
    BACKGROUND = Color3.fromRGB(35, 35, 40),
    CARD = Color3.fromRGB(45, 45, 50),
    ACCENT = Color3.fromRGB(90, 90, 255),
    SUCCESS = Color3.fromRGB(50, 190, 100),
    WARNING = Color3.fromRGB(255, 165, 0),
    ERROR = Color3.fromRGB(255, 80, 80),
    TEXT_PRIMARY = Color3.fromRGB(255, 255, 255),
    TEXT_SECONDARY = Color3.fromRGB(200, 200, 200),
    BUTTON = Color3.fromRGB(70, 70, 240),
    BUTTON_HOVER = Color3.fromRGB(90, 90, 255),
    DROPDOWN_BG = Color3.fromRGB(40, 40, 45),
    DROPDOWN_HOVER = Color3.fromRGB(55, 55, 60)
}

local SCALE = isMobile and 0.85 or 1
local PADDING = 12 * SCALE
local CORNER_RADIUS = 8

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MessageBamboozlerGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- Create main container
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320 * SCALE, 0, 365 * SCALE)
MainFrame.Position = UDim2.new(0.5, -160 * SCALE, 0.5, -180 * SCALE)
MainFrame.BackgroundColor3 = COLORS.BACKGROUND
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Apply rounded corners
local function applyCorners(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or CORNER_RADIUS)
    corner.Parent = instance
    return corner
end

-- Apply padding
local function applyPadding(instance, top, right, bottom, left)
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, top or PADDING)
    padding.PaddingRight = UDim.new(0, right or PADDING)
    padding.PaddingBottom = UDim.new(0, bottom or PADDING)
    padding.PaddingLeft = UDim.new(0, left or PADDING)
    padding.Parent = instance
    return padding
end

-- Apply shadow effect
local function applyShadow(instance, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.ZIndex = instance.ZIndex - 1
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = transparency or 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Parent = instance
    return shadow
end

-- Apply styling to main frame
applyCorners(MainFrame)
applyShadow(MainFrame, 0.6)

-- Create header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 45 * SCALE)
Header.BackgroundColor3 = COLORS.ACCENT
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = applyCorners(Header)
HeaderCorner.CornerRadius = UDim.new(0, CORNER_RADIUS, 0, 0)

local TitleContainer = Instance.new("Frame")
TitleContainer.Name = "TitleContainer"
TitleContainer.Size = UDim2.new(1, -50 * SCALE, 1, 0)
TitleContainer.BackgroundTransparency = 1
TitleContainer.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🤡 Message Bamboozler"
Title.TextColor3 = COLORS.TEXT_PRIMARY
Title.TextSize = 18 * SCALE
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleContainer
applyPadding(TitleContainer, 0, 0, 0, PADDING)

local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Name = "ButtonsContainer"
ButtonsContainer.Size = UDim2.new(0, 50 * SCALE, 1, 0)
ButtonsContainer.Position = UDim2.new(1, -50 * SCALE, 0, 0)
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Parent = Header

local HideButton = Instance.new("TextButton")
HideButton.Name = "HideButton"
HideButton.Size = UDim2.new(0, 35 * SCALE, 0, 35 * SCALE)
HideButton.Position = UDim2.new(0.5, -17.5 * SCALE, 0.5, -17.5 * SCALE)
HideButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HideButton.BackgroundTransparency = 0.9
HideButton.BorderSizePixel = 0
HideButton.Text = "−"
HideButton.TextColor3 = COLORS.TEXT_PRIMARY
HideButton.TextSize = 24 * SCALE
HideButton.Font = Enum.Font.GothamBold
HideButton.Parent = ButtonsContainer
applyCorners(HideButton, 6)

-- Content container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, 0, 1, -45 * SCALE)
ContentContainer.Position = UDim2.new(0, 0, 0, 45 * SCALE)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame
applyPadding(ContentContainer)

-- Description text
local Description = Instance.new("TextLabel")
Description.Name = "Description"
Description.Size = UDim2.new(1, 0, 0, 40 * SCALE)
Description.BackgroundTransparency = 1
Description.Text = "Select one of your messages and change what it appears to say!"
Description.TextColor3 = COLORS.TEXT_PRIMARY
Description.TextSize = 14 * SCALE
Description.TextWrapped = true
Description.Font = Enum.Font.Gotham
Description.Parent = ContentContainer

-- Message selection section
local HistoryLabel = Instance.new("TextLabel")
HistoryLabel.Name = "HistoryLabel"
HistoryLabel.Size = UDim2.new(1, 0, 0, 20 * SCALE)
HistoryLabel.Position = UDim2.new(0, 0, 0, 50 * SCALE)
HistoryLabel.BackgroundTransparency = 1
HistoryLabel.Text = "Your Recent Messages:"
HistoryLabel.TextColor3 = COLORS.TEXT_PRIMARY
HistoryLabel.TextSize = 15 * SCALE
HistoryLabel.TextXAlignment = Enum.TextXAlignment.Left
HistoryLabel.Font = Enum.Font.GothamSemibold
HistoryLabel.Parent = ContentContainer

-- Dropdown for message selection
local MessageDropdown = Instance.new("Frame")
MessageDropdown.Name = "MessageDropdown"
MessageDropdown.Size = UDim2.new(1, 0, 0, 38 * SCALE)
MessageDropdown.Position = UDim2.new(0, 0, 0, 75 * SCALE)
MessageDropdown.BackgroundColor3 = COLORS.DROPDOWN_BG
MessageDropdown.BorderSizePixel = 0
MessageDropdown.Parent = ContentContainer
applyCorners(MessageDropdown)

local SelectedMessage = Instance.new("TextLabel")
SelectedMessage.Name = "SelectedMessage"
SelectedMessage.Size = UDim2.new(1, -38 * SCALE, 1, 0)
SelectedMessage.BackgroundTransparency = 1
SelectedMessage.Text = "Select a message..."
SelectedMessage.TextColor3 = COLORS.TEXT_SECONDARY
SelectedMessage.TextSize = 14 * SCALE
SelectedMessage.TextXAlignment = Enum.TextXAlignment.Left
SelectedMessage.Font = Enum.Font.Gotham
SelectedMessage.TextTruncate = Enum.TextTruncate.AtEnd
SelectedMessage.Parent = MessageDropdown
applyPadding(SelectedMessage, 0, 0, 0, PADDING)

local DropdownButton = Instance.new("TextButton")
DropdownButton.Name = "DropdownButton"
DropdownButton.Size = UDim2.new(0, 38 * SCALE, 1, 0)
DropdownButton.Position = UDim2.new(1, -38 * SCALE, 0, 0)
DropdownButton.BackgroundTransparency = 1
DropdownButton.Text = "▼"
DropdownButton.TextColor3 = COLORS.TEXT_PRIMARY
DropdownButton.TextSize = 14 * SCALE
DropdownButton.Font = Enum.Font.GothamBold
DropdownButton.Parent = MessageDropdown

local DropdownClickArea = Instance.new("TextButton")
DropdownClickArea.Name = "DropdownClickArea"
DropdownClickArea.Size = UDim2.new(1, 0, 1, 0)
DropdownClickArea.BackgroundTransparency = 1
DropdownClickArea.Text = ""
DropdownClickArea.ZIndex = 5
DropdownClickArea.Parent = MessageDropdown

-- Dropdown list
local DropdownList = Instance.new("ScrollingFrame")
DropdownList.Name = "DropdownList"
DropdownList.Size = UDim2.new(1, 0, 0, 120 * SCALE)
DropdownList.Position = UDim2.new(0, 0, 1, 4 * SCALE)
DropdownList.BackgroundColor3 = COLORS.DROPDOWN_BG
DropdownList.BorderSizePixel = 0
DropdownList.ScrollBarThickness = 4
DropdownList.ScrollBarImageColor3 = COLORS.ACCENT
DropdownList.ZIndex = 10
DropdownList.Visible = false
DropdownList.ClipsDescendants = true
DropdownList.Parent = MessageDropdown
applyCorners(DropdownList)
applyShadow(DropdownList, 0.7)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = DropdownList

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 2)
UIPadding.PaddingRight = UDim.new(0, 2)
UIPadding.PaddingBottom = UDim.new(0, 2)
UIPadding.PaddingLeft = UDim.new(0, 2)
UIPadding.Parent = DropdownList

-- Fake message input section
local FakeLabel = Instance.new("TextLabel")
FakeLabel.Name = "FakeLabel"
FakeLabel.Size = UDim2.new(1, 0, 0, 20 * SCALE)
FakeLabel.Position = UDim2.new(0, 0, 0, 125 * SCALE)
FakeLabel.BackgroundTransparency = 1
FakeLabel.Text = "Fake Message:"
FakeLabel.TextColor3 = COLORS.TEXT_PRIMARY
FakeLabel.TextSize = 15 * SCALE
FakeLabel.TextXAlignment = Enum.TextXAlignment.Left
FakeLabel.Font = Enum.Font.GothamSemibold
FakeLabel.Parent = ContentContainer

local FakeInput = Instance.new("TextBox")
FakeInput.Name = "FakeInput"
FakeInput.Size = UDim2.new(1, 0, 0, 38 * SCALE)
FakeInput.Position = UDim2.new(0, 0, 0, 150 * SCALE)
FakeInput.BackgroundColor3 = COLORS.DROPDOWN_BG
FakeInput.BorderSizePixel = 0
FakeInput.Text = "dementia is goated"
FakeInput.PlaceholderText = "What they'll see instead..."
FakeInput.TextColor3 = COLORS.TEXT_PRIMARY
FakeInput.TextSize = 14 * SCALE
FakeInput.ClearTextOnFocus = false
FakeInput.Font = Enum.Font.Gotham
FakeInput.Parent = ContentContainer
applyCorners(FakeInput)
applyPadding(FakeInput, 0, PADDING, 0, PADDING)

-- Apply button
local ApplyButton = Instance.new("TextButton")
ApplyButton.Name = "ApplyButton"
ApplyButton.Size = UDim2.new(1, 0, 0, 42 * SCALE)
ApplyButton.Position = UDim2.new(0, 0, 0, 200 * SCALE)
ApplyButton.BackgroundColor3 = COLORS.BUTTON
ApplyButton.BorderSizePixel = 0
ApplyButton.Text = "APPLY CHANGE"
ApplyButton.TextColor3 = COLORS.TEXT_PRIMARY
ApplyButton.TextSize = 16 * SCALE
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.Parent = ContentContainer
applyCorners(ApplyButton)
applyShadow(ApplyButton, 0.7)

-- Preset buttons container
local PresetContainer = Instance.new("Frame")
PresetContainer.Name = "PresetContainer"
PresetContainer.Size = UDim2.new(1, 0, 0, 30 * SCALE)
PresetContainer.Position = UDim2.new(0, 0, 0, 255 * SCALE)
PresetContainer.BackgroundTransparency = 1
PresetContainer.Parent = ContentContainer

local PresetLayout = Instance.new("UIGridLayout")
PresetLayout.CellSize = UDim2.new(0, 90 * SCALE, 0, 30 * SCALE)
PresetLayout.CellPadding = UDim2.new(0, 6 * SCALE, 0, 6 * SCALE)
PresetLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
PresetLayout.Parent = PresetContainer

-- Status indicator
local StatusContainer = Instance.new("Frame")
StatusContainer.Name = "StatusContainer"
StatusContainer.Size = UDim2.new(1, 0, 0, 24 * SCALE)
StatusContainer.Position = UDim2.new(0, 0, 1, -36 * SCALE)
StatusContainer.BackgroundTransparency = 1
StatusContainer.Parent = ContentContainer

local StatusDot = Instance.new("Frame")
StatusDot.Name = "StatusDot"
StatusDot.Size = UDim2.new(0, 10 * SCALE, 0, 10 * SCALE)
StatusDot.Position = UDim2.new(0, 0, 0.5, -5 * SCALE)
StatusDot.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = StatusContainer
applyCorners(StatusDot, 10)

local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, -16 * SCALE, 1, 0)
StatusText.Position = UDim2.new(0, 16 * SCALE, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Select a message to bamboozle"
StatusText.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusText.TextSize = 14 * SCALE
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = StatusContainer

-- Mini button (shown when main frame is hidden)
local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniButton"
MiniButton.Size = UDim2.new(0, 42, 0, 42)
MiniButton.Position = UDim2.new(0, 10, 0.1, 0)
MiniButton.BackgroundColor3 = COLORS.ACCENT
MiniButton.BorderSizePixel = 0
MiniButton.Text = "🤡"
MiniButton.TextColor3 = COLORS.TEXT_PRIMARY
MiniButton.TextSize = 24
MiniButton.Visible = false
MiniButton.Parent = ScreenGui
applyCorners(MiniButton, 10)
applyShadow(MiniButton, 0.7)

-- Variables for tracking state
local messageHistory = {}
local selectedMessageId = nil
local selectedMessageIndex = nil
local isDropdownOpen = false
local processedMessages = {}

-- Button hover effects
local function createButtonEffect(button, hoverColor)
    local defaultColor = button.BackgroundColor3
    
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    local function onHover()
        TweenService:Create(button, tweenInfo, {BackgroundColor3 = hoverColor}):Play()
    end
    
    local function onUnhover()
        TweenService:Create(button, tweenInfo, {BackgroundColor3 = defaultColor}):Play()
    end
    
    local function onPress()
        local scaleTween = TweenService:Create(
            button, 
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset * 0.95, button.Size.Y.Scale, button.Size.Y.Offset * 0.95)}
        )
        scaleTween:Play()
        
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.Position = UDim2.new(
            button.Position.X.Scale + (button.Size.X.Scale/2), 
            button.Position.X.Offset,
            button.Position.Y.Scale + (button.Size.Y.Scale/2), 
            button.Position.Y.Offset
        )
    end
    
    local function onRelease()
        local scaleTween = TweenService:Create(
            button, 
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset / 0.95, button.Size.Y.Scale, button.Size.Y.Offset / 0.95)}
        )
        scaleTween:Play()
    end
    
    button.MouseEnter:Connect(onHover)
    button.MouseLeave:Connect(onUnhover)
    button.MouseButton1Down:Connect(onPress)
    button.MouseButton1Up:Connect(onRelease)
end

createButtonEffect(ApplyButton, COLORS.BUTTON_HOVER)
createButtonEffect(MiniButton, COLORS.BUTTON_HOVER)

-- Function to create preset buttons
local function createPresetButton(text)
    local button = Instance.new("TextButton")
    button.Name = "Preset_" .. text
    button.BackgroundColor3 = COLORS.DROPDOWN_BG
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = COLORS.TEXT_PRIMARY
    button.TextSize = 13 * SCALE
    button.Font = Enum.Font.Gotham
    button.Parent = PresetContainer
    applyCorners(button, 6)
    
    createButtonEffect(button, COLORS.DROPDOWN_HOVER)
    
    button.MouseButton1Click:Connect(function()
        FakeInput.Text = text
    end)
    
    return button
end

createPresetButton("pick blue")
createPresetButton("free robux")
createPresetButton("i hacked")

-- Toggle dropdown function
local function toggleDropdown()
    if isDropdownOpen then
        isDropdownOpen = false
        DropdownList.Visible = false
        DropdownButton.Text = "▼"
    else
        -- Calculate position
        local spaceBelow = MainFrame.AbsoluteSize.Y - MessageDropdown.AbsolutePosition.Y - MessageDropdown.AbsoluteSize.Y - 
                         (FakeLabel.AbsolutePosition.Y - MainFrame.AbsolutePosition.Y)
        
        if isMobile or spaceBelow < 120 * SCALE then
            DropdownList.Position = UDim2.new(0, 0, 0, -120 * SCALE - 4 * SCALE)
        else
            DropdownList.Position = UDim2.new(0, 0, 1, 4 * SCALE)
        end
        
        isDropdownOpen = true
        DropdownList.Visible = true
        DropdownButton.Text = "▲"
    end
end

-- Update dropdown list function
function updateDropdownList()
    for _, child in pairs(DropdownList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local totalHeight = 0
    local itemHeight = 32 * SCALE

    for i, msgData in ipairs(messageHistory) do
        local listItem = Instance.new("TextButton")
        listItem.Size = UDim2.new(1, -4 * SCALE, 0, itemHeight)
        listItem.BackgroundColor3 = COLORS.DROPDOWN_BG
        listItem.BorderSizePixel = 0
        listItem.Text = msgData.text
        listItem.TextColor3 = COLORS.TEXT_PRIMARY
        listItem.TextSize = 14 * SCALE
        listItem.Font = Enum.Font.Gotham
        listItem.TextXAlignment = Enum.TextXAlignment.Left
        listItem.TextTruncate = Enum.TextTruncate.AtEnd
        listItem.Parent = DropdownList
        listItem.LayoutOrder = i
        listItem.TextWrapped = true
        listItem.ZIndex = 11
        applyCorners(listItem, 4)
        applyPadding(listItem, 0, 6 * SCALE, 0, 6 * SCALE)
        
        createButtonEffect(listItem, COLORS.DROPDOWN_HOVER)

        listItem.MouseButton1Click:Connect(function()
            SelectedMessage.Text = msgData.text
            selectedMessageId = msgData.id
            selectedMessageIndex = i
            isDropdownOpen = false
            DropdownList.Visible = false
            DropdownButton.Text = "▼"

            StatusText.Text = "Ready to bamboozle! Click Apply"
            StatusDot.BackgroundColor3 = COLORS.SUCCESS
        end)

        totalHeight = totalHeight + itemHeight + 2
    end

    DropdownList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- Event connections
DropdownButton.MouseButton1Click:Connect(toggleDropdown)
DropdownClickArea.MouseButton1Click:Connect(toggleDropdown)

MiniButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniButton.Visible = false
end)

HideButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniButton.Visible = true
end)

-- Detect clicks outside dropdown
UserInputService.InputBegan:Connect(function(input)
    if not isDropdownOpen then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then

        local position = UserInputService:GetMouseLocation()

        local dropdownAbsPosition = MessageDropdown.AbsolutePosition
        local dropdownAbsSize = MessageDropdown.AbsoluteSize
        local listAbsPosition = DropdownList.AbsolutePosition
        local listAbsSize = DropdownList.AbsoluteSize

        local insideDropdown = (position.X >= dropdownAbsPosition.X and 
                             position.X <= dropdownAbsPosition.X + dropdownAbsSize.X and
                             position.Y >= dropdownAbsPosition.Y and 
                             position.Y <= dropdownAbsPosition.Y + dropdownAbsSize.Y)

        local insideList = (position.X >= listAbsPosition.X and 
                         position.X <= listAbsPosition.X + listAbsSize.X and
                         position.Y >= listAbsPosition.Y and 
                         position.Y <= listAbsPosition.Y + listAbsSize.Y)

        if not insideDropdown and not insideList then
            isDropdownOpen = false
            DropdownList.Visible = false
            DropdownButton.Text = "▼"
        end
    end
end)

-- Track message history
TextChatService.OnIncomingMessage = function(message)
    if message.TextSource and message.TextSource.UserId == localPlayer.UserId then
        if processedMessages[message.MessageId] then
            return
        end

        processedMessages[message.MessageId] = true

        table.insert(messageHistory, 1, {
            id = message.MessageId,
            text = message.Text,
            timestamp = os.time()
        })

        if #messageHistory > 10 then
            table.remove(messageHistory, 11)
        end

        updateDropdownList()
    end
end

-- Apply message changes
ApplyButton.MouseButton1Click:Connect(function()
    if not selectedMessageId then
        StatusText.Text = "Select a message first!"
        StatusDot.BackgroundColor3 = COLORS.WARNING
        return
    end

    local fakeText = FakeInput.Text
    if fakeText == "" then fakeText = "subscribe to dementia" end

    local currentMessageId = selectedMessageId
    local currentIndex = selectedMessageIndex

    local success, error = pcall(function()
        replicatesignal(game.TextChatService.ClientToServerMessageReplicateSignalV2,
            fakeText,
            "b",
            currentMessageId, 
            TextChatService.TextChannels.RBXGeneral[localPlayer.Name],  
            TextChatService.TextChannels.RBXGeneral
        )
    end)

    if success then
        StatusDot.BackgroundColor3 = COLORS.SUCCESS
        StatusText.Text = "Message changed to: " .. fakeText

        if currentIndex and messageHistory[currentIndex] then
            messageHistory[currentIndex].text = fakeText
            updateDropdownList()
        end

        selectedMessageId = nil
        selectedMessageIndex = nil
        SelectedMessage.Text = "Select a message..."
    else
        StatusDot.BackgroundColor3 = COLORS.ERROR
        StatusText.Text = "Error! Try again."
    end
end)
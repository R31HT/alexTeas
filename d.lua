local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MessageBamboozlerGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- Adjust scale based on mobile
local scaleX = isMobile and 0.8 or 1
local scaleY = isMobile and 0.8 or 1
local baseWidth = 300 * scaleX
local baseHeight = 360 * scaleY

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, baseWidth, 0, baseHeight)
MainFrame.Position = UDim2.new(0.5, -baseWidth/2, isMobile and 0.1 or 0.5, -baseHeight/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35 * scaleY)
TitleBar.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🤡 Message Bamboozler 🤡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18 * scaleY
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

local HideButton = Instance.new("TextButton")
HideButton.Name = "HideButton" 
HideButton.Size = UDim2.new(0, 35 * scaleX, 0, 35 * scaleY)
HideButton.Position = UDim2.new(1, -35 * scaleX, 0, 0)
HideButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
HideButton.BorderSizePixel = 0
HideButton.Text = "-"
HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideButton.TextSize = 28 * scaleY
HideButton.Font = Enum.Font.GothamBold
HideButton.Parent = TitleBar

local Description = Instance.new("TextLabel")
Description.Name = "Description"
Description.Size = UDim2.new(1, -20 * scaleX, 0, 40 * scaleY)
Description.Position = UDim2.new(0, 10 * scaleX, 0, 40 * scaleY)
Description.BackgroundTransparency = 1
Description.Text = "Select one of your messages and change what it appears to say!"
Description.TextColor3 = Color3.fromRGB(255, 255, 255)
Description.TextSize = isMobile and 14 or 14
Description.TextWrapped = true
Description.Font = Enum.Font.Gotham
Description.Parent = MainFrame

local HistoryLabel = Instance.new("TextLabel")
HistoryLabel.Name = "HistoryLabel"
HistoryLabel.Size = UDim2.new(0, 150 * scaleX, 0, 20 * scaleY)
HistoryLabel.Position = UDim2.new(0, 15 * scaleX, 0, 80 * scaleY)
HistoryLabel.BackgroundTransparency = 1
HistoryLabel.Text = "Your Recent Messages:"
HistoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HistoryLabel.TextSize = isMobile and 16 or 16
HistoryLabel.TextXAlignment = Enum.TextXAlignment.Left
HistoryLabel.Font = Enum.Font.GothamSemibold
HistoryLabel.Parent = MainFrame

local dropdownWidth = 270 * scaleX
local dropdownHeight = 35 * scaleY

local MessageDropdown = Instance.new("Frame")
MessageDropdown.Name = "MessageDropdown"
MessageDropdown.Size = UDim2.new(0, dropdownWidth, 0, dropdownHeight)
MessageDropdown.Position = UDim2.new(0, 15 * scaleX, 0, 100 * scaleY)
MessageDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MessageDropdown.BorderColor3 = Color3.fromRGB(100, 100, 100)
MessageDropdown.Parent = MainFrame

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 6)
DropdownCorner.Parent = MessageDropdown

local SelectedMessage = Instance.new("TextLabel")
SelectedMessage.Name = "SelectedMessage"
SelectedMessage.Size = UDim2.new(1, -35 * scaleX, 1, 0)
SelectedMessage.Position = UDim2.new(0, 10 * scaleX, 0, 0)
SelectedMessage.BackgroundTransparency = 1
SelectedMessage.Text = "Select a message..."
SelectedMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedMessage.TextSize = isMobile and 16 or 16
SelectedMessage.TextXAlignment = Enum.TextXAlignment.Left
SelectedMessage.Font = Enum.Font.Gotham
SelectedMessage.TextTruncate = Enum.TextTruncate.AtEnd
SelectedMessage.Parent = MessageDropdown

local DropdownButton = Instance.new("TextButton")
DropdownButton.Name = "DropdownButton"
DropdownButton.Size = UDim2.new(0, 35 * scaleX, 1, 0)
DropdownButton.Position = UDim2.new(1, -35 * scaleX, 0, 0)
DropdownButton.BackgroundTransparency = 1
DropdownButton.Text = "▼"
DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DropdownButton.TextSize = isMobile and 16 or 16
DropdownButton.Font = Enum.Font.GothamBold
DropdownButton.Parent = MessageDropdown

-- Make the entire dropdown frame clickable
local DropdownClickArea = Instance.new("TextButton")
DropdownClickArea.Name = "DropdownClickArea"
DropdownClickArea.Size = UDim2.new(1, 0, 1, 0)
DropdownClickArea.BackgroundTransparency = 1
DropdownClickArea.Text = ""
DropdownClickArea.ZIndex = 5
DropdownClickArea.Parent = MessageDropdown

-- Position the dropdown list below the dropdown button on desktop, and adjusted for mobile
local dropdownListHeight = 110 * scaleY
local DropdownList = Instance.new("ScrollingFrame")
DropdownList.Name = "DropdownList"
DropdownList.Size = UDim2.new(0, dropdownWidth, 0, dropdownListHeight)
DropdownList.Position = UDim2.new(0, 0, 1, 2) -- Position just below the dropdown
DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DropdownList.BorderColor3 = Color3.fromRGB(100, 100, 100)
DropdownList.ScrollBarThickness = isMobile and 6 or 6
DropdownList.ZIndex = 10
DropdownList.Visible = false
DropdownList.Parent = MessageDropdown

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 6)
ListCorner.Parent = DropdownList

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = DropdownList

local fakeInputY = 145 * scaleY

local FakeLabel = Instance.new("TextLabel")
FakeLabel.Name = "FakeLabel"
FakeLabel.Size = UDim2.new(0, 150 * scaleX, 0, 22 * scaleY)
FakeLabel.Position = UDim2.new(0, 15 * scaleX, 0, fakeInputY)
FakeLabel.BackgroundTransparency = 1
FakeLabel.Text = "Fake Message:"
FakeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FakeLabel.TextSize = isMobile and 16 or 16
FakeLabel.TextXAlignment = Enum.TextXAlignment.Left
FakeLabel.Font = Enum.Font.GothamSemibold
FakeLabel.Parent = MainFrame

local FakeInput = Instance.new("TextBox")
FakeInput.Name = "FakeInput"
FakeInput.Size = UDim2.new(0, 270 * scaleX, 0, 35 * scaleY)
FakeInput.Position = UDim2.new(0, 15 * scaleX, 0, fakeInputY + 22 * scaleY)
FakeInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FakeInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
FakeInput.Text = "dementia is goated"
FakeInput.PlaceholderText = "What they'll see instead..."
FakeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FakeInput.TextSize = isMobile and 16 or 16
FakeInput.ClearTextOnFocus = false
FakeInput.Font = Enum.Font.Gotham
FakeInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = FakeInput

local applyButtonY = fakeInputY + 65 * scaleY

local ApplyButton = Instance.new("TextButton")
ApplyButton.Name = "ApplyButton"
ApplyButton.Size = UDim2.new(0, 140 * scaleX, 0, 42 * scaleY)
ApplyButton.Position = UDim2.new(0.5, -70 * scaleX, 0, applyButtonY)
ApplyButton.BackgroundColor3 = Color3.fromRGB(65, 180, 65)
ApplyButton.BorderColor3 = Color3.fromRGB(40, 120, 40)
ApplyButton.Text = "APPLY CHANGE"
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.TextSize = isMobile and 16 or 16
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = ApplyButton

local presetY = applyButtonY + 52 * scaleY

local PresetContainer = Instance.new("Frame")
PresetContainer.Name = "PresetContainer"
PresetContainer.Size = UDim2.new(0, 270 * scaleX, 0, 35 * scaleY)
PresetContainer.Position = UDim2.new(0, 15 * scaleX, 0, presetY)
PresetContainer.BackgroundTransparency = 1
PresetContainer.Parent = MainFrame

local statusY = baseHeight - 30 * scaleY

local StatusDot = Instance.new("Frame")
StatusDot.Name = "StatusDot"
StatusDot.Size = UDim2.new(0, 10 * scaleX, 0, 10 * scaleY)
StatusDot.Position = UDim2.new(0, 15 * scaleX, 0, statusY)
StatusDot.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = MainFrame

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = StatusDot

local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, -35 * scaleX, 0, 22 * scaleY)
StatusText.Position = UDim2.new(0, 30 * scaleX, 0, statusY - 6 * scaleY)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Select a message to bamboozle"
StatusText.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusText.TextSize = isMobile and 14 or 14
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = MainFrame

local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniButton"
MiniButton.Size = UDim2.new(0, isMobile and 40 or 40, 0, isMobile and 40 or 40)
MiniButton.Position = UDim2.new(0, 5, 0.1, 0)
MiniButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniButton.BorderSizePixel = 0
MiniButton.Text = "🤡"
MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniButton.TextSize = isMobile and 22 or 22
MiniButton.Visible = false
MiniButton.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0.2, 0)
MiniCorner.Parent = MiniButton

local messageHistory = {}
local selectedMessageId = nil
local selectedMessageIndex = nil
local isDropdownOpen = false
local processedMessages = {}

MiniButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniButton.Visible = false
end)

HideButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniButton.Visible = true
end)

-- Make both the dropdown button and the entire frame clickable to toggle the dropdown
local function toggleDropdown()
    if isDropdownOpen then
        isDropdownOpen = false
        DropdownList.Visible = false
        DropdownButton.Text = "▼"
    else
        -- Ensure dropdown doesn't overlap with other elements
        -- Calculate space needed
        local spaceBelow = (MainFrame.AbsoluteSize.Y - MessageDropdown.AbsolutePosition.Y - MessageDropdown.AbsoluteSize.Y) - 
                          (FakeLabel.AbsolutePosition.Y - MainFrame.AbsolutePosition.Y)
        
        if isMobile or spaceBelow < dropdownListHeight then
            -- Not enough space below, place it above
            DropdownList.Position = UDim2.new(0, 0, 0, -dropdownListHeight - 2)
        else
            -- Enough space below, place it below
            DropdownList.Position = UDim2.new(0, 0, 1, 2)
        end
        
        isDropdownOpen = true
        DropdownList.Visible = true
        DropdownButton.Text = "▲"
    end
end

DropdownButton.MouseButton1Click:Connect(toggleDropdown)
DropdownClickArea.MouseButton1Click:Connect(toggleDropdown)

-- Close dropdown when clicking outside
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

local function removeMessageFromHistory(messageId)
    for i, msgData in ipairs(messageHistory) do
        if msgData.id == messageId then
            table.remove(messageHistory, i)
            return true
        end
    end
    return false
end

function updateDropdownList()
    for _, child in pairs(DropdownList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local totalHeight = 0
    local itemHeight = isMobile and 35 or 35

    for i, msgData in ipairs(messageHistory) do
        local listItem = Instance.new("TextButton")
        listItem.Size = UDim2.new(1, -10, 0, itemHeight)
        listItem.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        listItem.BorderSizePixel = 0
        listItem.Text = msgData.text
        listItem.TextColor3 = Color3.fromRGB(255, 255, 255)
        listItem.TextSize = isMobile and 14 or 14
        listItem.Font = Enum.Font.Gotham
        listItem.TextXAlignment = Enum.TextXAlignment.Left
        listItem.TextTruncate = Enum.TextTruncate.AtEnd
        listItem.Parent = DropdownList
        listItem.LayoutOrder = i
        listItem.TextWrapped = true
        listItem.ZIndex = 11

        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 4)
        ItemCorner.Parent = listItem

        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, 8 * scaleX)
        UIPadding.Parent = listItem

        listItem.MouseButton1Click:Connect(function()
            SelectedMessage.Text = msgData.text
            selectedMessageId = msgData.id
            selectedMessageIndex = i
            isDropdownOpen = false
            DropdownList.Visible = false
            DropdownButton.Text = "▼"

            StatusText.Text = "Ready to bamboozle! Click Apply"
            StatusDot.BackgroundColor3 = Color3.fromRGB(65, 180, 65)
        end)

        totalHeight = totalHeight + itemHeight + 2
    end

    DropdownList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

local function createPresetButton(text, position)
    local buttonWidth = isMobile and 75 * scaleX or 80 * scaleX
    local spacing = isMobile and 7.5 * scaleX or 7.5 * scaleX
    local xPos = position * (buttonWidth + spacing)

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, buttonWidth, 0, 30 * scaleY)
    button.Position = UDim2.new(0, xPos, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderColor3 = Color3.fromRGB(100, 100, 100)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = isMobile and 12 or 12
    button.Font = Enum.Font.Gotham
    button.Parent = PresetContainer

    local PresetCorner = Instance.new("UICorner")
    PresetCorner.CornerRadius = UDim.new(0, 6)
    PresetCorner.Parent = button

    button.MouseButton1Click:Connect(function()
        FakeInput.Text = text
    end)

    return button
end

createPresetButton("pick blue", 0)
createPresetButton("free robux", 1)
createPresetButton("i hacked", 2)

ApplyButton.MouseButton1Click:Connect(function()
    if not selectedMessageId then
        StatusText.Text = "Select a message first!"
        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
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
        StatusDot.BackgroundColor3 = Color3.fromRGB(65, 180, 65)
        StatusText.Text = "Message changed to: " .. fakeText

        if currentIndex and messageHistory[currentIndex] then
            messageHistory[currentIndex].text = fakeText

            updateDropdownList()
        end

        selectedMessageId = nil
        selectedMessageIndex = nil
        SelectedMessage.Text = "Select a message..."
    else
        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        StatusText.Text = "Error! Try again."
    end
end)

local function addButtonEffect(button)
    local originalColor = button.BackgroundColor3
    local originalSize = button.Size

    button.MouseButton1Down:Connect(function()
        button:TweenSize(
            UDim2.new(originalSize.X.Scale, originalSize.X.Offset * 0.95, 
                      originalSize.Y.Scale, originalSize.Y.Offset * 0.95),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.1,
            true
        )

        button.BackgroundColor3 = Color3.fromRGB(
            math.max(originalColor.R * 255 - 20, 0),
            math.max(originalColor.G * 255 - 20, 0),
            math.max(originalColor.B * 255 - 20, 0)
        )
    end)

    button.MouseButton1Up:Connect(function()
        button:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
        button.BackgroundColor3 = originalColor
    end)
end

addButtonEffect(ApplyButton)
addButtonEffect(DropdownButton)
addButtonEffect(HideButton)
addButtonEffect(MiniButton)
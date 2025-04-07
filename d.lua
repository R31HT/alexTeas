local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- Check if the user is on mobile
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

-- Troll GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MessageBamboozlerGUI"
ScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- Scale factors for mobile optimization
local scaleX = isMobile and 1.2 or 1
local scaleY = isMobile and 1.2 or 1
local baseWidth = 300 * scaleX
local baseHeight = 300 * scaleY

-- Main Frame with trollface theme
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, baseWidth, 0, baseHeight)
MainFrame.Position = UDim2.new(0.5, -baseWidth/2, isMobile and 0.5 or 0.7, -baseHeight/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30 * scaleY)
TitleBar.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🤡 Message Bamboozler 🤡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16 * scaleY
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

-- Hide/Show Button
local HideButton = Instance.new("TextButton")
HideButton.Name = "HideButton"
HideButton.Size = UDim2.new(0, 30 * scaleX, 0, 30 * scaleY)
HideButton.Position = UDim2.new(1, -30 * scaleX, 0, 0)
HideButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
HideButton.BorderSizePixel = 0
HideButton.Text = "-"
HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideButton.TextSize = 24 * scaleY
HideButton.Font = Enum.Font.GothamBold
HideButton.Parent = TitleBar

-- Description
local Description = Instance.new("TextLabel")
Description.Name = "Description"
Description.Size = UDim2.new(1, -20 * scaleX, 0, 40 * scaleY)
Description.Position = UDim2.new(0, 10 * scaleX, 0, 35 * scaleY)
Description.BackgroundTransparency = 1
Description.Text = "Select one of your messages and change what it appears to say!"
Description.TextColor3 = Color3.fromRGB(255, 255, 255)
Description.TextSize = isMobile and 14 or 12
Description.TextWrapped = true
Description.Font = Enum.Font.Gotham
Description.Parent = MainFrame

-- Message History Label
local HistoryLabel = Instance.new("TextLabel")
HistoryLabel.Name = "HistoryLabel"
HistoryLabel.Size = UDim2.new(0, 150 * scaleX, 0, 20 * scaleY)
HistoryLabel.Position = UDim2.new(0, 15 * scaleX, 0, 75 * scaleY)
HistoryLabel.BackgroundTransparency = 1
HistoryLabel.Text = "Your Recent Messages:"
HistoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HistoryLabel.TextSize = isMobile and 16 or 14
HistoryLabel.TextXAlignment = Enum.TextXAlignment.Left
HistoryLabel.Font = Enum.Font.GothamSemibold
HistoryLabel.Parent = MainFrame

-- Calculate dropdown position and size
local dropdownWidth = 270 * scaleX
local dropdownHeight = 30 * scaleY

-- Message History Dropdown
local MessageDropdown = Instance.new("Frame")
MessageDropdown.Name = "MessageDropdown"
MessageDropdown.Size = UDim2.new(0, dropdownWidth, 0, dropdownHeight)
MessageDropdown.Position = UDim2.new(0, 15 * scaleX, 0, 95 * scaleY)
MessageDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MessageDropdown.BorderColor3 = Color3.fromRGB(100, 100, 100)
MessageDropdown.Parent = MainFrame

local SelectedMessage = Instance.new("TextLabel")
SelectedMessage.Name = "SelectedMessage"
SelectedMessage.Size = UDim2.new(1, -30 * scaleX, 1, 0)
SelectedMessage.Position = UDim2.new(0, 5 * scaleX, 0, 0)
SelectedMessage.BackgroundTransparency = 1
SelectedMessage.Text = "Select a message..."
SelectedMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedMessage.TextSize = isMobile and 16 or 14
SelectedMessage.TextXAlignment = Enum.TextXAlignment.Left
SelectedMessage.Font = Enum.Font.Gotham
SelectedMessage.TextTruncate = Enum.TextTruncate.AtEnd
SelectedMessage.Parent = MessageDropdown

local DropdownButton = Instance.new("TextButton")
DropdownButton.Name = "DropdownButton"
DropdownButton.Size = UDim2.new(0, 30 * scaleX, 1, 0)
DropdownButton.Position = UDim2.new(1, -30 * scaleX, 0, 0)
DropdownButton.BackgroundTransparency = 1
DropdownButton.Text = "▼"
DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DropdownButton.TextSize = isMobile and 16 or 14
DropdownButton.Font = Enum.Font.GothamBold
DropdownButton.Parent = MessageDropdown

-- Dropdown List (Initially hidden)
local DropdownList = Instance.new("ScrollingFrame")
DropdownList.Name = "DropdownList"
DropdownList.Size = UDim2.new(0, dropdownWidth, 0, isMobile and 120 or 100) -- Taller on mobile
DropdownList.Position = UDim2.new(0, 0, 1, 0)
DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DropdownList.BorderColor3 = Color3.fromRGB(100, 100, 100)
DropdownList.ScrollBarThickness = isMobile and 6 or 4 -- Thicker scrollbar for mobile
DropdownList.ZIndex = 10 -- Ensure dropdown appears above other elements
DropdownList.Visible = false
DropdownList.Parent = MessageDropdown

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = DropdownList

-- Fake Message Input (positioned below the dropdown list's maximum extent)
local fakeInputY = 135 * scaleY
if isMobile then
    fakeInputY = 155 * scaleY -- Move down a bit more on mobile to avoid overlap
end

local FakeLabel = Instance.new("TextLabel")
FakeLabel.Name = "FakeLabel"
FakeLabel.Size = UDim2.new(0, 150 * scaleX, 0, 20 * scaleY)
FakeLabel.Position = UDim2.new(0, 15 * scaleX, 0, fakeInputY)
FakeLabel.BackgroundTransparency = 1
FakeLabel.Text = "Fake Message:"
FakeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FakeLabel.TextSize = isMobile and 16 or 14
FakeLabel.TextXAlignment = Enum.TextXAlignment.Left
FakeLabel.Font = Enum.Font.GothamSemibold
FakeLabel.Parent = MainFrame

local FakeInput = Instance.new("TextBox")
FakeInput.Name = "FakeInput"
FakeInput.Size = UDim2.new(0, 270 * scaleX, 0, 30 * scaleY)
FakeInput.Position = UDim2.new(0, 15 * scaleX, 0, fakeInputY + 20 * scaleY)
FakeInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FakeInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
FakeInput.Text = "pick blue"
FakeInput.PlaceholderText = "What they'll see instead..."
FakeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FakeInput.TextSize = isMobile and 16 or 14
FakeInput.ClearTextOnFocus = false
FakeInput.Font = Enum.Font.Gotham
FakeInput.Parent = MainFrame

-- Apply Button (positioned below the fake input)
local applyButtonY = fakeInputY + 60 * scaleY

local ApplyButton = Instance.new("TextButton")
ApplyButton.Name = "ApplyButton"
ApplyButton.Size = UDim2.new(0, 120 * scaleX, 0, 35 * scaleY) -- Taller on mobile
ApplyButton.Position = UDim2.new(0.5, -60 * scaleX, 0, applyButtonY)
ApplyButton.BackgroundColor3 = Color3.fromRGB(65, 180, 65)
ApplyButton.BorderColor3 = Color3.fromRGB(40, 120, 40)
ApplyButton.Text = "APPLY CHANGE"
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.TextSize = isMobile and 16 or 14
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.Parent = MainFrame

-- Preset Button Container - reposition below Apply Button
local presetY = applyButtonY + 45 * scaleY

local PresetContainer = Instance.new("Frame")
PresetContainer.Name = "PresetContainer"
PresetContainer.Size = UDim2.new(0, 270 * scaleX, 0, 30 * scaleY)
PresetContainer.Position = UDim2.new(0, 15 * scaleX, 0, presetY)
PresetContainer.BackgroundTransparency = 1
PresetContainer.Parent = MainFrame

-- Status indicator - moved to the very bottom
local statusY = presetY + 35 * scaleY

local StatusDot = Instance.new("Frame")
StatusDot.Name = "StatusDot"
StatusDot.Size = UDim2.new(0, 8 * scaleX, 0, 8 * scaleY)
StatusDot.Position = UDim2.new(0, 15 * scaleX, 0, statusY)
StatusDot.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = MainFrame

local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, -35 * scaleX, 0, 20 * scaleY)
StatusText.Position = UDim2.new(0, 30 * scaleX, 0, statusY - 6 * scaleY)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Select a message to bamboozle"
StatusText.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusText.TextSize = isMobile and 14 or 12
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = MainFrame

-- Mini button to show GUI when hidden (made bigger for mobile)
local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniButton"
MiniButton.Size = UDim2.new(0, isMobile and 40 or 30, 0, isMobile and 40 or 30)
MiniButton.Position = UDim2.new(0, 5, 0, -35 * scaleY)
MiniButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniButton.BorderSizePixel = 0
MiniButton.Text = "🤡"
MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniButton.TextSize = isMobile and 24 or 18
MiniButton.Visible = false
MiniButton.Parent = ScreenGui

-- Script Variables
local messageHistory = {}
local selectedMessageId = nil
local selectedMessageIndex = nil
local isDropdownOpen = false

-- Mini Button Logic
MiniButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniButton.Visible = false
end)

-- Hide Button Logic
HideButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniButton.Visible = true
end)

-- Dropdown Toggle Logic
DropdownButton.MouseButton1Click:Connect(function()
    isDropdownOpen = not isDropdownOpen
    DropdownList.Visible = isDropdownOpen
    DropdownButton.Text = isDropdownOpen and "▲" or "▼" -- Change arrow direction
end)

-- Close dropdown when clicking elsewhere
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        local position = input.Position
        local dropdownAbsPosition = MessageDropdown.AbsolutePosition
        local dropdownAbsSize = MessageDropdown.AbsoluteSize
        local listAbsPosition = DropdownList.AbsolutePosition
        local listAbsSize = DropdownList.AbsoluteSize
        
        -- If click/touch is outside the dropdown and list
        if isDropdownOpen and
           not (position.X >= dropdownAbsPosition.X and 
                position.X <= dropdownAbsPosition.X + dropdownAbsSize.X and
                position.Y >= dropdownAbsPosition.Y and 
                position.Y <= dropdownAbsPosition.Y + dropdownAbsSize.Y) and
           not (position.X >= listAbsPosition.X and 
                position.X <= listAbsPosition.X + listAbsSize.X and
                position.Y >= listAbsPosition.Y and 
                position.Y <= listAbsPosition.Y + listAbsSize.Y) then
            isDropdownOpen = false
            DropdownList.Visible = false
            DropdownButton.Text = "▼"
        end
    end
end)

-- Message history tracker
TextChatService.OnIncomingMessage = function(message)
    if message.TextSource and message.TextSource.UserId == localPlayer.UserId then
        -- Add to our message history (only keep last 10)
        table.insert(messageHistory, 1, {
            id = message.MessageId,
            text = message.Text,
            timestamp = os.time()
        })
        
        -- Limit to 10 messages
        if #messageHistory > 10 then
            table.remove(messageHistory, 11)
        end
        
        -- Update dropdown list
        updateDropdownList()
    end
end

-- Function to find and remove a message from history by ID
local function removeMessageFromHistory(messageId)
    for i, msgData in ipairs(messageHistory) do
        if msgData.id == messageId then
            table.remove(messageHistory, i)
            return true
        end
    end
    return false
end

-- Function to update the dropdown list items
function updateDropdownList()
    -- Clear existing items
    for _, child in pairs(DropdownList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Fill with message history
    local totalHeight = 0
    local itemHeight = isMobile and 40 or 30 -- Taller items on mobile
    
    for i, msgData in ipairs(messageHistory) do
        local listItem = Instance.new("TextButton")
        listItem.Size = UDim2.new(1, -8, 0, itemHeight)
        listItem.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        listItem.BorderSizePixel = 0
        listItem.Text = msgData.text
        listItem.TextColor3 = Color3.fromRGB(255, 255, 255)
        listItem.TextSize = isMobile and 16 or 14
        listItem.Font = Enum.Font.Gotham
        listItem.TextXAlignment = Enum.TextXAlignment.Left
        listItem.TextTruncate = Enum.TextTruncate.AtEnd
        listItem.Parent = DropdownList
        listItem.LayoutOrder = i
        listItem.TextWrapped = true
        listItem.ZIndex = 11 -- Ensure list items appear above other elements
        
        -- Add padding
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, 5 * scaleX)
        UIPadding.Parent = listItem
        
        -- Click to select
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
        
        totalHeight = totalHeight + itemHeight
    end
    
    -- Update scrolling frame canvas size
    DropdownList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- Add preset troll messages (quick buttons) with proper spacing for mobile
local function createPresetButton(text, position)
    local buttonWidth = isMobile and 85 * scaleX or 80 * scaleX
    local spacing = isMobile and 5 * scaleX or 7.5 * scaleX
    local xPos = position * (buttonWidth + spacing)
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, buttonWidth, 0, 25 * scaleY)
    button.Position = UDim2.new(0, xPos, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderColor3 = Color3.fromRGB(100, 100, 100)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = isMobile and 12 or 10
    button.Font = Enum.Font.Gotham
    button.Parent = PresetContainer
    
    button.MouseButton1Click:Connect(function()
        FakeInput.Text = text
    end)
    
    return button
end

-- Create preset buttons with proper spacing
createPresetButton("pick blue", 0)
createPresetButton("free robux", 1)
createPresetButton("i hacked", 2)

-- Apply button logic
ApplyButton.MouseButton1Click:Connect(function()
    if not selectedMessageId then
        StatusText.Text = "Select a message first!"
        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- Orange for warning
        return
    end
    
    -- Get the fake message text
    local fakeText = FakeInput.Text
    if fakeText == "" then fakeText = "pick blue" end
    
    -- Store the selected message ID before it gets cleared
    local currentMessageId = selectedMessageId
    local currentIndex = selectedMessageIndex
    
    -- Try to replicate signal ONLY ONCE for the selected message
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
        StatusDot.BackgroundColor3 = Color3.fromRGB(65, 180, 65) -- Green for success
        StatusText.Text = "Message changed to: " .. fakeText
        
        -- Update the message in our history
        if currentIndex and messageHistory[currentIndex] then
            -- Add the edited message at the top of the history
            table.insert(messageHistory, 1, {
                id = currentMessageId,
                text = fakeText,
                timestamp = os.time()
            })
            
            -- Remove the old message from the history
            table.remove(messageHistory, currentIndex + 1)
            
            -- Update the dropdown
            updateDropdownList()
        end
        
        -- Clear selection after successful edit
        selectedMessageId = nil
        selectedMessageIndex = nil
        SelectedMessage.Text = "Select a message..."
    else
        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red for error
        StatusText.Text = "Error! Try again."
    end
end)
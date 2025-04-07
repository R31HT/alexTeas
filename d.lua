local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- Check if the user is on mobile with more reliable detection
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

-- Troll GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MessageBamboozlerGUI"
ScreenGui.ResetOnSpawn = false -- Keep GUI when character respawns
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- Scale factors based on device type 
-- Increased scaling for mobile to make everything bigger and more touch-friendly
local scaleX = isMobile and 1.1 or 1
local scaleY = isMobile and 1.1 or 1
local baseWidth = 300 * scaleX
local baseHeight = 360 * scaleY -- Increased base height to fit everything properly

-- Main Frame with trollface theme
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, baseWidth, 0, baseHeight)
MainFrame.Position = UDim2.new(0.5, -baseWidth/2, isMobile and 0.15 or 0.5, -baseHeight/2) -- Higher position on mobile
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Add rounded corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Add trollface background image
local TrollBackground = Instance.new("ImageLabel")
TrollBackground.Size = UDim2.new(1, 0, 1, 0)
TrollBackground.BackgroundTransparency = 1
TrollBackground.Image = "rbxassetid://11797062053" -- Trollface asset ID
TrollBackground.ImageTransparency = 0.9 -- Very faint background
TrollBackground.ScaleType = Enum.ScaleType.Fit
TrollBackground.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35 * scaleY) -- Taller title bar for mobile
TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Rounded corners for title bar
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Trollface icon for title
local TitleIcon = Instance.new("ImageLabel")
TitleIcon.Size = UDim2.new(0, 25 * scaleY, 0, 25 * scaleY)
TitleIcon.Position = UDim2.new(0, 5 * scaleX, 0.5, -12.5 * scaleY)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Image = "rbxassetid://11797062053" -- Trollface asset ID
TitleIcon.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -35 * scaleX, 1, 0)
Title.Position = UDim2.new(0, 35 * scaleX, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Message Bamboozler"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18 * scaleY -- Larger text for mobile
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

-- Hide/Show Button
local HideButton = Instance.new("TextButton")
HideButton.Name = "HideButton" 
HideButton.Size = UDim2.new(0, 35 * scaleX, 0, 35 * scaleY) -- Larger button for mobile
HideButton.Position = UDim2.new(1, -35 * scaleX, 0, 0)
HideButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
HideButton.BorderSizePixel = 0
HideButton.Text = "-"
HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideButton.TextSize = 28 * scaleY -- Larger text
HideButton.Font = Enum.Font.GothamBold
HideButton.Parent = TitleBar

-- Description
local Description = Instance.new("TextLabel")
Description.Name = "Description"
Description.Size = UDim2.new(1, -20 * scaleX, 0, 40 * scaleY)
Description.Position = UDim2.new(0, 10 * scaleX, 0, 40 * scaleY)
Description.BackgroundTransparency = 1
Description.Text = "Select one of your messages and change what it appears to say!"
Description.TextColor3 = Color3.fromRGB(255, 255, 255)
Description.TextSize = isMobile and 16 or 14 -- Larger text for mobile
Description.TextWrapped = true
Description.Font = Enum.Font.Gotham
Description.Parent = MainFrame

-- Message History Label
local HistoryLabel = Instance.new("TextLabel")
HistoryLabel.Name = "HistoryLabel"
HistoryLabel.Size = UDim2.new(0, 150 * scaleX, 0, 20 * scaleY)
HistoryLabel.Position = UDim2.new(0, 15 * scaleX, 0, 80 * scaleY)
HistoryLabel.BackgroundTransparency = 1
HistoryLabel.Text = "Your Recent Messages:"
HistoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HistoryLabel.TextSize = isMobile and 18 or 16 -- Larger text for mobile
HistoryLabel.TextXAlignment = Enum.TextXAlignment.Left
HistoryLabel.Font = Enum.Font.GothamSemibold
HistoryLabel.Parent = MainFrame

-- Calculate dropdown position and size
local dropdownWidth = 270 * scaleX
local dropdownHeight = 35 * scaleY -- Taller dropdown for mobile

-- Message History Dropdown
local MessageDropdown = Instance.new("Frame")
MessageDropdown.Name = "MessageDropdown"
MessageDropdown.Size = UDim2.new(0, dropdownWidth, 0, dropdownHeight)
MessageDropdown.Position = UDim2.new(0, 15 * scaleX, 0, 100 * scaleY)
MessageDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MessageDropdown.BorderColor3 = Color3.fromRGB(100, 100, 100)
MessageDropdown.Parent = MainFrame

-- Rounded corners for dropdown
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
SelectedMessage.TextSize = isMobile and 18 or 16 -- Larger text for mobile
SelectedMessage.TextXAlignment = Enum.TextXAlignment.Left
SelectedMessage.Font = Enum.Font.Gotham
SelectedMessage.TextTruncate = Enum.TextTruncate.AtEnd
SelectedMessage.Parent = MessageDropdown

local DropdownButton = Instance.new("TextButton")
DropdownButton.Name = "DropdownButton"
DropdownButton.Size = UDim2.new(0, 35 * scaleX, 1, 0) -- Wider button for mobile
DropdownButton.Position = UDim2.new(1, -35 * scaleX, 0, 0)
DropdownButton.BackgroundTransparency = 1
DropdownButton.Text = "▼"
DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DropdownButton.TextSize = isMobile and 18 or 16 -- Larger text for mobile
DropdownButton.Font = Enum.Font.GothamBold
DropdownButton.Parent = MessageDropdown

-- Dropdown List (Initially hidden)
local DropdownList = Instance.new("ScrollingFrame")
DropdownList.Name = "DropdownList"
DropdownList.Size = UDim2.new(0, dropdownWidth, 0, isMobile and 130 or 110) -- Taller on mobile
DropdownList.Position = UDim2.new(0, 0, 1, 0)
DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DropdownList.BorderColor3 = Color3.fromRGB(100, 100, 100)
DropdownList.ScrollBarThickness = isMobile and 8 or 6 -- Thicker scrollbar for mobile
DropdownList.ZIndex = 10 -- Ensure dropdown appears above other elements
DropdownList.Visible = false
DropdownList.Parent = MessageDropdown

-- Rounded corners for dropdown list
local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 6)
ListCorner.Parent = DropdownList

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2) -- Add spacing between items
UIListLayout.Parent = DropdownList

-- Fake Message Input (positioned below the dropdown list's maximum extent)
-- Increased the position to avoid overlap when dropdown is open
local fakeInputY = 170 * scaleY
if isMobile then
    fakeInputY = 175 * scaleY -- Move down more on mobile to avoid overlap
end

local FakeLabel = Instance.new("TextLabel")
FakeLabel.Name = "FakeLabel"
FakeLabel.Size = UDim2.new(0, 150 * scaleX, 0, 22 * scaleY)
FakeLabel.Position = UDim2.new(0, 15 * scaleX, 0, fakeInputY)
FakeLabel.BackgroundTransparency = 1
FakeLabel.Text = "Fake Message:"
FakeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FakeLabel.TextSize = isMobile and 18 or 16 -- Larger text for mobile
FakeLabel.TextXAlignment = Enum.TextXAlignment.Left
FakeLabel.Font = Enum.Font.GothamSemibold
FakeLabel.Parent = MainFrame

local FakeInput = Instance.new("TextBox")
FakeInput.Name = "FakeInput"
FakeInput.Size = UDim2.new(0, 270 * scaleX, 0, 35 * scaleY) -- Taller input for mobile
FakeInput.Position = UDim2.new(0, 15 * scaleX, 0, fakeInputY + 22 * scaleY)
FakeInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FakeInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
FakeInput.Text = "pick blue"
FakeInput.PlaceholderText = "What they'll see instead..."
FakeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FakeInput.TextSize = isMobile and 18 or 16 -- Larger text for mobile
FakeInput.ClearTextOnFocus = false
FakeInput.Font = Enum.Font.Gotham
FakeInput.Parent = MainFrame

-- Rounded corners for text input
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = FakeInput

-- Apply Button (positioned below the fake input)
local applyButtonY = fakeInputY + 65 * scaleY

local ApplyButton = Instance.new("TextButton")
ApplyButton.Name = "ApplyButton"
ApplyButton.Size = UDim2.new(0, 140 * scaleX, 0, 42 * scaleY) -- Taller and wider button for mobile
ApplyButton.Position = UDim2.new(0.5, -70 * scaleX, 0, applyButtonY)
ApplyButton.BackgroundColor3 = Color3.fromRGB(65, 180, 65)
ApplyButton.BorderColor3 = Color3.fromRGB(40, 120, 40)
ApplyButton.Text = "BAMBOOZLE"
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.TextSize = isMobile and 20 or 18 -- Larger text for mobile
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.Parent = MainFrame

-- Rounded corners for apply button
local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = ApplyButton

-- Preset Button Container - reposition below Apply Button
local presetY = applyButtonY + 52 * scaleY

local PresetContainer = Instance.new("Frame")
PresetContainer.Name = "PresetContainer"
PresetContainer.Size = UDim2.new(0, 270 * scaleX, 0, 35 * scaleY)
PresetContainer.Position = UDim2.new(0, 15 * scaleX, 0, presetY)
PresetContainer.BackgroundTransparency = 1
PresetContainer.Parent = MainFrame

-- Status indicator - moved to the very bottom with more space
local statusY = baseHeight - 30 * scaleY

local StatusDot = Instance.new("Frame")
StatusDot.Name = "StatusDot"
StatusDot.Size = UDim2.new(0, 10 * scaleX, 0, 10 * scaleY) -- Larger dot for mobile
StatusDot.Position = UDim2.new(0, 15 * scaleX, 0, statusY)
StatusDot.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = MainFrame

-- Round the status dot
local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0) -- Makes it a perfect circle
DotCorner.Parent = StatusDot

local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, -35 * scaleX, 0, 22 * scaleY)
StatusText.Position = UDim2.new(0, 30 * scaleX, 0, statusY - 6 * scaleY)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Ready to troll"
StatusText.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusText.TextSize = isMobile and 16 or 14 -- Larger text for mobile
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = MainFrame

-- Mini button to show GUI when hidden (made bigger for mobile and trollface themed)
local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniButton"
MiniButton.Size = UDim2.new(0, isMobile and 50 or 40, 0, isMobile and 50 or 40) -- Much bigger for mobile
MiniButton.Position = UDim2.new(0, 5, 0.1, 0) -- Better position for visibility
MiniButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniButton.BorderSizePixel = 0
MiniButton.Text = ""
MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniButton.TextSize = isMobile and 28 or 22 -- Larger text for mobile
MiniButton.Visible = false
MiniButton.Parent = ScreenGui

-- Add trollface icon to mini button
local MiniIcon = Instance.new("ImageLabel")
MiniIcon.Size = UDim2.new(0.8, 0, 0.8, 0)
MiniIcon.Position = UDim2.new(0.1, 0, 0.1, 0)
MiniIcon.BackgroundTransparency = 1
MiniIcon.Image = "rbxassetid://11797062053" -- Trollface asset ID
MiniIcon.Parent = MiniButton

-- Add shadow and rounded corners to mini button
local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0.2, 0)
MiniCorner.Parent = MiniButton

-- Script Variables
local messageHistory = {}
local selectedMessageId = nil
local selectedMessageIndex = nil
local isDropdownOpen = false
local processedMessages = {} -- Track message IDs we've already processed

-- Funny troll status messages
local trollStatusMessages = {
    "Problem?",
    "Epic troll time!",
    "They'll never know...",
    "Master bamboozler activated",
    "Le trollface.jpg",
    "Get rekt n00b",
    "Time to troll!",
    "Ultimate prankster mode",
    "Bamboozle = Foolzled",
    "We do a little trolling",
    "You mad, bro?",
    "Troll level: OVER 9000!",
    "Stealth: 100",
    "Chaos mode activated"
}

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
    
    -- Show a random troll message when opening dropdown
    if isDropdownOpen then
        local randomMessage = trollStatusMessages[math.random(1, #trollStatusMessages)]
        StatusText.Text = randomMessage
    end
end)

-- IMPROVED: Close dropdown only when clicking elsewhere in the GUI
-- We need to track input events more carefully
UserInputService.InputBegan:Connect(function(input)
    if not isDropdownOpen then return end -- Only check if dropdown is open
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        
        -- Get input position
        local position = UserInputService:GetMouseLocation()
        
        -- Get positions and sizes of relevant UI elements
        local dropdownAbsPosition = MessageDropdown.AbsolutePosition
        local dropdownAbsSize = MessageDropdown.AbsoluteSize
        local listAbsPosition = DropdownList.AbsolutePosition
        local listAbsSize = DropdownList.AbsoluteSize
        
        -- Check if click is inside dropdown or list
        local insideDropdown = (position.X >= dropdownAbsPosition.X and 
                             position.X <= dropdownAbsPosition.X + dropdownAbsSize.X and
                             position.Y >= dropdownAbsPosition.Y and 
                             position.Y <= dropdownAbsPosition.Y + dropdownAbsSize.Y)
                             
        local insideList = (position.X >= listAbsPosition.X and 
                         position.X <= listAbsPosition.X + listAbsSize.X and
                         position.Y >= listAbsPosition.Y and 
                         position.Y <= listAbsPosition.Y + listAbsSize.Y)
        
        -- Only close if click is outside both dropdown and list but inside MainFrame
        if not insideDropdown and not insideList then
            -- First make sure click is inside MainFrame (don't close when clicking outside GUI)
            local mainAbsPos = MainFrame.AbsolutePosition
            local mainAbsSize = MainFrame.AbsoluteSize
            
            local insideMain = (position.X >= mainAbsPos.X and 
                             position.X <= mainAbsPos.X + mainAbsSize.X and
                             position.Y >= mainAbsPos.Y and 
                             position.Y <= mainAbsPos.Y + mainAbsSize.Y)
                             
            if insideMain then
                isDropdownOpen = false
                DropdownList.Visible = false
                DropdownButton.Text = "▼"
            end
        end
    end
end)

-- -- Message history tracker with duplicate prevention
TextChatService.OnIncomingMessage = function(message)
    if message.TextSource and message.TextSource.UserId == localPlayer.UserId then
        -- Check if we've already processed this message ID
        if processedMessages[message.MessageId] then
            return -- Skip this message, we've already processed it
        end
        
        -- Mark this message as processed
        processedMessages[message.MessageId] = true
        
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
    local itemHeight = isMobile and 45 or 35 -- Much taller items on mobile for better touch targets

    for i, msgData in ipairs(messageHistory) do
        local listItem = Instance.new("TextButton")
        listItem.Size = UDim2.new(1, -10, 0, itemHeight)
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
        
        -- Add rounded corners to list items
        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 4)
        ItemCorner.Parent = listItem

        -- Add padding
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, 8 * scaleX)
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

        totalHeight = totalHeight + itemHeight + 2 -- Account for padding
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
    button.Size = UDim2.new(0, buttonWidth, 0, 30 * scaleY) -- Taller buttons for mobile
    button.Position = UDim2.new(0, xPos, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderColor3 = Color3.fromRGB(100, 100, 100)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = isMobile and 14 or 12 -- Larger text for mobile
    button.Font = Enum.Font.Gotham
    button.Parent = PresetContainer
    
    -- Add rounded corners to preset buttons
    local PresetCorner = Instance.new("UICorner")
    PresetCorner.CornerRadius = UDim.new(0, 6)
    PresetCorner.Parent = button

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
        -- Select a random success message
        local successMessages = {
            "Epic troll success!",
            "Bamboozled successfully!",
            "Trololol! It worked!",
            "They've been trolled!",
            "Message changed: " .. fakeText,
            "Le epic prank complete!",
            "Trollface.jpg activated",
            "Get rekt! Message changed"
        }
        local randomMsg = successMessages[math.random(1, #successMessages)]
        
        StatusDot.BackgroundColor3 = Color3.fromRGB(65, 180, 65) -- Green for success
        StatusText.Text = randomMsg

        -- Update the message in our history
        if currentIndex and messageHistory[currentIndex] then
            messageHistory[currentIndex].text = fakeText -- Update the message text directly
            
            -- Update the dropdown
            updateDropdownList()
        end

        -- Reset selection
        selectedMessageId = nil
        selectedMessageIndex = nil
        SelectedMessage.Text = "Select a message..."
    else
        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red for error
        StatusText.Text = "Error! Try again."
    end
end)

-- Mobile optimizations - detect viewport size and adjust accordingly
local function updateSizeBasedOnScreen()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    
    -- More intelligent sizing based on screen dimensions
    if viewportSize.Y < 400 then -- Very small height (extra small screen)
        scaleX = 0.9
        scaleY = 0.9
        MainFrame.Position = UDim2.new(0.5, -baseWidth/2 * scaleX, 0.15, 0) 
    elseif viewportSize.Y < 600 then -- Small height (typical mobile)
        scaleX = 1.0
        scaleY = 1.0
        MainFrame.Position = UDim2.new(0.5, -baseWidth/2 * scaleX, 0.2, 0)
    end
    
    -- Additional tweaks for very narrow screens
    if viewportSize.X < 400 then
        -- For extremely narrow screens, make GUI even more compact
        MainFrame.Size = UDim2.new(0.95, 0, 0, baseHeight * scaleY)
        MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset/2, 0.2, 0)
    end
    
    -- Adjust component sizes based on current scale
    MainFrame.Size = UDim2.new(0, baseWidth * scaleX, 0, baseHeight * scaleY)
    if not (viewportSize.X < 400) then -- Skip this if we've already set position for narrow screens
        MainFrame.Position = UDim2.new(0.5, -baseWidth/2 * scaleX, 0.3, 0)
    end
    
    -- Update internal components
    Title.Size = UDim2.new(1, 0, 0, 30 * scaleY)
    Title.TextSize = 18 * scaleY
    
    CloseButton.Position = UDim2.new(1, -25 * scaleX, 0, 5 * scaleY)
    CloseButton.Size = UDim2.new(0, 20 * scaleX, 0, 20 * scaleY)
    
    DropdownButton.Size = UDim2.new(0, 30 * scaleX, 0, 30 * scaleY)
    DropdownButton.Position = UDim2.new(1, -35 * scaleX, 0, 45 * scaleY)
    
    SelectedMessage.Size = UDim2.new(1, -45 * scaleX, 0, 30 * scaleY)
    SelectedMessage.Position = UDim2.new(0, 10 * scaleX, 0, 45 * scaleY)
    
    MessageInputLabel.Position = UDim2.new(0, 10 * scaleX, 0, 85 * scaleY)
    FakeInput.Position = UDim2.new(0, 10 * scaleX, 0, 105 * scaleY)
    FakeInput.Size = UDim2.new(1, -20 * scaleX, 0, 30 * scaleY)
    
    PresetLabel.Position = UDim2.new(0, 10 * scaleX, 0, 145 * scaleY)
    PresetContainer.Position = UDim2.new(0, 10 * scaleX, 0, 165 * scaleY)
    
    StatusContainer.Position = UDim2.new(0, 10 * scaleX, 0, 210 * scaleY)
    
    ApplyButton.Position = UDim2.new(0.5, -50 * scaleX, 0, 240 * scaleY)
    ApplyButton.Size = UDim2.new(0, 100 * scaleX, 0, 35 * scaleY)
    
    -- Update dropdown positioning
    DropdownList.Position = UDim2.new(0, 10 * scaleX, 0, 80 * scaleY)
    DropdownList.Size = UDim2.new(1, -20 * scaleX, 0, 150 * scaleY)
    
    -- Adjust preset buttons
    for i, button in ipairs(PresetContainer:GetChildren()) do
        if button:IsA("TextButton") then
            button:Destroy() -- Remove existing buttons
        end
    end
    
    -- Recreate preset buttons with new sizing
    createPresetButton("pick blue", 0)
    createPresetButton("free robux", 1)
    createPresetButton("i hacked", 2)
end

-- Add dragging ability to the frame
local isDragging = false
local dragInput
local dragStart
local startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    MainFrame.Position = newPosition
end

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and isDragging then
        updateDrag(input)
    end
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    MainGui:Destroy()
end)

-- Dropdown toggle
DropdownButton.MouseButton1Click:Connect(function()
    isDropdownOpen = not isDropdownOpen
    DropdownList.Visible = isDropdownOpen
    DropdownButton.Text = isDropdownOpen and "▲" or "▼"
end)

-- Initialize the GUI with appropriate sizing
updateSizeBasedOnScreen()

-- Handle window resize
UserInputService.WindowFocused:Connect(updateSizeBasedOnScreen)
UserInputService.WindowFocusReleased:Connect(updateSizeBasedOnScreen)

-- Show initial status
StatusText.Text = "Select a message to edit"
StatusDot.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- Orange for waiting
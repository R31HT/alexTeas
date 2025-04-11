-- Text Chat GUI Service
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local localPlayer = Players.LocalPlayer
local processedMessages = {}
local messageHistory = {}
local currentMessageId = ""

-- GUI Elements
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TextChatGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = localPlayer.PlayerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
mainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0.08, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Text Chat Controller"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold
title.Parent = titleBar

-- Message History Section
local historyLabel = Instance.new("TextLabel")
historyLabel.Name = "HistoryLabel"
historyLabel.Size = UDim2.new(1, 0, 0.08, 0)
historyLabel.Position = UDim2.new(0, 0, 0.08, 0)
historyLabel.BackgroundTransparency = 1
historyLabel.Text = "Message History"
historyLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
historyLabel.TextSize = 14
historyLabel.Font = Enum.Font.SourceSans
historyLabel.Parent = mainFrame

local dropdownFrame = Instance.new("Frame")
dropdownFrame.Name = "DropdownFrame"
dropdownFrame.Size = UDim2.new(0.9, 0, 0.1, 0)
dropdownFrame.Position = UDim2.new(0.05, 0, 0.16, 0)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
dropdownFrame.BorderSizePixel = 0
dropdownFrame.Parent = mainFrame

local dropdownButton = Instance.new("TextButton")
dropdownButton.Name = "DropdownButton"
dropdownButton.Size = UDim2.new(1, 0, 1, 0)
dropdownButton.BackgroundTransparency = 1
dropdownButton.Text = "Select a message"
dropdownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
dropdownButton.TextSize = 14
dropdownButton.Font = Enum.Font.SourceSans
dropdownButton.Parent = dropdownFrame

local dropdownList = Instance.new("ScrollingFrame")
dropdownList.Name = "DropdownList"
dropdownList.Size = UDim2.new(1, 0, 0, 0) -- Closed by default
dropdownList.Position = UDim2.new(0, 0, 1, 0)
dropdownList.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
dropdownList.BorderSizePixel = 0
dropdownList.ScrollBarThickness = 4
dropdownList.Visible = false
dropdownList.Parent = dropdownFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = dropdownList
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Text Input Section
local messageLabel = Instance.new("TextLabel")
messageLabel.Name = "MessageLabel"
messageLabel.Size = UDim2.new(1, 0, 0.08, 0)
messageLabel.Position = UDim2.new(0, 0, 0.3, 0)
messageLabel.BackgroundTransparency = 1
messageLabel.Text = "Custom Message"
messageLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
messageLabel.TextSize = 14
messageLabel.Font = Enum.Font.SourceSans
messageLabel.Parent = mainFrame

local messageInput = Instance.new("TextBox")
messageInput.Name = "MessageInput"
messageInput.Size = UDim2.new(0.9, 0, 0.15, 0)
messageInput.Position = UDim2.new(0.05, 0, 0.38, 0)
messageInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
messageInput.BorderSizePixel = 0
messageInput.TextColor3 = Color3.fromRGB(255, 255, 255)
messageInput.TextSize = 14
messageInput.Font = Enum.Font.SourceSans
messageInput.PlaceholderText = "Enter your custom message here..."
messageInput.Text = ""
messageInput.ClearTextOnFocus = false
messageInput.Parent = mainFrame

-- Channel Label
local channelLabel = Instance.new("TextLabel")
channelLabel.Name = "ChannelLabel"
channelLabel.Size = UDim2.new(1, 0, 0.08, 0)
channelLabel.Position = UDim2.new(0, 0, 0.55, 0)
channelLabel.BackgroundTransparency = 1
channelLabel.Text = "Using Channel: RBXGeneral"
channelLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
channelLabel.TextSize = 14
channelLabel.Font = Enum.Font.SourceSans
channelLabel.Parent = mainFrame

-- Status Display
local statusDisplay = Instance.new("TextLabel")
statusDisplay.Name = "StatusDisplay"
statusDisplay.Size = UDim2.new(0.9, 0, 0.1, 0)
statusDisplay.Position = UDim2.new(0.05, 0, 0.65, 0)
statusDisplay.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
statusDisplay.BorderSizePixel = 0
statusDisplay.TextColor3 = Color3.fromRGB(180, 180, 180)
statusDisplay.TextSize = 12
statusDisplay.Font = Enum.Font.SourceSans
statusDisplay.Text = "Ready"
statusDisplay.Parent = mainFrame

-- Send Button
local sendButton = Instance.new("TextButton")
sendButton.Name = "SendButton"
sendButton.Size = UDim2.new(0.9, 0, 0.1, 0)
sendButton.Position = UDim2.new(0.05, 0, 0.8, 0)
sendButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
sendButton.BorderSizePixel = 0
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.TextSize = 16
sendButton.Font = Enum.Font.SourceSansBold
sendButton.Text = "Send Message"
sendButton.Parent = mainFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -25, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "X"
closeButton.Parent = titleBar

-- Drag Functionality
local dragging = false
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end
end)

-- Update dropdown list with message history
function updateDropdownList()
    -- Clear existing items
    for _, child in ipairs(dropdownList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Add new items from message history
    for i, message in ipairs(messageHistory) do
        local item = Instance.new("TextButton")
        item.Name = "Item_" .. i
        item.Size = UDim2.new(1, 0, 0, 30)
        item.BackgroundTransparency = 0.2
        item.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        item.BorderSizePixel = 0
        item.Text = message.text:sub(1, 30) .. (message.text:len() > 30 and "..." or "")
        item.TextColor3 = Color3.fromRGB(230, 230, 230)
        item.TextSize = 14
        item.Font = Enum.Font.SourceSans
        item.Parent = dropdownList
        
        item.MouseButton1Click:Connect(function()
            dropdownButton.Text = item.Text
            messageInput.Text = message.text
            currentMessageId = message.id
            dropdownList.Visible = false
            dropdownList.Size = UDim2.new(1, 0, 0, 0)
        end)
    end
    
    -- Update scrolling frame content size
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, #messageHistory * 30)
end

-- Dropdown toggle
dropdownButton.MouseButton1Click:Connect(function()
    if dropdownList.Visible then
        dropdownList.Visible = false
        dropdownList.Size = UDim2.new(1, 0, 0, 0)
    else
        dropdownList.Visible = true
        dropdownList.Size = UDim2.new(1, 0, 0, math.min(#messageHistory * 30, 120))
    end
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Send button functionality
sendButton.MouseButton1Click:Connect(function()
    local fakeText = messageInput.Text
    
    if fakeText == "" then
        statusDisplay.Text = "Error: Please enter a message"
        statusDisplay.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    if currentMessageId == "" then
        statusDisplay.Text = "Error: No message ID selected"
        statusDisplay.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    statusDisplay.Text = "Sending message..."
    statusDisplay.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    pcall(function()
        replicatesignal(TextChatService.ClientToServerMessageReplicateSignalV2,
            fakeText,
            "b",
            currentMessageId, 
            TextChatService.TextChannels.RBXGeneral[localPlayer.Name],  
            TextChatService.TextChannels.RBXGeneral
        )
        statusDisplay.Text = "Message sent successfully!"
    end)
end)

-- Connect to TextChatService for incoming messages
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
        
        -- Update UI with the latest message
        if #messageHistory > 0 then
            dropdownButton.Text = messageHistory[1].text:sub(1, 30) .. (messageHistory[1].text:len() > 30 and "..." or "")
            statusDisplay.Text = "New message captured: " .. messageHistory[1].id
            statusDisplay.TextColor3 = Color3.fromRGB(100, 255, 100)
        end
    end
end

-- Initialize
updateDropdownList()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ClientRemotes = Remotes:WaitForChild("Client")
local SkewerHit = ClientRemotes:WaitForChild("SkewerHit")
local SpawnLocation = workspace:WaitForChild("SpawnStructure"):WaitForChild("SpawnLocation")
local DashPads = workspace:WaitForChild("DashPads")

local SPAWN_SAFE_RADIUS = 50
local DASHPAD_DETECTION_RADIUS = 5
local DASHPAD_IMMUNITY_TIME = 5

local targetedPlayers = {}
local dashPadImmunePlayers = {}
local currentTarget = nil
local isAttacking = false

local function setupPlayerTracking(player)
    player.CharacterAdded:Connect(function()
        print("Player " .. player.Name .. " respawned - resetting targeting")
        targetedPlayers[player.UserId] = nil
        dashPadImmunePlayers[player.UserId] = nil
        
        if currentTarget and currentTarget.UserId == player.UserId then
            currentTarget = nil
            isAttacking = false
        end
    end)
    
    if player == LocalPlayer and not player:FindFirstChild("leaderstats") then
        player.ChildAdded:Connect(function(child)
            if child.Name == "leaderstats" then
                if child:FindFirstChild("Credits") then
                    child.Credits.Changed:Connect(function()
                        if isAttacking and currentTarget then
                            targetedPlayers[currentTarget.UserId] = true
                            isAttacking = false
                            currentTarget = nil
                        end
                    end)
                end
            end
        end)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    setupPlayerTracking(player)
end

Players.PlayerAdded:Connect(setupPlayerTracking)

local function isNearSpawn(player)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return true
    end
    
    return (character.HumanoidRootPart.Position - SpawnLocation.Position).Magnitude < SPAWN_SAFE_RADIUS
end

local function isOnDashPad(player)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then 
        return false
    end
    
    local rootPosition = character.HumanoidRootPart.Position
    
    for _, dashPad in ipairs(DashPads:GetChildren()) do
        local base = dashPad:FindFirstChild("Base")
        if base and (rootPosition - base.Position).Magnitude < DASHPAD_DETECTION_RADIUS then
            return true
        end
    end
    
    return false
end

local function attackTarget(target)
    local args = {
        [1] = target
    }
    SkewerHit:FireServer(unpack(args))
end

local function teleportAndAttack(target)
    if isAttacking then return end
    isAttacking = true
    
    local localCharacter = LocalPlayer.Character
    local targetCharacter = target.Character
    
    if not localCharacter or not targetCharacter then 
        isAttacking = false
        return 
    end
    
    if not localCharacter:FindFirstChild("HumanoidRootPart") or not targetCharacter:FindFirstChild("HumanoidRootPart") then 
        isAttacking = false
        return 
    end
    
    local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
    if not targetHumanoid then
        isAttacking = false
        return
    end
    
    currentTarget = target
    
    local healthBefore = targetHumanoid.Health
    
    local targetUserId = target.UserId
    
    local healthConnection
    healthConnection = targetHumanoid.HealthChanged:Connect(function(newHealth)
        if newHealth < healthBefore then
            targetedPlayers[targetUserId] = true
            currentTarget = nil
            isAttacking = false
            
            healthConnection:Disconnect()
            
            print("Successfully hit player! Health decreased from " .. healthBefore .. " to " .. newHealth)
        end
    end)
    
    localCharacter.HumanoidRootPart.CFrame = targetCharacter.HumanoidRootPart.CFrame
    
    attackTarget(target)
    
    local checkCount = 0
    local maxChecks = 5
    
    local timeoutConnection
    timeoutConnection = RunService.Heartbeat:Connect(function()
        checkCount = checkCount + 1
        
        if checkCount >= 10 then
            if healthConnection.Connected then
                healthConnection:Disconnect()
            end
            
            currentTarget = nil
            isAttacking = false
            timeoutConnection:Disconnect()
            
            print("Failed to hit player within timeout period.")
        end
    end)
end

RunService.Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local userId = player.UserId
            
            if isOnDashPad(player) and not dashPadImmunePlayers[userId] then
                dashPadImmunePlayers[userId] = true
                
                spawn(function()
                    local startTime = tick()
                    repeat
                        RunService.Heartbeat:Wait()
                    until tick() - startTime >= DASHPAD_IMMUNITY_TIME
                    dashPadImmunePlayers[userId] = nil
                end)
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local allTargeted = true
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not targetedPlayers[player.UserId] then
            allTargeted = false
            break
        end
    end
    
    if allTargeted then
        targetedPlayers = {}
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and 
           player.Character and 
           not targetedPlayers[player.UserId] and 
           not isNearSpawn(player) and 
           not dashPadImmunePlayers[player.UserId] and
           currentTarget == nil and
           not isAttacking then
            
            teleportAndAttack(player)
            break
        end
    end
end)
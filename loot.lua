local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local humanoid = player.Character:WaitForChild("Humanoid")

for _, tool in ipairs(game:GetDescendants()) do
	if tool:IsA("Tool") and tool.Parent ~= backpack then
		local owned = false
		for _, plr in ipairs(game.Players:GetPlayers()) do
			if (plr.Character and tool:IsDescendantOf(plr.Character)) or (plr:FindFirstChild("Backpack") and tool:IsDescendantOf(plr.Backpack)) then
				owned = true
				break
			end
		end
		if not owned then
			replicatesignal(humanoid.ServerEquipTool, tool)
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end
	end
end
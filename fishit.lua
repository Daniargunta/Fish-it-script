--========================
-- FISH IT AUTO FISH LUA
--========================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- === SETTING ===
getgenv().AutoFish = true
getgenv().Delay = 2

-- === REMOTE (SESUIKAN JIKA BERBEDA) ===
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CastRemote = Remotes:WaitForChild("Cast")
local ReelRemote = Remotes:WaitForChild("Reel")

-- === GET ROD ===
local function GetRod()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:FindFirstChild("FishingRod")
end

-- === AUTO CAST ===
task.spawn(function()
    while task.wait(getgenv().Delay) do
        if getgenv().AutoFish then
            local rod = GetRod()
            if rod then
                pcall(function()
                    CastRemote:FireServer()
                end)
            end
        end
    end
end)

-- === AUTO REEL ===
ReelRemote.OnClientEvent:Connect(function(state)
    if getgenv().AutoFish and state == "Bite" then
        pcall(function()
            ReelRemote:FireServer()
        end)
    end
end)

print("✅ Fish It Auto Fish Loaded")
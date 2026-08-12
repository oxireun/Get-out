local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/oxireun/User/refs/heads/main/Oxireunuilibrary.lua"))()

local Window = Library:NewWindow("Grab land")
local MainSection = Window:NewSection("Main")


local isCollecting = false
local isPizzaActive = false
local isTikTokActive = false

local TARGET_ID = "rbxassetid://111496867637076"


MainSection:CreateToggle("Collect coins", false, function(value)
    isCollecting = value
end)


MainSection:CreateButton("Teleport to Pizza game", function()
    local char = game.Players.LocalPlayer.Character
    if char then char:PivotTo(CFrame.new(Vector3.new(-92.59, 20.69, 3.94))) end
end)
MainSection:CreateToggle("auto pizza game", false, function(value)
    isPizzaActive = value
end)


MainSection:CreateButton("Teleport to beach game", function()
    local char = game.Players.LocalPlayer.Character
    if char then char:PivotTo(CFrame.new(Vector3.new(160.73, 25.47, 242.63))) end
end)
MainSection:CreateToggle("auto play beach game", false, function(value)
    isTikTokActive = value
end)


task.spawn(function()
    while true do
        if isCollecting then
            local player = game.Players.LocalPlayer
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local targets = {}
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("MeshPart") and obj.MeshId == TARGET_ID then
                        table.insert(targets, obj)
                    elseif obj:IsA("SpecialMesh") and obj.MeshId == TARGET_ID then
                        if obj.Parent and obj.Parent:IsA("BasePart") then
                            table.insert(targets, obj.Parent)
                        end
                    end
                end
                if #targets > 0 then
                    local chosen = targets[math.random(1, #targets)]
                    hrp.CFrame = chosen.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    local Event = game:GetService("ReplicatedStorage"):WaitForChild("GameRemoteEvents"):WaitForChild("GameCInputEvent")
    while true do
        if isPizzaActive then
            pcall(function() Event:FireServer("Bite") end)
        end
        task.wait()
    end
end)

task.spawn(function()
    local gameRemoteEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameRemoteEvents")
    while true do
        if isTikTokActive then
            pcall(function()
                gameRemoteEvents.GameBInputEvent:FireServer("Paddle", "R")
                gameRemoteEvents.GameBInputEvent:FireServer("Paddle", "L")
            end)
        end
        task.wait()
    end
end)

local CreditsSection = Window:NewSection("Credits")
CreditsSection:CreateButton("Copy YouTube", function()
    setclipboard("https://youtube.com/@oxireun0?si=MxEKGtHSNZm9gTdQ")
end)
CreditsSection:CreateButton("Copy Discord", function()
    setclipboard("https://discord.gg/6M7CBfT2PJ")
end)

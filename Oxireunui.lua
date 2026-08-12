pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Notification",
        Text = "if coin collect not working go coin places till coin spawned in map and make your graphics higher enjoy.",
        Duration = 6
    })
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/oxireun/User/refs/heads/main/Oxireunuilibrary.lua"))()

local Window = Library:NewWindow("Grab land")
local MainSection = Window:NewSection("Main")

local isCollecting = false
local isCollecting2 = false
local isPizzaActive = false
local isTikTokActive = false

local TARGET_ID = "rbxassetid://111496867637076"

MainSection:CreateToggle("Collect coins", false, function(value)
    isCollecting = value
end)

MainSection:CreateToggle("Collect coin 2", false, function(value)
    isCollecting2 = value
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
            pcall(function()
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
            end)
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    while true do
        if isCollecting2 then
            pcall(function()
                local player = game.Players.LocalPlayer
                local char = player and player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local container = workspace:FindFirstChild("CoinContainer")
                
                if hrp and container then
                    local coins = container:GetChildren()
                    local validCoins = {}

                    for _, coin in ipairs(coins) do
                        if coin:IsA("BasePart") then
                            table.insert(validCoins, coin)
                        elseif coin:IsA("Model") then
                            local part = coin.PrimaryPart or coin:FindFirstChildWhichIsA("BasePart")
                            if part then
                                table.insert(validCoins, part)
                            end
                        end
                    end

                    if #validCoins > 0 then
                        local chosenCoin = validCoins[math.random(1, #validCoins)]
                        hrp.CFrame = chosenCoin.CFrame + Vector3.new(0, 3, 0)
                    end
                end
            end)
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local remoteEvents = replicatedStorage:WaitForChild("GameRemoteEvents", 5)
    local event = remoteEvents and remoteEvents:WaitForChild("GameCInputEvent", 5)
    
    while true do
        if isPizzaActive and event then
            pcall(function() 
                event:FireServer("Bite") 
            end)
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local gameRemoteEvents = replicatedStorage:WaitForChild("GameRemoteEvents", 5)
    
    while true do
        if isTikTokActive and gameRemoteEvents then
            pcall(function()
                local bEvent = gameRemoteEvents:FindFirstChild("GameBInputEvent")
                if bEvent then
                    bEvent:FireServer("Paddle", "R")
                    bEvent:FireServer("Paddle", "L")
                end
            end)
        end
        task.wait(0.1)
    end
end)

local CreditsSection = Window:NewSection("Credits")

CreditsSection:CreateButton("Copy YouTube", function()
    if setclipboard then
        setclipboard("https://youtube.com/@oxireun0?si=MxEKGtHSNZm9gTdQ")
    elseif toclipboard then
        toclipboard("https://youtube.com/@oxireun0?si=MxEKGtHSNZm9gTdQ")
    end
end)

CreditsSection:CreateButton("Copy Discord", function()
    if setclipboard then
        setclipboard("https://discord.gg/6M7CBfT2PJ")
    elseif toclipboard then
        toclipboard("https://discord.gg/6M7CBfT2PJ")
    end
end)

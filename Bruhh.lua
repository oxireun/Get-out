local ScreenGui
local Frame
local TitleBar
local CloseButton
local MinimizeButton
local InputBox
local JumpButton
local JumpCountLabel
local jumping = false
local jumpConnection
local jumpCount = 0

local function createUI()
    -- GUI elemanlarını oluştur
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 250, 0, 200) -- Daha kısa pencere
    Frame.Position = UDim2.new(0.5, -125, 0.5, -100)
    Frame.BackgroundColor3 = Color3.new(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Active = true
    Frame.Draggable = true
    Frame.Parent = ScreenGui

    TitleBar = Instance.new("TextLabel")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundTransparency = 1
    TitleBar.Text = "Oxireun"
    TitleBar.TextColor3 = Color3.new(1, 1, 1)
    TitleBar.Font = Enum.Font.SourceSansBold
    TitleBar.TextSize = 20
    TitleBar.Parent = Frame

    CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Position = UDim2.new(1, -30, 0, 3)
    CloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextSize = 18
    CloseButton.Parent = Frame

    MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.TextSize = 20
    MinimizeButton.Parent = Frame

    -- UI öğelerini tanımla
    InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(0.8, 0, 0, 30)
    InputBox.Position = UDim2.new(0.1, 0, 0.2, 0)
    InputBox.BackgroundColor3 = Color3.new(1, 1, 1)
    InputBox.TextColor3 = Color3.new(0, 0, 0)
    InputBox.Font = Enum.Font.SourceSans
    InputBox.TextSize = 18
    InputBox.PlaceholderText = "Enter jump interval (seconds)"
    InputBox.Parent = Frame

    JumpButton = Instance.new("TextButton")
    JumpButton.Size = UDim2.new(0.8, 0, 0, 30)
    JumpButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    JumpButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    JumpButton.Text = "Start Jumping"
    JumpButton.TextColor3 = Color3.new(1, 1, 1)
    JumpButton.Font = Enum.Font.SourceSansBold
    JumpButton.TextSize = 18
    JumpButton.Parent = Frame

    JumpCountLabel = Instance.new("TextLabel")
    JumpCountLabel.Size = UDim2.new(0.8, 0, 0, 30)
    JumpCountLabel.Position = UDim2.new(0.1, 0, 0.7, 0)
    JumpCountLabel.BackgroundTransparency = 1
    JumpCountLabel.Text = "Jumps: 0"
    JumpCountLabel.TextColor3 = Color3.new(1, 1, 1)
    JumpCountLabel.Font = Enum.Font.SourceSansBold
    JumpCountLabel.TextSize = 18
    JumpCountLabel.Parent = Frame

    -- Jumping Logic
    local function makeCharacterJump()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end

    JumpButton.MouseButton1Click:Connect(function()
        if jumping then
            jumping = false
            JumpButton.Text = "Start Jumping"
        else
            local interval = tonumber(InputBox.Text)
            if interval and interval > 0 then
                jumping = true
                jumpCount = 0 -- Sayaç sıfırlanır
                JumpButton.Text = "Stop Jumping"
                -- Zıplama işlemi başlatılır
                while jumping do
                    makeCharacterJump()
                    jumpCount = jumpCount + 1 -- Zıplama sayısını artır
                    JumpCountLabel.Text = "Jumps: " .. jumpCount -- Zıplama sayısını etiketle göster
                    wait(interval) -- Her saniye bir kere zıpla
                end
            else
                InputBox.Text = ""
                InputBox.PlaceholderText = "Invalid input. Enter a number > 0."
            end
        end
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        if minimized then
            Frame.Size = UDim2.new(0, 250, 0, 200) -- Pencereyi eski boyutuna döndür
            MinimizeButton.Text = "-"
            -- UI öğelerini tekrar göster
            InputBox.Visible = true
            JumpButton.Visible = true
            JumpCountLabel.Visible = true
        else
            Frame.Size = UDim2.new(0, 250, 0, 30) -- Pencereyi küçült
            MinimizeButton.Text = "+"
            -- UI öğelerini gizle
            InputBox.Visible = false
            JumpButton.Visible = false
            JumpCountLabel.Visible = false
        end
        minimized = not minimized
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end

-- Karakter resetlendiğinde GUI'yi yeniden oluştur
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if ScreenGui then
        ScreenGui:Destroy() -- Önceden var olan GUI'yi temizle
    end
    createUI() -- Yeni GUI oluştur
end)

-- İlk GUI oluşturulması
createUI()

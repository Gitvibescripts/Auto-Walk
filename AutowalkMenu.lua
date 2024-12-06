local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local MenuToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local ButtonCorner = Instance.new("UICorner")
local MenuButtonCorner = Instance.new("UICorner")
local dragging, dragInput, dragStart, startPos, menuDragging, menuDragInput, menuDragStart, menuStartPos

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundTransparency = 0.1

UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = Frame

Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5, -100, 0, 10)
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Auto Walk BY king_baconROYALTY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

ToggleButton.Parent = Frame
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.Position = UDim2.new(0.5, -50, 0.5, -15)
ToggleButton.Size = UDim2.new(0, 100, 0, 30)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "Auto Walk Bot"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true

ButtonCorner.CornerRadius = UDim.new(0, 15)
ButtonCorner.Parent = ToggleButton

MenuToggleButton.Parent = ScreenGui
MenuToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MenuToggleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
MenuToggleButton.Size = UDim2.new(0, 120, 0, 40)
MenuToggleButton.Font = Enum.Font.GothamBold
MenuToggleButton.Text = "Toggle Menu"
MenuToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuToggleButton.TextScaled = true

MenuButtonCorner.CornerRadius = UDim.new(0, 15)
MenuButtonCorner.Parent = MenuToggleButton

local menuVisible = true
MenuToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    Frame.Visible = menuVisible
end)

ToggleButton.MouseButton1Click:Connect(function()
    local enabled = ToggleButton.BackgroundColor3 == Color3.fromRGB(255, 0, 0)
    ToggleButton.BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    if enabled then
        spawn(function()
            while ToggleButton.BackgroundColor3 == Color3.fromRGB(0, 255, 0) do
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("Humanoid") then
                    local humanoid = character.Humanoid
                    humanoid:MoveTo(character.PrimaryPart.Position + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)))
                    humanoid.MoveToFinished:Wait()
                    local hitPart = character.PrimaryPart.Touched:Connect(function(hit)
                        if hit and hit:IsA("BasePart") then
                            hit.BrickColor = BrickColor.new("Bright red")
                            wait(0.5)
                            hit.BrickColor = BrickColor.new("Institutional white")
                        end
                    end)
                    wait(0.2)
                    hitPart:Disconnect()
                end
            end
        end)
    end
end)

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MenuToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        menuDragging = true
        menuDragStart = input.Position
        menuStartPos = MenuToggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                menuDragging = false
            end
        end)
    end
end)

MenuToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        menuDragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == menuDragInput and menuDragging then
        local delta = input.Position - menuDragStart
        MenuToggleButton.Position = UDim2.new(menuStartPos.X.Scale, menuStartPos.X.Offset + delta.X, menuStartPos.Y.Scale, menuStartPos.Y.Offset + delta.Y)
    end
end)

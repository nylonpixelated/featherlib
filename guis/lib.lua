local Feather = {Categories = {}}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Colors = {
    Main = Color3.fromRGB(20, 20, 20),
    Accent = Color3.fromRGB(100, 100, 255),
    Element = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(200, 200, 200)
}

function Feather:CreateCategory(name)
    local Cat = {Modules = {}}
    local Screen = game.CoreGui:FindFirstChild("FeatherGUI") or Instance.new("ScreenGui", game.CoreGui)
    Screen.Name = "FeatherGUI"

    local Container = Instance.new("Frame", Screen)
    Container.Size = UDim2.new(0, 150, 0, 300)
    Container.BackgroundColor3 = Colors.Main
    Container.Position = UDim2.new(0, #Screen:GetChildren() * 160 + 20, 0, 50)
    
    local Title = Instance.new("TextLabel", Container)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = name
    Title.BackgroundColor3 = Colors.Accent
    Title.TextColor3 = Color3.new(1,1,1)
    
    -- Helper to add spacing
    local function GetNextPos()
        return UDim2.new(0, 0, 0, 30 + (#Container:GetChildren() - 2) * 35)
    end

    function Cat:AddModule(modName, callback)
        local Button = Instance.new("TextButton", Container)
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.Position = GetNextPos()
        Button.BackgroundColor3 = Colors.Element
        Button.Text = modName
        Button.TextColor3 = Colors.Text
        
        local active = false
        Button.MouseButton1Click:Connect(function()
            active = not active
            Button.BackgroundColor3 = active and Colors.Accent or Colors.Element
            callback(active)
        end)
    end

    function Cat:AddSlider(name, min, max, callback)
        local SliderBg = Instance.new("Frame", Container)
        SliderBg.Size = UDim2.new(0.9, 0, 0, 20)
        SliderBg.Position = GetNextPos()
        SliderBg.BackgroundColor3 = Colors.Element
        
        local Bar = Instance.new("Frame", SliderBg)
        Bar.Size = UDim2.new(0, 0, 1, 0)
        Bar.BackgroundColor3 = Colors.Accent

        SliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local conn
                conn = RunService.RenderStepped:Connect(function()
                    local mouse = UserInputService:GetMouseLocation()
                    local relX = math.clamp((mouse.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
                    Bar.Size = UDim2.new(relX, 0, 1, 0)
                    callback(math.floor(min + (max - min) * relX))
                end)
                UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then conn:Disconnect() end end)
            end
        end)
    end
    return Cat
end

return Feather

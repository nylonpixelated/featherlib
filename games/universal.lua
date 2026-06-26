return function(Feather)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer

    -- Category: Movement
    local Movement = Feather:CreateCategory("Movement")
    
    Movement:AddSlider("WalkSpeed", 16, 150, function(val)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = val
        end
    end)

    Movement:AddSlider("JumpPower", 50, 200, function(val)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = val
        end
    end)

    -- Category: Visuals
    local Visuals = Feather:CreateCategory("Visuals")

    Visuals:AddModule("Player ESP", function(state)
        local function highlightPlayer(player)
            if player == LocalPlayer then return end
            
            if state then
                if player.Character and not player.Character:FindFirstChild("FeatherESP") then
                    local h = Instance.new("Highlight", player.Character)
                    h.Name = "FeatherESP"
                    h.FillColor = Color3.fromRGB(100, 100, 255)
                    h.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            else
                if player.Character and player.Character:FindFirstChild("FeatherESP") then
                    player.Character.FeatherESP:Destroy()
                end
            end
        end

        -- Toggle logic
        for _, p in pairs(Players:GetPlayers()) do
            highlightPlayer(p)
            p.CharacterAdded:Connect(function() 
                task.wait(1) 
                highlightPlayer(p) 
            end)
        end
    end)

    Visuals:AddModule("Fullbright", function(state)
        local Lighting = game:GetService("Lighting")
        if state then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
        else
            Lighting.Ambient = Color3.fromRGB(0, 0, 0)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            Lighting.Brightness = 1
        end
    end)
end

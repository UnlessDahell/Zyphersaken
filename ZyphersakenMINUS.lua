if not game:IsLoaded() then
   game.Loaded:Wait() 
end

local success, Rayfield = pcall(function()
   return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
   warn("Failed to load Rayfield UI. Please check the URL or try again later.")
   return
end

local Window = Rayfield:CreateWindow({
   Name = "Zypher Hub [ MINUS ] (.gg/wDj3ve2K)",
   Icon = 82284779245358, 
   LoadingTitle = "Wait until GUI setup",
   LoadingSubtitle = "by Sir.Zypher and Skider",
   Theme = "nil",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, 
      FileName = "Zypher"
   },

   Discord = {
      Enabled = false, 
      Invite = "https://discord.gg/wDj3ve2K", 
      RememberJoins = true 
   },

   KeySystem = false, 
   KeySettings = {
      Title = "Zypher Hub",
      Subtitle = "Loader has no key!",
      Note = "Join Discord for news!!", 
      FileName = "ZTeam", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"ZTeam"} 
   }
})

local MainTab = Window:CreateTab("Main", 123798026223578)
local MainSection = MainTab:CreateSection("Main")

local Slider = MainTab:CreateSlider({
    Name = "Camera FOV (Broken)",
    Range = {80, 120}, 
    Increment = 1, 
    Suffix = "°",
    CurrentValue = math.clamp(game.Workspace.CurrentCamera.FieldOfView, 80, 120),
    Flag = "FOVSlider",
    Callback = function(Value)
        local clampedValue = math.clamp(Value, 80, 120) 
        game.Workspace.CurrentCamera.FieldOfView = clampedValue
    end
})

local CommunitySection = MainTab:CreateSection("Our Discord Community Server")

local Button = MainTab:CreateButton({
   Name = "Discord Link Click to Get Here!",
   Callback = function()
      setclipboard("https://discord.gg/wDj3ve2K")
   end,
})

local VisionTab = Window:CreateTab("Vision", 74752218492458)
local VisionSection = VisionTab:CreateSection("This Page About Vision/Highlight")

local function createOutlineESP(model, outlineColor, fillColor)
    if model and model:IsA("Model") and not model:FindFirstChildOfClass("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Parent = model
        highlight.Adornee = model
        highlight.FillTransparency = 0.75
        highlight.FillColor = fillColor
        highlight.OutlineColor = outlineColor
        highlight.OutlineTransparency = 0
    end
end

local function createOutlineForTool(tool)
    if tool and tool:IsA("Tool") and not tool:FindFirstChildOfClass("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.new(1, 1, 1) 
        highlight.OutlineColor = Color3.new(1, 1, 1) 
        highlight.FillTransparency = 0.75
        highlight.OutlineTransparency = 0
        highlight.Parent = tool
    end
end

local function removeESPFromGroup(group)
    if group then
        for _, obj in pairs(group:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("Tool") then
                for _, highlight in pairs(obj:GetChildren()) do
                    if highlight:IsA("Highlight") then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
end

local function removeAllESP()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") then
            obj:Destroy()
        end
    end
end

local generatorEnabled = false
local killersEnabled = false
local survivorsEnabled = false
local toolsEnabled = false

local function updateGeneratorESP()
    task.spawn(function()
        while generatorEnabled do
            local generatorsFolder = workspace:FindFirstChild("Map") and 
                                     workspace.Map:FindFirstChild("Ingame") and 
                                     workspace.Map.Ingame:FindFirstChild("Map")
            if generatorsFolder then
                for _, obj in pairs(generatorsFolder:GetChildren()) do
                    if obj:IsA("Model") and obj.Name == "Generator" then
                        createOutlineESP(obj, Color3.new(1, 1, 0), Color3.new(1, 1, 0.5))
                    end
                end
            end
            task.wait(0.2)
        end
        removeESPFromGroup(workspace.Map.Ingame.Map)
    end)
end

local function updateKillersESP()
    task.spawn(function()
        while killersEnabled do
            local killersGroup = game.Workspace.Players:FindFirstChild("Killers")
            if killersGroup then
                for _, obj in pairs(killersGroup:GetChildren()) do
                    local humanoid = obj:FindFirstChildOfClass("Humanoid")
                    if humanoid and obj:FindFirstChild("HumanoidRootPart") then
                        createOutlineESP(obj, Color3.new(1, 0, 0), Color3.new(1, 0.5, 0.5))
                    end
                end
            end
            task.wait(0.2)
        end
        removeESPFromGroup(game.Workspace.Players:FindFirstChild("Killers"))
    end)
end

local function updateSurvivorsESP()
    task.spawn(function()
        while survivorsEnabled do
            local survivorsGroup = game.Workspace.Players:FindFirstChild("Survivors")
            if survivorsGroup then
                for _, obj in pairs(survivorsGroup:GetChildren()) do
                    local humanoid = obj:FindFirstChildOfClass("Humanoid")
                    if humanoid and obj:FindFirstChild("HumanoidRootPart") then
                        createOutlineESP(obj, Color3.new(0, 1, 0), Color3.new(0.5, 1, 0.5))
                    end
                end
            end
            task.wait(0.2)
        end
        removeESPFromGroup(game.Workspace.Players:FindFirstChild("Survivors"))
    end)
end

local function updateToolsESP()
    task.spawn(function()
        while toolsEnabled do
            for _, tool in pairs(workspace:GetDescendants()) do
                if tool:IsA("Tool") then
                    createOutlineForTool(tool)
                end
            end
            task.wait(0.2)
        end
        removeAllESP()
    end)
end

VisionTab:CreateToggle({
    Name = "Generator ESP",
    CurrentValue = false,
    Flag = "GeneratorESP",
    Callback = function(state)
        generatorEnabled = state
        if state then
            updateGeneratorESP()
        else
            removeESPFromGroup(workspace.Map.Ingame.Map)
        end
    end
})

VisionTab:CreateToggle({
    Name = "Killers ESP",
    CurrentValue = false,
    Flag = "KillersESP",
    Callback = function(state)
        killersEnabled = state
        if state then
            updateKillersESP()
        else
            removeESPFromGroup(game.Workspace.Players:FindFirstChild("Killers"))
        end
    end
})

VisionTab:CreateToggle({
    Name = "Survivors ESP",
    CurrentValue = false,
    Flag = "SurvivorsESP",
    Callback = function(state)
        survivorsEnabled = state
        if state then
            updateSurvivorsESP()
        else
            removeESPFromGroup(game.Workspace.Players:FindFirstChild("Survivors"))
        end
    end
})

VisionTab:CreateToggle({
    Name = "Tools ESP",
    CurrentValue = false,
    Flag = "ToolsESP",
    Callback = function(state)
        toolsEnabled = state
        if state then
            updateToolsESP()
        else
            removeAllESP()
        end
    end
})

local AimTab = Window:CreateTab("Aim")

local aimEnabled = false
local UserInputService = game:GetService("UserInputService")

local function isUsingChance()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return false end
    
    local parentGroup = character.Parent
    return character:FindFirstChild("Chance") and parentGroup and parentGroup.Name == "Survivals"
end

local function getNearestKiller()
    local killersGroup = game.Workspace.Players:FindFirstChild("Killers")
    local nearestKiller = nil
    local shortestDistance = math.huge

    if killersGroup then
        for _, killer in pairs(killersGroup:GetChildren()) do
            if killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") then
                local distance = (killer.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestKiller = killer
                end
            end
        end
    end
    return nearestKiller
end

local function aimAtKiller()
    if not isUsingChance() then
        Rayfield:Notify({
            Title = "Oops!",
            Content = "Looks like you weren't using Chance. Please switch to Chance before enabling this option!",
            Duration = 3
        })
        aimEnabled = false
        return
    end

    local killer = getNearestKiller()
    if killer and killer:FindFirstChild("HumanoidRootPart") then
        local playerCharacter = game.Players.LocalPlayer.Character
        if playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart") then
            playerCharacter.HumanoidRootPart.CFrame = CFrame.new(playerCharacter.HumanoidRootPart.Position, killer.HumanoidRootPart.Position)
        end
    end
end

local function onShoot()
    if aimEnabled then
        aimAtKiller()
    end
end

-- รองรับมือถือ (ปุ่ม Shoot บนหน้าจอ)
local shootButton = Instance.new("TextButton")
shootButton.Size = UDim2.new(0, 100, 0, 50)
shootButton.Position = UDim2.new(0.85, 0, 0.8, 0)
shootButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
shootButton.Text = "Shoot"
shootButton.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

shootButton.MouseButton1Click:Connect(onShoot)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        onShoot()
    end
end)

AimTab:CreateToggle({
    Name = "Shoot Aim Lock",
    CurrentValue = false,
    Flag = "AimLock",
    Callback = function(state)
        aimEnabled = state
    end
})

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

local MainTab = Window:CreateTab("Main", 132272873219669)
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

local VisionTab = Window:CreateTab("Vision")
local Section = VisionTab:CreateSection("This Tab About Vision/Highlight")

local function createOutlineESP(model, outlineColor, fillColor)
    local highlight = Instance.new("Highlight")
    highlight.Parent = model
    highlight.Adornee = model
    highlight.FillTransparency = 0.75
    highlight.FillColor = fillColor
    highlight.OutlineColor = outlineColor
    highlight.OutlineTransparency = 0
end

local function removeESPFromGroup(group)
    if group then
        for _, obj in pairs(group:GetChildren()) do
            if obj:IsA("Model") then
                for _, highlight in pairs(obj:GetChildren()) do
                    if highlight:IsA("Highlight") then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
end

local generatorEnabled = false
local function toggleGeneratorESP(state)
    generatorEnabled = state
    if generatorEnabled then
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
    else
        removeESPFromGroup(workspace)
    end
end

local killersEnabled = false
local function toggleKillersESP(state)
    killersEnabled = state
    if killersEnabled then
        local killersGroup = game.Workspace.Players:FindFirstChild("Killers")
        if killersGroup then
            for _, obj in pairs(killersGroup:GetChildren()) do
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if humanoid and obj:FindFirstChild("HumanoidRootPart") then
                    createOutlineESP(obj, Color3.new(1, 0, 0), Color3.new(1, 0.5, 0.5))
                end
            end
        end
    else
        removeESPFromGroup(game.Workspace.Players:FindFirstChild("Killers"))
    end
end

local survivorsEnabled = false
local function toggleSurvivorsESP(state)
    survivorsEnabled = state
    if survivorsEnabled then
        local survivorsGroup = game.Workspace.Players:FindFirstChild("Survivors")
        if survivorsGroup then
            for _, obj in pairs(survivorsGroup:GetChildren()) do
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if humanoid and obj:FindFirstChild("HumanoidRootPart") then
                    createOutlineESP(obj, Color3.new(0, 1, 0), Color3.new(0.5, 1, 0.5)) 
                end
            end
        end
    else
        removeESPFromGroup(game.Workspace.Players:FindFirstChild("Survivors"))
    end
end

local GeneratorToggle = VisionTab:CreateToggle({
    Name = "Generator ESP",
    CurrentValue = false,
    Flag = "GeneratorESP",
    Callback = function(Value)
        toggleGeneratorESP(Value)
    end
})

local KillersToggle = VisionTab:CreateToggle({
    Name = "Killers ESP",
    CurrentValue = false,
    Flag = "KillersESP",
    Callback = function(Value)
        toggleKillersESP(Value)
    end
})

local SurvivorsToggle = VisionTab:CreateToggle({
    Name = "Survivors ESP",
    CurrentValue = false,
    Flag = "SurvivorsESP",
    Callback = function(Value)
        toggleSurvivorsESP(Value)
    end
})

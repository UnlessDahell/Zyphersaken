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

local VisionTab = Window:CreateTab("Vision", nil)
local Section = VisionTab:CreateSection("This Page About Vision/ESP")

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

local function removeAllESP()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") then
            obj:Destroy()
        end
    end
end

local generatorEnabled = false
local function toggleGeneratorESP()
    if generatorEnabled then
        removeESPFromGroup(workspace)
        generatorEnabled = false
    else
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
        generatorEnabled = true
    end
end

local killersEnabled = false
local function toggleKillersESP()
    if killersEnabled then
        removeESPFromGroup(game.Workspace.Players:FindFirstChild("Killers"))
        killersEnabled = false
    else
        local killersGroup = game.Workspace.Players:FindFirstChild("Killers")
        if killersGroup then
            for _, obj in pairs(killersGroup:GetChildren()) do
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if humanoid and obj:FindFirstChild("HumanoidRootPart") then
                    createOutlineESP(obj, Color3.new(1, 0, 0), Color3.new(1, 0.5, 0.5))
                end
            end
        end
        killersEnabled = true
    end
end

local survivorsEnabled = false
local function toggleSurvivorsESP()
    if survivorsEnabled then
        removeESPFromGroup(game.Workspace.Players:FindFirstChild("Survivors"))
        survivorsEnabled = false
    else
        local survivorsGroup = game.Workspace.Players:FindFirstChild("Survivors")
        if survivorsGroup then
            for _, obj in pairs(survivorsGroup:GetChildren()) do
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if humanoid and obj:FindFirstChild("HumanoidRootPart") then
                    createOutlineESP(obj, Color3.new(0, 1, 0), Color3.new(0.5, 1, 0.5))
                end
            end
        end
        survivorsEnabled = true
    end
end

VisionTab:CreateToggle1({
    Name = "Generator ESP",
    CurrentValue = false,
    Flag = "GeneratorESP",
    Callback = function()
        toggleGeneratorESP()
    end
})

VisionTab:CreateToggle2({
    Name = "Killers ESP",
    CurrentValue = false,
    Flag = "KillersESP",
    Callback = function()
        toggleKillersESP()
    end
})

VisionTab:CreateToggle3({
    Name = "Survivors ESP",
    CurrentValue = false,
    Flag = "SurvivorsESP",
    Callback = function()
        toggleSurvivorsESP()
    end
})

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

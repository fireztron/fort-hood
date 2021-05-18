--made by fireztron @ v3rm

--// ESP PARTS

local ScreenGui = Instance.new("ScreenGui",game:GetService('CoreGui'))
local ESPLocation = Instance.new("Folder",ScreenGui)
local targetPlayer = ""

local Targets = {
    "HumanoidRootPart",
    --[["LeftLowerArm",
    "LeftUpperArm",
    "LowerTorso",
    "RightLowerArm",
    "RightUpperArm",
    "RightUpperLeg",
    "LeftLowerLeg",
    "LeftUpperLeg",
    "RightLowerLeg",
    "UpperTorso"--]]
}


function espPart(part,player)
    local esp = Instance.new("BoxHandleAdornment",ESPLocation)
    esp.Adornee = part
    esp.AlwaysOnTop = true
    esp.ZIndex = 1
    esp.Transparency = 0.7
    esp.Size = part.Size / 1.1
	if part.Name == "LeftHand" or part.Name == "RightHand" then
		esp.Size = part.Size - Vector3.new(0,1,0)
	end
    esp.Color3 = player.TeamColor.Color
    if player.Name == targetPlayer then
        esp.Size = part.Size + Vector3.new(.1, .1, .1)
        esp.Color3 = Color3.fromRGB(255,255,0)
    end
    esp.MouseEnter:Connect(function()
        if player.Team ~= game:GetService('Players').LocalPlayer.Team then
            local currentFrame = esp
        end
    end)
   
    player.CharacterRemoving:Connect(function()
        esp:Destroy()
    end)
	if player.Team then
	player.Team.PlayerRemoved:Connect(function(RemovedPlayer)
            if RemovedPlayer ~= player and RemovedPlayer ~= game:GetService('Players').LocalPlayer then
                return
            else
                esp.Color3 = player.TeamColor.Color
            end
	    end)
	end
end
 
function espPlayer(player)
    if player.Character ~= nil then
        for _,part in pairs(player.Character:GetChildren())do
            if part:IsA("BasePart") and part.Name ~= "Head" and part.Name ~= "RightHand" and part.Name ~= "LeftHand" and part.Name ~= "LeftFoot" and part.Name ~= "RightFoot" then
                --print(part)
                espPart(part,player)
            end
        end
    end
end
 
function ESP()
    ESPLocation:ClearAllChildren()
    for _,player in pairs(game:GetService('Players'):GetPlayers())do
        if player ~= game:GetService('Players').LocalPlayer then
            espPlayer(player)
        end
    end
end

ESP()

local function WaitUntilCharacterLoaded(Char)
    for _,Part in pairs(Targets)do
        Char:WaitForChild(Part)
    end
end

game:GetService('Players').PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function(Char)
        WaitUntilCharacterLoaded(Char)
        espPlayer(Player)
    end)
end)

for _,Player in pairs(game:GetService('Players'):GetPlayers())do
    if Player ~= game:GetService('Players').LocalPlayer then
        Player.CharacterAdded:Connect(function(Char)
            WaitUntilCharacterLoaded(Char)
            espPlayer(Player)
        end)
    end
end

--// ESP NAMES

repeat wait() until game:IsLoaded()

local LocalPlayer = game:GetService("Players").LocalPlayer
local GameMt = getrawmetatable(game)
local OldIndex = GameMt.__index

setreadonly(GameMt, false)

GameMt.__index = newcclosure(function(Self, Key)
    if not checkcaller() and Key == "BillboardGui" then
        return nil
    end

    return OldIndex(Self, Key)
end)

setreadonly(GameMt, true)


local Players = game:GetService('Players')
local LP = Players.LocalPlayer



local function espPlayer(player)
    for i,v in pairs(getconnections(player.Character.Head.ChildAdded)) do
        v:Disable()
    end
	local billgui = Instance.new('BillboardGui', player.Character.Head)
	local textlab = Instance.new('TextLabel', billgui)

	billgui.Name = "ESP"
	billgui.AlwaysOnTop = true
	billgui.ExtentsOffset = Vector3.new(0, 3, 0)
	billgui.Size = UDim2.new(10, 0, 10, 0)

	textlab.Name = 'Player'
	textlab.BackgroundColor3 = Color3.new(255, 255, 255)
	textlab.BackgroundTransparency = 1    
	textlab.BorderSizePixel = 0
	textlab.Position = UDim2.new(0, 0, 0, 0)
	textlab.Size = UDim2.new(1, 0, 1, 0)
	textlab.Visible = true
	textlab.ZIndex = 10
	textlab.Font = 'SciFi'
	textlab.FontSize = 'Size14'
	textlab.Text = player.Name
	textlab.TextTransparency = 0
	textlab.TextStrokeTransparency = 1
	textlab.TextColor3 = Color3.fromRGB(0,255,127)
	
	player.Character:WaitForChild('Humanoid').DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
end

local function createHealthbar(player)
	--print("healthing " .. player.Name)
	local hrp = player.Character.HumanoidRootPart
	board =Instance.new("BillboardGui", hrp) --//Creates the BillboardGui with HumanoidRootPart as the Parent
	board.Name = "total"
	board.Size = UDim2.new(1,0,1,0)
	board.StudsOffset = Vector3.new(-1,1,0)
	board.AlwaysOnTop = true
	board.MaxDistance = 130

	bar = Instance.new("Frame",board) --//Creates the black background
	bar.BackgroundColor3 = Color3.new(255,255,255)
	bar.BorderSizePixel = 1
	bar.Size = UDim2.new(0.2,0,5,0)
	bar.Name = "total2"
	bar.ZIndex = 9
												
	health = Instance.new("Frame",bar) --//Creates the changing green Frame
	health.BackgroundColor3 = Color3.new(0,255,0)
	health.BorderSizePixel = 1
	health.ZIndex = 10
	health.Size = UDim2.new(1,0,hrp.Parent.Humanoid.Health/hrp.Parent.Humanoid.MaxHealth,0)
		hrp.Parent.Humanoid.Changed:Connect(function(property) --//Triggers when any Property changed
            if hrp and hrp.Parent and hrp.Parent.Humanoid then
                hrp.total.total2.Frame.Size = UDim2.new(1,0,hrp.Parent.Humanoid.Health/hrp.Parent.Humanoid.MaxHealth,0) --//Adjusts the size of the red Frame	
            end                  
		end)
end

for _,player in pairs(game:GetService('Players'):GetPlayers()) do
if player ~= Players.LocalPlayer then
		if player.Character then
			player.Character:WaitForChild('Head') 
			player.CharacterAdded:Connect(function(character)
					player.Character:WaitForChild('Head') 
					espPlayer(player)
					createHealthbar(player)
			end)
			espPlayer(player)
			createHealthbar(player)
		end
end
end

game:GetService('Players').PlayerAdded:Connect(function(player)
	if player then
		--print(player, "has joined!")
		local char = player.Character or player.CharacterAdded:Wait()
		if char then
			player.Character:WaitForChild('Head') 
			--print(char, "'s character has been found!")
			player.CharacterAdded:Connect(function(character)
					player.Character:WaitForChild('Head') 
					player.Character:WaitForChild('Humanoid')  
					espPlayer(player)
					createHealthbar(player)
			end)
			espPlayer(player)
			createHealthbar(player)
		end
	end
end)


LP.CameraMaxZoomDistance = 5000
LP.CameraMinZoomDistance = 0

Players.PlayerAdded:Connect(function(player)
	if player == Players.LocalPlayer then
		LP.CameraMaxZoomDistance = 5000
		LP.CameraMinZoomDistance = 0
	end
end)

-- CREDITS TO PersonMon FOR AIMBOT SCRIPT

local teamCheck = false
local fov = 150
local smoothing = 1

local RunService = game:GetService("RunService")

local FOVring = Drawing.new("Circle")
FOVring.Visible = true
FOVring.Thickness = 2
FOVring.Radius = fov
FOVring.Transparency = 1
FOVring.Color = Color3.fromRGB(255, 128, 128)
FOVring.Position = workspace.CurrentCamera.ViewportSize/2

local function teamCheck()
    return v.Team == game.Players.LocalPlayer.Team
    --return false
end

local function getClosest(cframe)
   local ray = Ray.new(cframe.Position, cframe.LookVector).Unit
   
   local target = nil
   local mag = math.huge
   
   for i,v in pairs(game.Players:GetPlayers()) do
       if v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") and v ~= game.Players.LocalPlayer and (v.Team ~= game.Players.LocalPlayer.Team or (not teamCheck)) then
           local magBuf = (v.Character.Head.Position - ray:ClosestPoint(v.Character.Head.Position)).Magnitude
           
           if magBuf < mag then
               mag = magBuf
               target = v
           end
       end
   end
   
   return target
end

loop = RunService.RenderStepped:Connect(function()
   local UserInputService = game:GetService("UserInputService")
   local pressed = UserInputService:IsKeyDown(Enum.KeyCode.E) or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
   local localPlay = game.Players.localPlayer.Character
   local cam = workspace.CurrentCamera
   local zz = workspace.CurrentCamera.ViewportSize/2
   
   if pressed then
       local Line = Drawing.new("Line")
       local curTar = getClosest(cam.CFrame)
       local ssHeadPoint = cam:WorldToScreenPoint(curTar.Character.Head.Position)
       ssHeadPoint = Vector2.new(ssHeadPoint.X, ssHeadPoint.Y)
       if (ssHeadPoint - zz).Magnitude < fov then
           workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(cam.CFrame.Position, curTar.Character.Head.Position), smoothing)
       end
   end
   
   if UserInputService:IsKeyDown(Enum.KeyCode.P) then
       loop:Disconnect()
       FOVring:Remove()
   end
end)

--// GUNZ

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local function setCustomGunMod(gun)
    local gunSettings = require(gun.ConfigMods.CConfig)
    gunSettings.BaseDamage = 1000
    gunSettings.LimbDamage = 1000
    gunSettings.ArmorDamage = 1000
    gunSettings.HeadDamage = 1000
    gunSettings.EShieldDamage = 1000
	
    gunSettings.SideKickMin = -3.5
    gunSettings.SideKickMax = 3.5
    gunSettings.AimSideKickMin = -2.5
    gunSettings.AimSideKickMax = 2.5
    gunSettings.gunRecoilMin = 0
    gunSettings.gunRecoilMax = 0
    gunSettings.AimKickbackMin = 3
    gunSettings.AimKickbackMax = 5
    gunSettings.KickbackMin = 0
    gunSettings.KickbackMax = 0
    gunSettings.CamShakeMin = 0
    gunSettings.CamShakeMax = 0
    gunSettings.AimCanShakeMin = 3
    gunSettings.AimCamShakeMax = 4
	
    gunSettings.TracerLifetime = 1000
    gunSettings.BulletSpeed = math.huge
    gunSettings.Ammo = math.huge
    gunSettings.AntiTK = false
    gunSettings.TracerEnabled = false
    gunSettings.Firerate = .001
    gunSettings.ExplosiveEnabled = true
    gunSettings.ExplosiveAmmo = math.huge
    print('yuh')
end


local function getGun()
    for i,v in pairs(workspace:GetDescendants()) do
        if 
            v:IsA("ClickDetector") 
            and v.Parent.Name ~= "ClickPart" --forgot what this is
            and v.Parent.Name ~= "clothingPart" --so u dont wear clothes
            and v.Parent.Name ~= "SurfaceUI" --forgot what this is
            and v.Parent.Name ~= " " --forgot what this is
            and v.Parent.Name ~= "Maintable" --stops from prompting gamepass
        then
            fireclickdetector(v)
        end
    end
end

local char = LP.Character or LP.CharacterAdded:Wait()
char:WaitForChild("HumanoidRootPart")
getGun()
setCustomGunMod(char:WaitForChild("Training M4A1"), math.huge)

LP.CharacterAdded:Connect(function(char)
    char:WaitForChild("HumanoidRootPart")
    getGun()
    setCustomGunMod(char:WaitForChild("Training M4A1"), math.huge)
end)

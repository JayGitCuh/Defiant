local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/JayGitCuh/Defiant/main/uilib.lua'))()
getgenv().library.title = "Defiant Framework | Arsenal"
getgenv().library.foldername = "defiant\\arsenal\\config"

local UIS = game:GetService("UserInputService")
local dwRunservice = game:GetService("RunService")
local dwLocalPlayer = game.Players.LocalPlayer
local dwMouse = dwLocalPlayer:GetMouse()
local dwWorkspace = game:GetService("Workspace")
local dwCamera = dwWorkspace.CurrentCamera
local dwWorldToView = dwCamera.worldToViewportPoint
local HttpService = game:GetService("HttpService")
local dwPlayers = game:GetService("Players")
local dwCurrentWeapon = dwLocalPlayer.PlayerGui.GUI.Client.Variables.gun.Value

local visualsTab = library:AddTab("Visuals");
local visualsColumn1 = visualsTab:AddColumn();
local espSection = visualsColumn1:AddSection("Players");

espSection:AddToggle{text = "Enabled", flag = "esp"}:AddColor({flag = "espcolor", color = Color3.new(1, 0, 0)});
espSection:AddToggle{text = "Snaplines", flag = "espsnaplines"};
espSection:AddToggle{text = "Box", flag = "espbox"};
espSection:AddToggle{text = "Name", flag = "espname"};
espSection:AddToggle{text = "Distance", flag = "espdistance"};
espSection:AddToggle{text = "Weapon", flag = "espweapon"};
espSection:AddToggle{text = "Skeleton", flag = "espskeleton"};
espSection:AddToggle{text = "Look-Angle", flag = "esplookangle"};
espSection:AddDivider("Indicators");
espSection:AddToggle{text = "Enabled", flag = "indicators"}:AddColor({flag = "indcolor", color = Color3.new(255, 0, 0)});
espSection:AddSlider{text = "Radius", flag = "indradius", min = 40, max = 400, value = 80, float = 0.001, suffix = "°"};
espSection:AddDivider("Settings");
espSection:AddToggle{text = "Show Team", flag = "espshowteam"}:AddColor({flag = "espteamcolor", color = Color3.new(0, 0, 255)});
espSection:AddToggle{text = "Highlight Target", flag = "esphighlighttarget"}:AddColor({flag = "esphighlightcolor", color = Color3.new(0, 255, 0)});
espSection:AddToggle{text = "Attach to mouse", flag = "espsnaplinesymouse"};
espSection:AddSlider{text = "Snapline Y Axis", flag = "espsnaplineyaxis", min = 0, max = 1000, value = 20, float = 0.001, suffix = "°"};
espSection:AddSlider{text = "Font Size", flag = "espinfosize", min = 0.1, max = 50, value = 20, float = 0.001, suffix = "°"};
espSection:AddSlider{text = "Max Distance", flag = "espmaxdistance", min = 10, max = 4000, value = 1500, float = 10, suffix = "°"};

local visualsColumn2 = visualsTab:AddColumn();
local skinchangerSection = visualsColumn2:AddSection("Skin Changer");

skinchangerSection:AddToggle{text = "Custom Skin", flag = "visskin"};
skinchangerSection:AddBox({text = "Skin ID", value = "6760332320", flag = "visskinID"});

local hitsounds = {
    ["Bell"] = "rbxassetid://6779227552",
    ["Taco Bell"] = "rbxassetid://5696182212",
    ["Ding"] = "rbxassetid://7128958209",
    ["Custom"] = getsynasset("DefiantCFG/Hitsounds/custom.wav")
}

local hitsoundlist = {}
for i,v in next, hitsounds do
	table.insert(hitsoundlist, i)
end

local hitsoundsec = visualsColumn2:AddSection("Hitsound");
hitsoundsec:AddToggle{text = "Sound", flag = "hitsound"}:AddList({flag = "hitsoundlist", value = hitsoundlist[1], values = hitsoundlist});

local bulletSec = visualsColumn2:AddSection("Bullet Tracers");
bulletSec:AddToggle{text = "Tracers", flag = "bullettracers"}:AddColor({flag = "tracercolor", color = Color3.new(1, 0, 0)});

local LegitTab = library:AddTab("Aimbot");
local LegitColunm1 = LegitTab:AddColumn();
local LegitAimbot = LegitColunm1:AddSection("Aimbot");

local playerbones = {
    "Head",
    "HeadHB",
    "HumanoidRootPart",
    "LeftHand",
    "LeftLowerArm",
    "LeftUpperArm",
    "RightHand",
    "LeftLowerArm",
    "LeftUpperArm",
    "UpperTorso",
    "LowerTorser",
    "LeftFoot",
    "LeftLowerLeg",
    "LeftUpperLeg",
    "RightFoot",
    "RightLowerLeg",
    "RightUpperLeg",
}

LegitAimbot:AddToggle{text = "Aimbot", flag = "mouseaimbot"};
LegitAimbot:AddList({text = "Target Part", flag = "aimbotbone", value = "HumanoidRootPart", values = playerbones});
LegitAimbot:AddToggle{text = "Hit Check", flag = "aimbotvisible"};
LegitAimbot:AddToggle{text = "Ignore Team", flag = "aimbotteamcheck"};
LegitAimbot:AddSlider{text = "Smoothing", flag = "aimbotfovsmoothing", min = 3, max = 30, value = 3, suffix = "%"};
LegitAimbot:AddDivider("FOV");
LegitAimbot:AddToggle{text = "Show FOV", flag = "showfovaimbot"}:AddColor({flag = "fovcolor", color = Color3.new(0, 0, 0)});
LegitAimbot:AddSlider{text = "FOV Size", flag = "aimbotfovsize", min = 0, max = 750, value = 105, float = 0.1, suffix = "°"}
LegitAimbot:AddSlider{text = "FOV Transparency", flag = "aimbotfovtrans", min = 0, max = 1.00, value = 0.4, float = 0.1, suffix = "°"}

local LegitColunm2 = LegitTab:AddColumn();
local LegitSilent = LegitColunm2:AddSection("Silent-Aim");
LegitSilent:AddToggle{text = "Silent Aim", flag = "silentaimbot"};
LegitSilent:AddSlider{text = "Hit Chance", flag = "silenthitchance", min = 0, max = 100, value = 100, suffix = "%"};
LegitSilent:AddToggle{text = "Autoshoot", flag = "autoshoot"};
LegitSilent:AddToggle{text = "Ignore FOV", flag = "ignorefovaimbot"};

local LegitTriggerbot = LegitColunm2:AddSection("Triggerbot");
LegitTriggerbot:AddToggle{text = "Enable", flag = "triggerbot"};
LegitTriggerbot:AddSlider{text = "Delay", flag = "tbdelay", min = 0, max = 300, value = 0, float = 0.1, suffix = "%"};

local miscTab = library:AddTab("Misc");
local miscColumn1 = miscTab:AddColumn();
local miscColumn2 = miscTab:AddColumn();

local miscMovement = miscColumn1:AddSection("Movement");
miscMovement:AddToggle{text = "Fly", flag = "flyer"};
miscMovement:AddSlider{text = "Fly Speed", flag = "flyspeed", min = 10.00, max = 500.00, value = 20.00, suffix = "%"};
miscMovement:AddDivider("BHOP");
miscMovement:AddToggle{text = "BHOP", flag = "bhopjump"};
miscMovement:AddSlider{text = "Speed", flag = "cframespeed", min = 10.00, max = 500.00, value = 20.00, suffix = "%"};
miscMovement:AddList({text = "Type", flag = "bhoptype", value = "Rage", values = {"Rage", "Legit"}});
miscMovement:AddDivider("Jump");
miscMovement:AddToggle{text = "Infinite Jump", flag = "infjump"};

local chatspamSection = miscColumn2:AddSection("Chat-Spam");
chatspamSection:AddToggle{text = "Advertise", flag = "chatadvertiser"};
chatspamSection:AddToggle{text = "Chat Spam", flag = "chatspammer"};
chatspamSection:AddBox({text = "Spam Text", value = "", flag = "spamtext"});

local miscSection = miscColumn1:AddSection("Misc");
miscSection:AddButton({text = "Rejoin", callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end}):AddBind({flag = "rejoinbind", key = "none"});
miscSection:AddSlider{text = "Field Of View", flag = "defaultfov", min = 60.00, max = 120.00, value = 70.00, suffix = "%"};

local gunmodsTab = library:AddTab("Exploits");
local gunColumn1 = gunmodsTab:AddColumn();
local gunColumn2 = gunmodsTab:AddColumn();

local gunModsS = gunColumn1:AddSection("Modification's");
gunModsS:AddToggle{text = "Unlimited Ammo", flag = "unlimitedammo"};
gunModsS:AddToggle{text = "No Spread", flag = "nospread"};

local gunModsS = gunColumn2:AddSection("Auto-Farm");
gunModsS:AddToggle{text = "Telekill", flag = "telekill"};

-- [Library Settings UI] -----------------------------------------------------------------------------------------------------------------------------------------------------
local SettingsTab = library:AddTab("Settings");
local SettingsColumn = SettingsTab:AddColumn();
local SettingsColumn2 = SettingsTab:AddColumn();
local SettingSection = SettingsColumn:AddSection("Menu"); 
local ConfigSection = SettingsColumn2:AddSection("Configs");
local Warning = library:AddWarning({type = "confirm"});

local mouseicon = Drawing.new('Circle');
mouseicon.Visible = true;
mouseicon.Radius = 3;
mouseicon.Thickness = 3
mouseicon.Color = Color3.fromRGB(0, 0, 0);
mouseicon.Filled = false;
mouseicon.NumSides = 48;
mouseicon.Position = Vector2.new(dwMouse.X, dwMouse.Y + 36);
mouseicon.Transparency = 1;

function ToggleMouse()
    if toggle == false then
        toggle = true
        mouseicon.Visible = true
    else
        toggle = false
        mouseicon.Visible = false
    end
end

SettingSection:AddBind({text = "Open / Close", flag = "UI Toggle", nomouse = true, key = Enum.KeyCode.RightControl, callback = function()
    library:Close();
    ToggleMouse();
end});

SettingSection:AddColor({text = "Accent Color", flag = "Menu Accent Color", color = Color3.new(1, 0, 0), callback = function(color)
    if library.currentTab then
        library.currentTab.button.TextColor3 = color;
    end
    mouseicon.Color = color
    for i,v in pairs(library.theme) do
        v[(v.ClassName == "TextLabel" and "TextColor3") or (v.ClassName == "ImageLabel" and "ImageColor3") or "BackgroundColor3"] = color;
    end
end});

-- [Background List]
local backgroundlist = {
    Floral = "rbxassetid://5553946656",
    Flowers = "rbxassetid://6071575925",
    Circles = "rbxassetid://6071579801",
    Hearts = "rbxassetid://6073763717"
};

-- [Background List]
local back = SettingSection:AddList({text = "Background", max = 4, flag = "background", values = {"Floral", "Flowers", "Circles", "Hearts"}, value = "Floral", callback = function(v)
    if library.main then
        library.main.Image = backgroundlist[v];
    end
end});

-- [Background Color Picker]
back:AddColor({flag = "backgroundcolor", color = Color3.new(), callback = function(color)
    if library.main then
        library.main.ImageColor3 = color;
    end
end, trans = 1, calltrans = function(trans)
    if library.main then
        library.main.ImageTransparency = 1 - trans;
    end
end});

-- [Tile Size Slider]
SettingSection:AddSlider({text = "Tile Size", min = 50, max = 500, value = 50, callback = function(size)
    if library.main then
        library.main.TileSize = UDim2.new(0, size, 0, size);
    end
end});

-- [Discord Button]
SettingSection:AddButton({text = "Discord", callback = function()

end});

-- [Config Box]
ConfigSection:AddBox({text = "Config Name", skipflag = true});

-- [Config List]
ConfigSection:AddList({text = "Configs", skipflag = true, value = "", flag = "Config List", values = library:GetConfigs()});

-- [Create Button]
ConfigSection:AddButton({text = "Create", callback = function()
    library:GetConfigs();
    writefile(library.foldername .. "/" .. library.flags["Config Name"] .. library.fileext, "{}");
    library.options["Config List"]:AddValue(library.flags["Config Name"]);
end});

function GetConfigs()
    if not isfolder(self.foldername) then
        makefolder(self.foldername)
        return {}
    end
    local files = {}
    local a = 0
    for i,v in next, listfiles(self.foldername.."\\skybox") do
        if v:sub(#v - #self.fileext + 1, #v) == self.fileext then
            a = a + 1
            v = v:gsub(self.foldername .. "\\skybox\\", "")
            v = v:gsub(self.fileext, "")
            table.insert(files, a, v)
        end
    end
    return files
end

-- [Save Button]
ConfigSection:AddButton({text = "Save", callback = function()
    local r, g, b = library.round(library.flags["Menu Accent Color"]);
    Warning.text = "Are you sure you want to save the current settings to config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
    if Warning:Show() then
        library:SaveConfig(library.flags["Config List"]);
    end
end});

-- [Load Button]
ConfigSection:AddButton({text = "Load", callback = function()
    local r, g, b = library.round(library.flags["Menu Accent Color"]);
    Warning.text = "Are you sure you want to load config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
    if Warning:Show() then
        library:LoadConfig(library.flags["Config List"]);
    end
end});

-- [Delete Button]
ConfigSection:AddButton({text = "Delete", callback = function()
    local r, g, b = library.round(library.flags["Menu Accent Color"]);
    Warning.text = "Are you sure you want to delete config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
    if Warning:Show() then
        local config = library.flags["Config List"];
        if table.find(library:GetConfigs(), config) and isfile(library.foldername .. "/" .. config .. library.fileext) then
            library.options["Config List"]:RemoveValue(config);
            delfile(library.foldername .. "/" .. config .. library.fileext);
        end
    end
end});

-- [Init] --------------------------------------------------------------------------------------------------------------------------------------------------------------------
library:Init();
library:selectTab(library.tabs[1]);

UIS.JumpRequest:Connect(function(Jump)
    if library.flags["infjump"] then
        dwLocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

local fovcircle = Drawing.new('Circle');

function aimteamcheck(player)
    if library.flags["aimbotteamcheck"] then
        if game.Players.LocalPlayer.TeamColor == player.TeamColor then return false
        else return true end
    else
        return true
    end
end

function esphitcheck(target, ignore)
    ESPOrigin = dwCamera.CFrame.p
    ESPCheckRay = Ray.new(ESPOrigin, target- ESPOrigin)
    ESPHit = workspace:FindPartOnRayWithIgnoreList(ESPCheckRay, ignore)
    return ESPHit == nil
end

function visibilitycheck(target, ignore)
    if library.flags["aimbotvisible"] then
        Origin = dwCamera.CFrame.p
        CheckRay = Ray.new(Origin, target- Origin)
        Hit = workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
        return Hit == nil
    else
        return true
    end
end

function GetClosestPlayer(fov)
    local Target, Closest = nil, fov or math.huge
    for i,v in pairs(dwPlayers:GetPlayers()) do
        if v.Character:WaitForChild(library.flags["aimbotbone"]) and (visibilitycheck(v.Character:WaitForChild(library.flags["aimbotbone"]).Position or v.Character:WaitForChild(library.flags["aimbotbone"]).Position ,{dwLocalPlayer.Character, v.Character, game:GetService("Workspace"):WaitForChild("Map"):WaitForChild("Ignore"), game:GetService("Workspace")["Ray_Ignore"]}) and v ~= dwLocalPlayer and aimteamcheck(v) and v.Character) then -- and v.Character["HumanoidRootPart"]
            local Position, OnScreen = dwCamera:WorldToScreenPoint(v.Character:WaitForChild(library.flags["aimbotbone"]).Position)

            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(dwMouse.X, dwMouse.Y)).Magnitude
            if (Distance < Closest) then
                Closest = Distance
                Target = v
            end
        end
    end
    return Target, Closest
end

local menuadvertisement = {
    "Defiant Framework > ALLLL",
    "TAPPING WITH Defiant FRAMEWORK!!!!",
    "Not using Defiant Framework??????",
    "DEFIANT!!!!!!",
}

function teleportTo(part)
    dwLocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame * CFrame.new(0,0,3)
end

function teamcheck(targetplayer)
    if game.Players.LocalPlayer.Team == targetplayer.Team then return false
    else return true end
end

function shootWeapon()
    dwLocalPlayer.PlayerGui.GUI.Client.Variables.Held.Value = true
    wait(0.1)
    dwLocalPlayer.PlayerGui.GUI.Client.Variables.Held.Value = false
end

function Beam(v1, v2)
    local Part = Instance.new("Part", workspace)
    Part.Size = Vector3.new(1, 1, 1)
    Part.Transparency = 1
    Part.CanCollide = false
    Part.CFrame = CFrame.new(v1)
    Part.Anchored = true
    local AttachmentP1 = Instance.new("Attachment")
    AttachmentP1.Parent = Part

    local Part2 = Instance.new("Part")
    Part2.Parent = game.Workspace
    Part2.Size = Vector3.new(1, 1, 1)
    Part2.Transparency = 1
    Part2.CanCollide = false
    Part2.CFrame = CFrame.new(v2)
    Part2.Anchored = true
    Part2.Color = Color3.fromRGB(255,0,0)

    local AttachmentP2 = Instance.new("Attachment")
    AttachmentP2.Parent = Part2
    local Beam = Instance.new("Beam")
    Beam.Parent = Part2
    Beam.FaceCamera = true
    Beam.Color = ColorSequence.new(
        library.flags["tracercolor"]
    )
    Beam.Attachment0 = AttachmentP1
    Beam.Attachment1 = AttachmentP2
    Beam.LightEmission = 6
    Beam.LightInfluence = 1
    Beam.Width0 = 0.01
    Beam.Width1 = 0.05

    delay(1, function()
        for i = 0.5, 1, 0.02 do
            wait()
            Beam.Transparency = NumberSequence.new(i)
        end
        Part:Destroy()
        Part2:Destroy()
    end)
end

local target = nil
local velocity = Vector3.new(0, 1, 0)

local closest
game:GetService("RunService").RenderStepped:Connect(function(frame)
    fovcircle.Visible = library.flags["showfovaimbot"];
    fovcircle.Radius = library.flags["aimbotfovsize"];
    fovcircle.Thickness = 0;
    fovcircle.Color = library.flags["fovcolor"];
    fovcircle.Filled = true;
    fovcircle.NumSides = 36;
    fovcircle.Position = Vector2.new(dwMouse.X, dwMouse.Y + 36);
    fovcircle.Transparency = library.flags["aimbotfovtrans"];

    mouseicon.Position = Vector2.new(dwMouse.X, dwMouse.Y + 36);

    if library.flags["chatspammer"] then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer("Trolling42",library.flags["spamtext"], false, nil, false, true)
    end

    if library.flags["chatadvertiser"] then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer("Trolling42", menuadvertisement[math.random(0, #menuadvertisement)], false, nil, false, true)
    end

    dwLocalPlayer.PlayerGui.GUI.Client.Variables.defaultfov.Value = library.flags["defaultfov"]

    if library.flags["mouseaimbot"] or library.flags["silentaimbot"] then
        if library.flags["ignorefovaimbot"] then
            closest = GetClosestPlayer(math.huge)
        else
            closest = GetClosestPlayer(library.flags["aimbotfovsize"])
        end
    end

    if library.flags["visskin"] then
        if game:GetService("Workspace").Camera:WaitForChild("Arms") then
            for i,v in ipairs(game:GetService("Workspace").Camera.Arms:GetDescendants()) do
                if v.Name == "Skin" or v:IsA("Texture") then
                    v.Texture = "http://www.roblox.com/asset/?id="..library.flags["visskinID"]
                end
            end
        end
    end

    if library.flags["unlimitedammo"] then
        dwLocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 10
    end

    if library.flags["telekill"] then
        for index, v in ipairs(game.Players:GetChildren()) do
            if v ~= dwLocalPlayer and teamcheck(v) then
                dwLocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 10
                if target == nil then
                    if teamcheck(v) and v.NRPBS.Health.Value > 0 then
                        target = v
                    end
                else
                    if target.NRPBS.Health.Value > 0 then
                        if dwLocalPlayer.NRPBS.Health.Value > 0 then
                            local magnitude = (target.Character.HumanoidRootPart.Position - dwLocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            teleportTo(target.Character:WaitForChild("HumanoidRootPart"))
                            if magnitude > 4 then
                                dwLocalPlayer.PlayerGui.GUI.Client.Variables.Held.Value = true
                            end
                            dwCamera.CFrame = CFrame.new(dwCamera.CFrame.Position, Vector3.new(target.Character:WaitForChild("Head").CFrame.Position.X, target.Character:WaitForChild("Head").CFrame.Position.Y, target.Character:WaitForChild("Head").CFrame.Position.Z))
                        end
                    else
                        target = nil
                    end
                end
            end
        end
    end

    if library.flags["autoshoot"] then
        if library.flags["silentaimbot"] then
            if closest and closest.Character[library.flags["aimbotbone"]] and dwCurrentWeapon ~= "Knife" and dwCurrentWeapon ~= "Golden Knife" then
                shootWeapon()
            end
        end
    end

    if library.flags["nospread"] then
        dwLocalPlayer.PlayerGui.GUI.Client.Variables.currentspread.Value = 0
    end

    if closest and closest.Character[library.flags["aimbotbone"]] then
        local Position, OnScreen = dwCamera:WorldToScreenPoint(closest.Character[library.flags["aimbotbone"]].Position)
        if OnScreen and (UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and library.flags["mouseaimbot"]) then
            mousemoverel((Position.X - dwMouse.X) / library.flags["aimbotfovsmoothing"], (Position.Y - dwMouse.Y) / library.flags["aimbotfovsmoothing"])
        end
    end

	if library.flags["flyer"] == true then
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            velocity = velocity + (dwCamera.CFrame.LookVector * library.flags["flyspeed"])
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            velocity = velocity + (dwCamera.CFrame.RightVector * -library.flags["flyspeed"])
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            velocity = velocity + (dwCamera.CFrame.LookVector * -library.flags["flyspeed"])
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            velocity = velocity + (dwCamera.CFrame.RightVector * library.flags["flyspeed"])
        end

        dwLocalPlayer.Character.HumanoidRootPart.Velocity = velocity
    end

    if library.flags["lowgravity"] == true then
        game:GetService("Workspace").Gravity = 100
    end

    if library.flags["bhopjump"] then
        local dir = dwCamera.CFrame.LookVector * Vector3.new(1,0,1)
        local move = Vector3.new()

        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            
            if library.flags["bhoptype"] == "Rage" then
                move = UIS:IsKeyDown(Enum.KeyCode.W) and move + dir or move
                move = UIS:IsKeyDown(Enum.KeyCode.S) and move - dir or move
                move = UIS:IsKeyDown(Enum.KeyCode.D) and move + Vector3.new(-dir.Z,0,dir.X) or move
                move = UIS:IsKeyDown(Enum.KeyCode.A) and move + Vector3.new(dir.Z,0,-dir.X) or move

                if move.Unit.X == move.Unit.X then
                    move = move.Unit
                    dwLocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(move.X*library.flags["cframespeed"],dwLocalPlayer.Character.HumanoidRootPart.Velocity.Y,move.Z*library.flags["cframespeed"])
                end
            end

            if dwLocalPlayer.Character.Humanoid.FloorMaterial == Enum.Material.Air then
            else
                dwLocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end
    end

    if library.flags["triggerbot"] then
        if dwLocalPlayer.Character ~= nil and dwLocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and dwLocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 and dwMouse.Target.Parent:FindFirstChild("Humanoid") ~= nil and dwMouse.Target.Parent.Name ~= dwLocalPlayer.Name and dwMouse.Target.Parent:FindFirstChild("Humanoid").Health > 0 then
            local target = game:GetService("Players"):FindFirstChild(dwMouse.Target.Parent.Name)
            if target ~= nil and teamcheck(target) then
                wait(library.flags["tbdelay"] / 1000)
                shootWeapon()
            end
        end
    end
end)

dwLocalPlayer.PlayerGui.GUI.Client.Variables.Held:GetPropertyChangedSignal("Value"):Connect(function(t)
    if t == false then
        return
    end
    if library.flags["bullettracers"] then
        Beam(dwCamera and dwCamera.CFrame.p or dwLocalPlayer.Character:FindFirstChild("Head").Position, dwMouse.Hit.Position)
    end
end)

dwLocalPlayer.Damage:GetPropertyChangedSignal("Value"):Connect(function(t)
    if t == 0 then
        return
    end

    if library.flags["hitsound"] then
        local sound = Instance.new("Sound")
        sound.Parent = game:GetService("SoundService")
        sound.SoundId = hitsounds[library.flags["hitsoundlist"]]
        sound.Volume = 1
        sound.PlayOnRemove = true
        sound:Destroy()
    end
end)

--remote redirection
local Old; Old = hookmetamethod(game, "__namecall", function(Self, ...)
    local args = {...}
    local Method = getnamecallmethod()

    if math.random(0, 100) <= library.flags["silenthitchance"] then
        if closest and closest.Character[library.flags["aimbotbone"]] and not checkcaller() and Method == "FireServer" and Self.Name == ("RemoteEvent") then
            if library.flags["silentaimbot"] then
                if args[1][1] == "createparticle" then
                    args[1][3] = closest.Character[library.flags["aimbotbone"]]
                    args[1][4] = closest.Character[library.flags["aimbotbone"]].Position
                end
            end
        end

        if closest and closest.Character[library.flags["aimbotbone"]] and not checkcaller() and Method == "FireServer" and Self.Name == ("ReplicateProjectile") then
            if library.flags["silentaimbot"] then
                args[1][10] = closest.Character[library.flags["aimbotbone"]].Position
                args[1][3] = closest.Character[library.flags["aimbotbone"]].Position
                --args[1][4] = closest.Character[library.flags["aimbotbone"]].CFrame
            end
        end

        if closest and closest.Character[library.flags["aimbotbone"]] and not checkcaller() and Method == "FireServer" and Self.Name == utf8.char(8203, 72, 105, 116, 80, 97, 114, 116) then
            if library.flags["silentaimbot"] then
                args[1] = closest.Character.Head
            end
        end

        if closest and closest.Character[library.flags["aimbotbone"]] and Self.Name == "Workspace" and Method == "FindPartOnRayWithIgnoreList" then
            if library.flags["silentaimbot"] then
                return closest.Character[library.flags["aimbotbone"]], closest.Character[library.flags["aimbotbone"]].Position, closest.Character[library.flags["aimbotbone"]].Position.Unit, closest.Character[library.flags["aimbotbone"]].Material
            end
        end
    end
    return Old(Self, unpack(args))
end)

function drawHumanESP(v)
    local Outline = {
        BoxesOutline = Drawing.new('Square'),
    }

    local esptable = {
        Boxes = Drawing.new('Square'),
        Lines = Drawing.new('Line'),
        Playername = Drawing.new('Text'),
        Distance = Drawing.new('Text'),
        Weapon = Drawing.new('Text'),
        Lookangle = Drawing.new('Line'),
    }

    local skeletontable = {
        Skeleton = {
            Spine = Drawing.new('Line'),
            LowerSpine = Drawing.new('Line'),
            LeftupperLeg = Drawing.new('Line'),
            LeftlowerLeg = Drawing.new('Line'),
            LeftFoot = Drawing.new('Line'),
            RightlowerLeg = Drawing.new('Line'),
            RightupperLeg = Drawing.new('Line'),
            RightFoot = Drawing.new('Line'),
            RightUpperArm = Drawing.new('Line'),
            RightLowerArm = Drawing.new('Line'),
            RightHand = Drawing.new('Line'),
            LeftUpperArm = Drawing.new('Line'),
            LeftLowerArm = Drawing.new('Line'),
            LeftHand = Drawing.new('Line'),
        },
    }

    Outline.BoxesOutline.Position = Vector2.new(20, 20);
    Outline.BoxesOutline.Size = Vector2.new(20, 20); -- pixels offset from .Position
    Outline.BoxesOutline.Thickness = 2;
    Outline.BoxesOutline.Color = Color3.fromRGB(0, 0, 0);
    Outline.BoxesOutline.Filled = false;
    Outline.BoxesOutline.Transparency = 0.9;
    Outline.BoxesOutline.Visible = false

    esptable.Boxes.Position = Vector2.new(20, 20);
    esptable.Boxes.Size = Vector2.new(20, 20); -- pixels offset from .Position
    esptable.Boxes.Thickness = 1;
    esptable.Boxes.Color = Color3.fromRGB(255, 255, 255);
    esptable.Boxes.Filled = false;
    esptable.Boxes.Transparency = 0.9;
    esptable.Boxes.Visible = false

    esptable.Lines.From = Vector2.new(20, 20); -- origin
    esptable.Lines.To = Vector2.new(50, 50); -- destination
    esptable.Lines.Color = Color3.new(.33, .66, .99);
    esptable.Lines.Thickness = 1;
    esptable.Lines.Transparency = 0.9;
    esptable.Lines.Visible = false
    esptable.Lookangle.From = Vector2.new(20, 20); -- origin
    esptable.Lookangle.To = Vector2.new(50, 50); -- destination
    esptable.Lookangle.Color = Color3.new(.33, .66, .99);
    esptable.Lookangle.Thickness = 1;
    esptable.Lookangle.Transparency = 0.9;
    esptable.Lookangle.Visible = false

    esptable.Playername.Text = ""
    esptable.Playername.Color = Color3.new(1, 1, 1)
    esptable.Playername.OutlineColor = Color3.new(0, 0, 0)
    esptable.Playername.Center = true
    esptable.Playername.Outline = true
    esptable.Playername.Position = Vector2.new(100, 100)
    esptable.Playername.Size = 15
    esptable.Playername.Font = Drawing.Fonts.Monospace -- 'UI', 'System', 'Plex', 'Monospace'
    esptable.Playername.Transparency = 0.9
    esptable.Playername.Visible = false
    
    esptable.Distance.Text = ""
    esptable.Distance.Color = Color3.new(1, 1, 1)
    esptable.Distance.OutlineColor = Color3.new(0, 0, 0)
    esptable.Distance.Center = true
    esptable.Distance.Outline = true
    esptable.Distance.Position = Vector2.new(100, 100)
    esptable.Distance.Size = 15
    esptable.Distance.Font = Drawing.Fonts.Monospace -- 'UI', 'System', 'Plex', 'Monospace'
    esptable.Distance.Transparency = 0.9
    esptable.Distance.Visible = false

    esptable.Weapon.Text = ""
    esptable.Weapon.Color = Color3.new(1, 1, 1)
    esptable.Weapon.OutlineColor = Color3.new(0, 0, 0)
    esptable.Weapon.Center = true
    esptable.Weapon.Outline = true
    esptable.Weapon.Position = Vector2.new(100, 100)
    esptable.Weapon.Size = 15
    esptable.Weapon.Font = Drawing.Fonts.Monospace -- 'UI', 'System', 'Plex', 'Monospace'
    esptable.Weapon.Transparency = 0.9
    esptable.Weapon.Visible = false

    for index, skeleton in pairs(skeletontable.Skeleton) do
        skeleton.From = Vector2.new(20, 20); -- origin
        skeleton.To = Vector2.new(50, 50); -- destination
        skeleton.Color = Color3.new(.33, .66, .99);
        skeleton.Thickness = 1;
        skeleton.Transparency = 0.9;
        skeleton.Visible = false
    end

    dwRunservice.RenderStepped:Connect(function()
        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Head") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character:FindFirstChild("UpperTorso") ~= nil and v.Character.Humanoid.Health > 0 then
            local displayEsp = v.Character
            if displayEsp then
                local _,onscreen = dwCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                displayEsp = onscreen
            end

            local TL = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
            local TR = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
            local BL = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
            local BR = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)
            local rootPos = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local magnitude = (v.Character.UpperTorso.Position - dwCamera.CFrame.p).Magnitude

            if displayEsp and library.flags["esp"] and magnitude < library.flags["espmaxdistance"] then

                if library.flags["espsnaplinesymouse"] then
                    esptable.Lines.From = Vector2.new(dwMouse.X, dwMouse.Y + 36)
                else
                    esptable.Lines.From = Vector2.new(dwCamera.ViewportSize.X/2,library.flags["espsnaplineyaxis"])
                end

                esptable.Boxes.Filled = false
                esptable.Boxes.Transparency = 0.9;
                Outline.BoxesOutline.Thickness = 2;

                for index, esp in pairs(Outline) do
                    esp.Color = Color3.fromRGB(0,0,0)
                end

                esptable.Playername.Size = library.flags["espinfosize"]
                esptable.Distance.Size = library.flags["espinfosize"]

                Outline.BoxesOutline.Size = Vector2.new(2500 / rootPos.Z, TL.Y -  BL.Y)
                Outline.BoxesOutline.Position = Vector2.new(rootPos.X - Outline.BoxesOutline.Size.X / 2, rootPos.Y - Outline.BoxesOutline.Size.Y / 1.8)
                esptable.Boxes.Size = Vector2.new(2500 / rootPos.Z, TL.Y -  BL.Y)
                esptable.Boxes.Position = Vector2.new(rootPos.X - esptable.Boxes.Size.X / 2, rootPos.Y - esptable.Boxes.Size.Y / 1.8)

                esptable.Lines.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character.UpperTorso.Position).X, dwCamera:WorldToViewportPoint(v.Character.UpperTorso.Position).Y)

                esptable.Playername.Position = Vector2.new(esptable.Boxes.Size.X / 2 + esptable.Boxes.Position.X, esptable.Boxes.Position.Y)
                esptable.Distance.Position = Vector2.new(esptable.Boxes.Size.X / 2 + esptable.Boxes.Position.X, esptable.Boxes.Position.Y + 14)
                esptable.Weapon.Position = Vector2.new(esptable.Boxes.Size.X / 2 + esptable.Boxes.Position.X, esptable.Boxes.Position.Y + 30)

                esptable.Lookangle.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character.Head.Position).X, dwCamera:WorldToViewportPoint(v.Character.Head.Position).Y)
                esptable.Lookangle.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character.Head.CFrame * CFrame.new(0,0,-4).p).X, dwCamera:WorldToViewportPoint(v.Character.Head.CFrame * CFrame.new(0,0,-4).p).Y)

                skeletontable.Skeleton.Spine.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("Head").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("Head").Position).Y)
                skeletontable.Skeleton.Spine.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("UpperTorso").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("UpperTorso").Position).Y)
                skeletontable.Skeleton.LowerSpine.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("UpperTorso").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("UpperTorso").Position).Y)
                skeletontable.Skeleton.LowerSpine.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LowerTorso").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LowerTorso").Position).Y)
                skeletontable.Skeleton.LeftupperLeg.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LowerTorso").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LowerTorso").Position).Y)
                skeletontable.Skeleton.LeftupperLeg.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftUpperLeg").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftUpperLeg").Position).Y)
                skeletontable.Skeleton.LeftlowerLeg.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftUpperLeg").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftUpperLeg").Position).Y)
                skeletontable.Skeleton.LeftlowerLeg.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftLowerLeg").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftLowerLeg").Position).Y)
                skeletontable.Skeleton.LeftFoot.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftLowerLeg").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftLowerLeg").Position).Y)
                skeletontable.Skeleton.LeftFoot.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftFoot").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftFoot").Position).Y)
                skeletontable.Skeleton.RightupperLeg.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LowerTorso").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LowerTorso").Position).Y)
                skeletontable.Skeleton.RightupperLeg.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightUpperLeg").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightUpperLeg").Position).Y)
                skeletontable.Skeleton.RightlowerLeg.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightUpperLeg").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightUpperLeg").Position).Y)
                skeletontable.Skeleton.RightlowerLeg.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightLowerLeg").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightLowerLeg").Position).Y)
                skeletontable.Skeleton.RightFoot.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightLowerLeg").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightLowerLeg").Position).Y)
                skeletontable.Skeleton.RightFoot.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightFoot").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightFoot").Position).Y)
                skeletontable.Skeleton.RightUpperArm.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("UpperTorso").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("UpperTorso").Position).Y)
                skeletontable.Skeleton.RightUpperArm.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightUpperArm").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightUpperArm").Position).Y)
                skeletontable.Skeleton.RightLowerArm.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightUpperArm").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightUpperArm").Position).Y)
                skeletontable.Skeleton.RightLowerArm.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightLowerArm").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightLowerArm").Position).Y)
                skeletontable.Skeleton.RightHand.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightLowerArm").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightLowerArm").Position).Y)
                skeletontable.Skeleton.RightHand.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightHand").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("RightHand").Position).Y)
                skeletontable.Skeleton.LeftUpperArm.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("UpperTorso").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("UpperTorso").Position).Y)
                skeletontable.Skeleton.LeftUpperArm.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftUpperArm").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftUpperArm").Position).Y)
                skeletontable.Skeleton.LeftLowerArm.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftUpperArm").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftUpperArm").Position).Y)
                skeletontable.Skeleton.LeftLowerArm.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftLowerArm").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftLowerArm").Position).Y)
                skeletontable.Skeleton.LeftHand.From = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftLowerArm").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftLowerArm").Position).Y)
                skeletontable.Skeleton.LeftHand.To = Vector2.new(dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftHand").Position).X, dwCamera:WorldToViewportPoint(v.Character:WaitForChild("LeftHand").Position).Y)

                if teamcheck(v) then
                    Outline.BoxesOutline.Visible = library.flags["espbox"]
                    esptable.Boxes.Visible = library.flags["espbox"]
                    esptable.Lines.Visible = library.flags["espsnaplines"]
                    esptable.Playername.Visible = library.flags["espname"]
                    esptable.Playername.Text = "Enemy: "..v.Name
                    esptable.Distance.Visible = library.flags["espdistance"]
                    esptable.Distance.Text = "Distance: "..math.ceil(magnitude)
                    esptable.Weapon.Visible = library.flags["espweapon"]
                    esptable.Lookangle.Visible = library.flags["esplookangle"]

                    for _i,_v in pairs(v.Character:GetChildren()) do
                        if _v:IsA("Tool") then
                            esptable.Weapon.Text = _v.Name
                        else
                            esptable.Weapon.Text =  "No Weapon"
                        end
                    end

                    for index, skeleton in pairs(skeletontable.Skeleton) do
                        skeleton.Visible = library.flags["espskeleton"]
                    end

                    if library.flags["mouseaimbot"] and library.flags["esphighlighttarget"] and closest and (v.Name == closest.Name) then
                        for index, esp in pairs(esptable) do
                            esp.Color = library.flags["esphighlightcolor"]
                        end
                        for index, skeleton in pairs(skeletontable.Skeleton) do
                            skeleton.Color = library.flags["esphighlightcolor"]
                        end
                    else
                        for index, esp in pairs(esptable) do
                            esp.Color = library.flags["espcolor"]
                        end

                        for index, skeleton in pairs(skeletontable.Skeleton) do
                            skeleton.Color = library.flags["espcolor"]
                        end
                    end
                else
                    Outline.BoxesOutline.Visible = library.flags["espbox"] and library.flags["espshowteam"]
                    esptable.Boxes.Visible = library.flags["espbox"] and library.flags["espshowteam"]
                    esptable.Lines.Visible = library.flags["espsnaplines"] and library.flags["espshowteam"]
                    esptable.Lookangle.Visible = library.flags["esplookangle"] and library.flags["espshowteam"]
                    esptable.Playername.Visible = library.flags["espname"] and library.flags["espshowteam"]
                    esptable.Distance.Visible = library.flags["espdistance"] and library.flags["espshowteam"]
                    esptable.Playername.Text = "Friendly: "..v.Name
                    esptable.Distance.Text = "Distance: "..math.ceil(magnitude)
                    esptable.Weapon.Visible = library.flags["espweapon"] and library.flags["espshowteam"]
                    for _i,_v in pairs(v.Character:GetChildren()) do
                        if _v:IsA("Tool") then
                            esptable.Weapon.Text = _v.Name
                        else
                            esptable.Weapon.Text =  "No Weapon"
                        end
                    end
                    for index, esp in pairs(esptable) do
                        esp.Color = library.flags["espteamcolor"]
                    end

                    for index, skeleton in pairs(skeletontable.Skeleton) do
                        skeleton.Visible = library.flags["espskeleton"] and library.flags["espshowteam"]
                        skeleton.Color = library.flags["espteamcolor"]
                    end
                end
            else
                for index, esp in pairs(Outline) do
                    esp.Visible = false
                end
                for index, esp in pairs(esptable) do
                    esp.Visible = false
                end
                for index, skeleton in pairs(skeletontable.Skeleton) do
                    skeleton.Visible = false
                end
            end
        else
            for index, esp in pairs(Outline) do
                esp.Visible = false
            end
            for index, esp in pairs(esptable) do
                esp.Visible = false
            end
            for index, skeleton in pairs(skeletontable.Skeleton) do
                skeleton.Visible = false
            end
        end
    end)
end

function RotateVect(v, a) --donated by a sweet young man
    a = math.rad(a)
    local x = v.X * math.cos(a) - v.Y * math.sin(a)
    local y = v.X * math.sin(a) + v.Y * math.cos(a)

    return Vector2.new(x, y)
end

function drawIndicators(v)
    local Indicator = Drawing.new('Triangle');
    Indicator.Thickness = 1
    Indicator.Color = Color3.fromRGB(255, 255, 255);
    Indicator.Filled = false;
    Indicator.Transparency = 0.9;

    dwRunservice.RenderStepped:Connect(function()
        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character.Humanoid.Health > 0 then
            local displayEsp = v.Character
            if displayEsp then
                local _,onscreen = dwCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                displayEsp = onscreen
            end

            local Character = v.Character
            local WorldPosition = Character.HumanoidRootPart.Position
            local CameraVector = dwCamera.CFrame.Position
            local LookVector = dwCamera.CFrame.LookVector
            local ProjectVector = (WorldPosition - CameraVector)
            local Dot = LookVector:Dot(ProjectVector)
            if Dot <= 0 then
                WorldPosition = (CameraVector + (ProjectVector - ((LookVector * Dot) * 1.01)))
            end
            local ScreenPosition, Visible = dwCamera:WorldToScreenPoint(WorldPosition)
            local RayCast = workspace:FindPartOnRay(Ray.new(CameraVector, ((WorldPosition - CameraVector).Unit * 500)), dwLocalPlayer.Character, false, false)

            if displayEsp == false and v ~= dwLocalPlayer then
                local Center = (dwCamera.ViewportSize / 2)
                local Direction = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - Center).Unit

                if teamcheck(v) then
                    Indicator.Color = library.flags["indcolor"]
                    Indicator.Visible = library.flags["indicators"]
                else
                    Indicator.Color = library.flags["espteamcolor"]
                    Indicator.Visible = library.flags["indicators"] and library.flags["espshowteam"]
                end

                Indicator.PointA = Vector2.new(math.round(dwCamera.ViewportSize.X/2 - Direction.X * library.flags["indradius"] + RotateVect(Direction, 90).X * 14/2), math.round(dwCamera.ViewportSize.Y/2 - Direction.Y * library.flags["indradius"] + RotateVect(Direction, 90).Y * 14/2))
                Indicator.PointB = Vector2.new(math.round(dwCamera.ViewportSize.X/2 - Direction.X * library.flags["indradius"] + RotateVect(Direction, -90).X * 14/2), math.round(dwCamera.ViewportSize.Y/2 - Direction.Y * library.flags["indradius"] + RotateVect(Direction, -90).Y * 14/2))
                Indicator.PointC = Vector2.new(math.round(dwCamera.ViewportSize.X/2 - Direction.X * (library.flags["indradius"] + 10)), math.round(dwCamera.ViewportSize.Y/2 - Direction.Y * (library.flags["indradius"] + 10)))
            else
                Indicator.Visible = false
            end
        else
            Indicator.Visible = false
        end
    end)
end

--player esp
for i, player in ipairs(game:GetService("Players"):GetChildren()) do
    drawHumanESP(player)
    drawIndicators(player)
end

game:GetService("Players").PlayerAdded:Connect(function(player)
	drawHumanESP(player)
    drawIndicators(player)
end)

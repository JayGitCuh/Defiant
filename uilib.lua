--Made by Jaay#6265
local library = { 
	flags = { },
	items = { }
}

local UserInputService = game:GetService("UserInputService")

local function MakeDraggable(ClickObject, Object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	ClickObject.InputBegan:Connect(function(Input)
		if
			Input.UserInputType == Enum.UserInputType.MouseButton1
			or Input.UserInputType == Enum.UserInputType.Touch
		then
			Dragging = true
			DragStart = Input.Position
			StartPosition = Object.Position

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	ClickObject.InputChanged:Connect(function(Input)
		if
			Input.UserInputType == Enum.UserInputType.MouseMovement
			or Input.UserInputType == Enum.UserInputType.Touch
		then
			DragInput = Input
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - DragStart
			Object.Position = UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		end
	end)
end

local players = game:GetService("Players")
local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")
local tweenservice = game:GetService("TweenService")
local marketplaceservice = game:GetService("MarketplaceService")
local textservice = game:GetService("TextService")
local coregui = game:GetService("CoreGui")
local httpservice = game:GetService("HttpService")

local player = players.LocalPlayer
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera

function library:CreateLibrary()

    if game:GetService('CoreGui'):FindFirstChild("Defiant") then
        game:GetService('CoreGui'):FindFirstChild("Defiant"):Destroy()
    end

    local menubase = Instance.new('ScreenGui')

    menubase.Name = 'Defiant'
    menubase.Parent = game:GetService('CoreGui')
    if syn then
        syn.protect_gui(menubase)
    end

    local insideLibrary = {}
    function insideLibrary:addOverlay()
        local overlay = {}

        local Overlay = Instance.new('Frame')
        local OverlayUILIST = Instance.new('UIListLayout')
        

        Overlay.Name = 'Overlay'
        Overlay.Size = UDim2.new(0, 100, 0, 999)
        Overlay.Position = UDim2.new(0.9286457896232605, 0, 0.034, 0)
        Overlay.BackgroundTransparency = 1
        Overlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Overlay.Parent = menubase

        OverlayUILIST.Name = 'OverlayUILIST'
        OverlayUILIST.SortOrder = Enum.SortOrder.LayoutOrder
        OverlayUILIST.Padding = UDim.new(0, 10)
        OverlayUILIST.HorizontalAlignment = Enum.HorizontalAlignment.Right
        OverlayUILIST.Parent = Overlay

        local overlaytoggle = true
        function overlay:ToggleOverlay()
            if overlaytoggle == false then
                overlaytoggle = true

                Overlay.Visible = true
            else
                overlaytoggle = false

                Overlay.Visible = false
            end
        end

        function overlay:ShowOverlay(bool)
            Overlay.Visible = bool
        end

        function overlay:AddRadar()
            function teamcheck(targetplayer)
                if game.Players.LocalPlayer.Team == targetplayer.Team then return false
                else return true end
            end

            local radar = {}
            local Map = Instance.new('Frame')
            Map.Name = 'Map'
            Map.Size = UDim2.new(0, 250, 0, 250)
            Map.ClipsDescendants = true
            Map.Position = UDim2.new(0.8504791259765625, 0, 0.03417060896754265, 0)
            Map.BackgroundTransparency = 0.1
            Map.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Map.Parent = Overlay

            local Crosshair = Instance.new('ImageLabel')

            Crosshair.Name = 'Crosshair'
            Crosshair.Visible = false
            Crosshair.Position = UDim2.new(0.08543024212121964, 0, 0.15462961792945862, 0)
            Crosshair.Image = 'rbxassetid://8481848789'
            Crosshair.BorderSizePixel = 0
            Crosshair.Size = UDim2.new(0, 22, 0, 22)
            Crosshair.ImageColor3 = Color3.fromRGB(255, 0, 4)
            Crosshair.ScaleType = Enum.ScaleType.Fit
            Crosshair.BorderColor3 = Color3.fromRGB(255, 0, 4)
            Crosshair.BackgroundTransparency = 1
            Crosshair.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Crosshair.Parent = Overlay

            local RadarStroke = Instance.new('UIStroke')
            RadarStroke.Parent = Map
            RadarStroke.Color = Color3.fromRGB(0, 170, 255)

            local RadarCorner = Instance.new('UICorner')
            RadarCorner.CornerRadius = UDim.new(0, 9)
            RadarCorner.Parent = Map

            local bg = Map
            local cross = Crosshair

            local dwLocalPlayer = game.Players.LocalPlayer
            local dwLPC = dwLocalPlayer.Character

            local folder = Instance.new("Folder")
            folder.Name = "Container"
            folder.Parent = bg

            game:GetService("RunService").RenderStepped:Connect(function()
                if Map then
                    folder:ClearAllChildren()
                    local UIAspectRatioConstrait = Instance.new("UIAspectRatioConstraint", folder)
                    for i,v in pairs(game.Players:GetPlayers()) do
                        local plrs = v.Character
                        if v ~= dwLocalPlayer then
                            if plrs and plrs:FindFirstChild("HumanoidRootPart") and dwLPC:FindFirstChild("HumanoidRootPart") then
                                local crossclone = cross:Clone()
                                local offset = plrs.HumanoidRootPart.Position - dwLPC.HumanoidRootPart.Position
                                local distance = 1/200
                                offset = offset * distance
                                crossclone.Visible = true
                                crossclone.Position = UDim2.new(offset.X + 0.451, 0, offset.Z + 0.451, 0)
                                crossclone.Parent = folder
                                if teamcheck(v) then
                                    crossclone.ImageColor3 = Color3.fromRGB(255, 0, 0)
                                else
                                    crossclone.ImageColor3 = Color3.fromRGB(0, 0, 255)
                                end
                            end
                        else
                            local crossclone = cross:Clone()
                            crossclone.ImageColor3 = Color3.fromRGB(0, 170, 255)
                            crossclone.Visible = true
                            crossclone.Position = UDim2.new(0.451, 0, 0.451, 0)
                            crossclone.Parent = folder
                        end
                    end
                end
            end)

            function radar:OpenClose(bool)
                Map.Visible = bool
            end
            return radar
        end

        function overlay:addSection(sectionText)
            local insideSection = {}
            local OverSection = Instance.new('Frame')
            local OverlayCorner = Instance.new('UICorner')
            local OverlaySecUILIST = Instance.new('UIListLayout')
            OverSection.Name = sectionText
            OverSection.Size = UDim2.new(0, 250, 0, 21)
            OverSection.Position = UDim2.new(-1.5, 0, 0, 0)
            OverSection.BackgroundTransparency = 0.1
            OverSection.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            OverSection.AutomaticSize = Enum.AutomaticSize.XY
            OverSection.Parent = Overlay

            OverlaySecUILIST.Name = 'OverlaySecUILIST'
            OverlaySecUILIST.SortOrder = Enum.SortOrder.LayoutOrder
            OverlaySecUILIST.Padding = UDim.new(0, 3)
            OverlaySecUILIST.HorizontalAlignment = Enum.HorizontalAlignment.Center
            OverlaySecUILIST.Parent = OverSection

            local OverlayStroke = Instance.new('UIStroke')
            OverlayStroke.Parent = OverSection
            OverlayStroke.Color = Color3.fromRGB(0, 170, 255)

            OverlayCorner.CornerRadius = UDim.new(0, 9)
            OverlayCorner.Parent = OverSection

            local overlayatoggle = true
            function insideSection:toggleOverlay()
                if overlayatoggle == false then
                    overlayatoggle = true

                    Overlay.Visible = true
                else
                    overlayatoggle = false

                    Overlay.Visible = false
                end
            end

            function insideSection:addLabel(labelText)
                local overlaytext = {}
                local OverlayText = Instance.new('TextLabel')
                OverlayText.Name = 'OverlayText'
                OverlayText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                OverlayText.Size = UDim2.new(0, 223, 0, 21)
                OverlayText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
                OverlayText.TextSize = 14
                OverlayText.Text = labelText
                OverlayText.TextXAlignment = Enum.TextXAlignment.Left
                OverlayText.TextColor3 = Color3.fromRGB(255, 255, 255)
                OverlayText.Font = Enum.Font.SourceSans
                OverlayText.Position = UDim2.new(-1.500799536705017, 0, 0, 0)
                OverlayText.BackgroundTransparency = 1
                OverlayText.Parent = OverSection

                function overlaytext:ChangeText(newtext)
                    OverlayText.Text = newtext
                end

                return overlaytext
            end
            return insideSection
        end
        return overlay
    end

    function insideLibrary:addHealthbar()
        local insideHealthGui = {}

        local Healthbar = Instance.new('Frame')
        local HealthSize = Instance.new('Frame')
        local HealthCorner = Instance.new('UICorner')
        local HealthBarCorner = Instance.new('UICorner')
        local HealthBarStroke = Instance.new('UIStroke')
        local HealthText = Instance.new('TextLabel')
        local HealthTextStroke = Instance.new('UIStroke')

        local H = game.Players.LocalPlayer.NRPBS.Health.Value
        local MH = game.Players.LocalPlayer.NRPBS.MaxHealth.Value

        Healthbar.Name = 'Healthbar'
        Healthbar.Size = UDim2.new(0, 440, 0, 21)
        Healthbar.Position = UDim2.new(0.4114583432674408, -50, 1.0083333253860474, -100)
        Healthbar.BackgroundTransparency = 1
        Healthbar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        Healthbar.Parent = menubase

        HealthSize.Name = 'HealthSize'
        HealthSize.Size = UDim2.new(0, 440, 0, 21)
        HealthSize.BackgroundColor3 = Color3.fromRGB(123, 255, 0)
        HealthSize.Parent = Healthbar

        HealthCorner.Name = 'HealthCorner'
        HealthCorner.CornerRadius = UDim.new(0,4)
        HealthCorner.Parent = HealthSize

        HealthBarCorner.Name = 'HealthBarCorner'
        HealthBarCorner.CornerRadius = UDim.new(0,4)
        HealthBarCorner.Parent = Healthbar

        HealthBarStroke.Name = 'HealthBarStroke'
        HealthBarStroke.Thickness = 2
        HealthBarStroke.Color = Color3.fromRGB(0, 170, 255)
        HealthBarStroke.Parent = Healthbar

        HealthText.Name = 'HealthText'
        HealthText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        HealthText.Size = UDim2.new(0, 438, 0, 17)
        HealthText.TextSize = 14
        HealthText.Text = tostring("Health ("..math.floor(100/(MH/H)).."/"..MH..")")
        HealthText.TextColor3 = Color3.fromRGB(255, 255, 255)
        HealthText.Font = Enum.Font.SourceSans
        HealthText.Position = UDim2.new(0, 0, -0.8315961360931396, 0)
        HealthText.BackgroundTransparency = 1
        HealthText.Parent = Healthbar

        HealthTextStroke.Name = 'HealthTextStroke'
        HealthTextStroke.Thickness = 0.5
        HealthTextStroke.Color = Color3.fromRGB(0, 0, 0)
        HealthTextStroke.Parent = HealthText

        runservice.RenderStepped:Connect(function()
            HealthSize:TweenSize(UDim2.new(1/(MH/math.floor(H + .5)),0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart,1)
            HealthText.Text = tostring("Health ("..math.floor(100/(MH/H)).."/"..MH..")")
            if H > 0 then
                game.TweenService:Create(HealthSize, TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Transparency = 0,
                }):Play()
            else
                game.TweenService:Create(HealthSize, TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    Transparency = 1,
                }):Play()
            end
        end)

        function insideHealthGui:OpenClose(bool)
            Healthbar.Visible = bool
        end
        return insideHealthGui
    end

    function insideLibrary:addWindow(name)

        local Main = Instance.new('Frame')
        
        local Background = Instance.new('ImageLabel')
        local BGUICorner = Instance.new('UICorner')
        local BGStroke = Instance.new('UIStroke')
        local LeftElement = Instance.new('ImageLabel')
        local NameElement = Instance.new('ImageLabel')
        local GameImage = Instance.new('ImageLabel')
        local UICorner = Instance.new('UICorner')
        local PlayerHeadshot = Instance.new('ImageLabel')
        local TitleLabel = Instance.new('TextLabel')
        local MadeByLabel = Instance.new('TextLabel')
        local WelcomeMSG = Instance.new('TextLabel')
        local Playername = Instance.new('TextLabel')
        local TabElement = Instance.new('ImageLabel')
        local TabContainer = Instance.new('ScrollingFrame')

        local TabUIListLayout = Instance.new('UIListLayout')
        local BottomElement = Instance.new('ImageLabel')
        local LastLogin = Instance.new('TextLabel')
        local LoginDate = Instance.new('TextLabel')

        Main.Name = 'Main'
        Main.Size = UDim2.new(0, 100, 0, 100)
        Main.Position = UDim2.new(0.5, -50, 0.5, -50)
        Main.BackgroundTransparency = 1
        Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Main.Parent = menubase

        local toggle = true

        function insideLibrary:ToggleUI()
            if toggle == false then
                toggle = true

                Main.Visible = true
            else
                toggle = false

                Main.Visible = false
            end
        end

        Background.Name = 'Background'
        Background.Size = UDim2.new(0, 462, 0, 407)
        Background.Position = UDim2.new(0.5, -244, 0.5, -244)
        Background.BackgroundTransparency = 0.10000000149011612
        Background.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        Background.Parent = Main

        BGUICorner.CornerRadius = UDim.new(0, 9)
        BGUICorner.Parent = Background

        BGStroke.Color = Color3.fromRGB(0, 170, 255)
        BGStroke.Parent = Background

        LeftElement.Name = 'LeftElement'
        LeftElement.Position = UDim2.new(0.5, -244, 0.5, -244)
        LeftElement.SliceCenter = Rect.new(100, 100, 100, 100)
        LeftElement.Image = 'rbxassetid://3570695787'
        LeftElement.Size = UDim2.new(0, 157, 0, 407)
        LeftElement.ImageColor3 = Color3.fromRGB(34, 34, 34)
        LeftElement.ScaleType = Enum.ScaleType.Slice
        LeftElement.SliceScale = 0.11999999731779099
        LeftElement.BackgroundTransparency = 1
        LeftElement.BackgroundColor3 = Color3.fromRGB(139, 139, 139)
        LeftElement.Parent = Main

        MakeDraggable(LeftElement, Main)
        
        NameElement.Name = 'NameElement'
        NameElement.Position = UDim2.new(0.5899682641029358, -244, 0.9321203827857971, -244)
        NameElement.SliceCenter = Rect.new(100, 100, 100, 100)
        NameElement.Image = 'rbxassetid://3570695787'
        NameElement.Size = UDim2.new(0, 141, 0, 55)
        NameElement.ImageColor3 = Color3.fromRGB(26, 26, 26)
        NameElement.ScaleType = Enum.ScaleType.Slice
        NameElement.ClipsDescendants = true
        NameElement.SliceScale = 0.11999999731779099
        NameElement.BackgroundTransparency = 1
        NameElement.BackgroundColor3 = Color3.fromRGB(139, 139, 139)
        NameElement.Parent = Main
        
        GameImage.Name = 'GameImage'
        GameImage.Position = UDim2.new(-1.7300001382827759, 0, -1.9100000858306885, 0)
        GameImage.Image = "https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid="..game.PlaceId.."&fmt=png&wd=420&ht=420"
        GameImage.Size = UDim2.new(0, 35, 0, 35)
        GameImage.BackgroundTransparency = 1
        GameImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        GameImage.Parent = Main
        UICorner.Parent = GameImage
        
        PlayerHeadshot.Name = 'PlayerHeadshotElement'
        PlayerHeadshot.Position = UDim2.new(-1.820000171661377, 0, -1.4100000858306885, 0)
        PlayerHeadshot.Image = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        PlayerHeadshot.Size = UDim2.new(0, 35, 0, 35)
        PlayerHeadshot.BackgroundTransparency = 1
        PlayerHeadshot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        PlayerHeadshot.Parent = Main

        local UICornerPH = Instance.new('UICorner')
        UICornerPH.Parent = PlayerHeadshot

        TitleLabel.Name = 'TitleLabel'
        TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.Size = UDim2.new(0, 96, 0, 45)
        TitleLabel.TextSize = 18
        TitleLabel.Text = name
        TitleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.Position = UDim2.new(-0.4636242687702179, -100, -1.7027777433395386, -25)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Parent = Main

        MadeByLabel.Name = 'MadeByLabel'
        MadeByLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MadeByLabel.Size = UDim2.new(0, 96, 0, 45)
        MadeByLabel.TextTransparency = 0.30000001192092896
        MadeByLabel.Text = 'Made by Jay'
        MadeByLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        MadeByLabel.Font = Enum.Font.Gotham
        MadeByLabel.Position = UDim2.new(-0.46399998664855957, -100, -1.6130000352859497, -23)
        MadeByLabel.BackgroundTransparency = 1
        MadeByLabel.Parent = Main

        WelcomeMSG.Name = 'WelcomeMSG'
        WelcomeMSG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        WelcomeMSG.Size = UDim2.new(0, 87, 0, 43)
        WelcomeMSG.TextSize = 11
        WelcomeMSG.Text = 'WELCOME BACK'
        WelcomeMSG.TextColor3 = Color3.fromRGB(0, 170, 255)
        WelcomeMSG.Font = Enum.Font.Gotham
        WelcomeMSG.Position = UDim2.new(-0.3799999952316284, -100, -1.2899999618530273, -20)
        WelcomeMSG.BackgroundTransparency = 1
        WelcomeMSG.Parent = Main
        
        Playername.Name = 'Playername'
        Playername.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Playername.Size = UDim2.new(0, 87, 0, 20)
        Playername.Text = game.Players.LocalPlayer.Name
        Playername.TextColor3 = Color3.fromRGB(255, 255, 255)
        Playername.Font = Enum.Font.GothamSemibold
        Playername.Position = UDim2.new(-0.3799999952316284, -100, -1.0099999904632568, -25)
        Playername.BackgroundTransparency = 1
        Playername.Parent = Main
        
        TabElement.Name = 'TabElement'
        TabElement.Position = UDim2.new(0.579968273639679, -244, 1.582120418548584, -244)
        TabElement.SliceCenter = Rect.new(100, 100, 100, 100)
        TabElement.Image = 'rbxassetid://3570695787'
        TabElement.Size = UDim2.new(0, 141, 0, 227)
        TabElement.ImageColor3 = Color3.fromRGB(26, 26, 26)
        TabElement.ScaleType = Enum.ScaleType.Slice
        TabElement.SliceScale = 0.11999999731779099
        TabElement.BackgroundTransparency = 1
        TabElement.BackgroundColor3 = Color3.fromRGB(139, 139, 139)
        TabElement.Parent = Main

        local Tabscrolllllll = UDim2.new(0, 0, 0, 0)

        TabContainer.Name = 'TabContainer'
        TabContainer.Active = true
        TabContainer.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
        TabContainer.Size = UDim2.new(0, 141, 0, 207)
        TabContainer.CanvasSize = Tabscrolllllll
        TabContainer.ScrollBarImageColor3 = Color3.fromRGB(87, 89, 91)
        TabContainer.ScrollBarThickness = 3
        TabContainer.Position = UDim2.new(0, 0, 0.04126930981874466, 0)
        TabContainer.BorderSizePixel = 0
        TabContainer.BackgroundTransparency = 0
        TabContainer.Parent = TabElement

        local tabelementbackground = Instance.new('Frame')
            
        tabelementbackground.Name = 'tabelementbackground'
        tabelementbackground.Size = UDim2.new(0, 141, 0, 26)
        tabelementbackground.AutomaticSize = Enum.AutomaticSize.XY
        tabelementbackground.BackgroundTransparency = 1
        tabelementbackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabelementbackground.Parent = TabContainer

        

        TabUIListLayout.Name = 'TabUIListLayout'
        TabUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabUIListLayout.Padding = UDim.new(0, 4)
        TabUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        TabUIListLayout.Parent = tabelementbackground

        TabContainer.CanvasSize = UDim2.new(0,0,0,TabUIListLayout.AbsoluteContentSize.Y)
        tabelementbackground.ChildAdded:Connect(function()
            TabContainer.CanvasSize = UDim2.new(0,0,0, TabUIListLayout.AbsoluteContentSize.Y + tabelementbackground.Size.Y.Offset + TabUIListLayout.Padding.Offset)
        end)

        BottomElement.Name = 'BottomElement'
        BottomElement.Position = UDim2.new(0.579968273639679, -244, 3.9445366859436035, -244)
        BottomElement.SliceCenter = Rect.new(100, 100, 100, 100)
        BottomElement.Image = 'rbxassetid://3570695787'
        BottomElement.Size = UDim2.new(0, 141, 0, 50)
        BottomElement.ImageColor3 = Color3.fromRGB(26, 26, 26)
        BottomElement.ScaleType = Enum.ScaleType.Slice
        BottomElement.SliceScale = 0.11999999731779099
        BottomElement.BackgroundTransparency = 1
        BottomElement.BackgroundColor3 = Color3.fromRGB(139, 139, 139)
        BottomElement.Parent = Main

        LastLogin.Name = 'LastLogin'
        LastLogin.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LastLogin.Size = UDim2.new(0, 136, 0, 26)
        LastLogin.TextSize = 14
        LastLogin.Text = os.date("%x")
        LastLogin.TextColor3 = Color3.fromRGB(255, 255, 255)
        LastLogin.Font = Enum.Font.Gotham
        LastLogin.Position = UDim2.new(0.02839130349457264, 0, 0, 0)
        LastLogin.BackgroundTransparency = 1
        LastLogin.Parent = BottomElement

        local startTime = os.clock()
        local a, b = 0, 1
        for i = 1, 5000000 do
            a, b = b, a
        end
        local deltaTime = os.clock() - startTime

        LoginDate.Name = 'LoginDate'
        LoginDate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LoginDate.Size = UDim2.new(0, 136, 0, 26)
        LoginDate.TextSize = 12
        LoginDate.Text = deltaTime
        LoginDate.TextColor3 = Color3.fromRGB(255, 255, 255)
        LoginDate.Font = Enum.Font.Gotham
        LoginDate.Position = UDim2.new(0.02800000086426735, 0, 0.47999998927116394, 0)
        LoginDate.BackgroundTransparency = 1
        LoginDate.Parent = BottomElement

        local Pages = Instance.new('Folder')
        Pages.Name = 'Pages'
        Pages.Parent = Main

        local TabAmount = 0

        local insideWindow = {}

        function insideWindow:addTab(tabtext)

            local TabButtonElement = Instance.new('ImageLabel')
            local TabButton = Instance.new('TextButton')

            TabButtonElement.Name = 'TabButtonElement'
            TabButtonElement.Position = UDim2.new(0.05673758685588837, 0, 0, 0)
            TabButtonElement.SliceCenter = Rect.new(100, 100, 100, 100)
            TabButtonElement.Image = 'rbxassetid://3570695787'
            TabButtonElement.Size = UDim2.new(0, 131, 0, 31)
            TabButtonElement.ImageColor3 = Color3.fromRGB(76, 76, 76)
            TabButtonElement.ScaleType = Enum.ScaleType.Slice
            TabButtonElement.SliceScale = 0.11999999731779099
            TabButtonElement.BackgroundTransparency = 1
            TabButtonElement.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
            TabButtonElement.Parent = tabelementbackground

            TabButton.Name = 'TabButton'
            TabButton.BorderSizePixel = 0
            TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.Size = UDim2.new(0, 130, 0, 31)
            TabButton.Text = tabtext
            TabButton.TextSize = 12
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.Font = Enum.Font.Gotham
            TabButton.BackgroundTransparency = 1
            TabButton.Parent = TabButtonElement

            local TabsContainerBox = Instance.new('ScrollingFrame')
            local Section = Instance.new('ImageLabel')
            local UIListLayout = Instance.new('UIListLayout')
            local UIListLayout_2 = Instance.new('UIListLayout')
            
            TabAmount = TabAmount + 1
            
            TabsContainerBox.Name = TabAmount
            TabsContainerBox.Active = true
            TabsContainerBox.BorderSizePixel = 0
            TabsContainerBox.CanvasSize = UDim2.new(0, 0, 0, 0)
            TabsContainerBox.ScrollBarThickness = 5
            TabsContainerBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TabsContainerBox.Size = UDim2.new(0, 296, 0, 381)
            TabsContainerBox.ScrollBarImageColor3 = Color3.fromRGB(26, 26, 26)
            TabsContainerBox.Position = UDim2.new(-0.29654234647750854, 0, -1.8130841255187988, 0)
            TabsContainerBox.BackgroundTransparency = 1
            TabsContainerBox.Parent = Pages

            if TabAmount == 1 then
                TabsContainerBox.Visible = true
                TabButtonElement.ImageTransparency = 0
            else
                TabsContainerBox.Visible = false
                TabButtonElement.ImageTransparency = 1
            end
            
            Section.Name = 'Section'
            Section.SliceCenter = Rect.new(100, 100, 100, 100)
            Section.Image = 'rbxassetid://3570695787'
            Section.Size = UDim2.new(0, 286, 0, 30)
            Section.ImageColor3 = Color3.fromRGB(34, 34, 34)
            Section.ScaleType = Enum.ScaleType.Slice
            Section.SliceScale = 0.11999999731779099
            Section.BackgroundTransparency = 1
            Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Section.Parent = TabsContainerBox
            Section.AutomaticSize = Enum.AutomaticSize.Y
            
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Parent = Section
            UIListLayout.Padding = UDim.new(0, -4)

            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_2.Parent = TabsContainerBox

            TabsContainerBox.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y)
            Section.ChildAdded:Connect(function()
                TabsContainerBox.CanvasSize = UDim2.new(0,0,0, UIListLayout.AbsoluteContentSize.Y + Section.Size.Y.Offset + UIListLayout.Padding.Offset)
            end)

            TabButton.MouseButton1Click:Connect(function()
                for i, v in next, Pages:GetChildren() do
                    v.Visible = false
                end
    
                for i, v in next, tabelementbackground:GetChildren() do
                    if v:IsA("ImageLabel") then
                        game.TweenService
                        :Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            ImageTransparency = 1,
                        })
                        :Play()
                    end
                end

                game.TweenService
                :Create(TabButtonElement, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ImageTransparency = 0,
                })
                :Play()
    
                TabsContainerBox.Visible = true

                
            end)
            local insideTab = {}
            function insideTab:addButton(btnname, callback)

                local Button = Instance.new('Frame')
                local TextButton1 = Instance.new('TextButton')
                local TextButton_Roundify_12px = Instance.new('Frame')
                local TextLabel = Instance.new('TextLabel')
                
                Button.Name = 'Button'
                Button.Size = UDim2.new(0, 140, 0, 30)
                Button.BorderSizePixel = 0
                Button.BackgroundTransparency = 1
                Button.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Button.Parent = Section
                
                TextButton1.BorderSizePixel = 0
                TextButton1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                TextButton1.Size = UDim2.new(0, 107, 0, 17)
                TextButton1.Text = ""
                TextButton1.TextSize = 14
                TextButton1.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextButton1.Font = Enum.Font.SourceSans
                TextButton1.Position = UDim2.new(0.11394086480140686, 0, 0.243743896484375, 0)
                TextButton1.BackgroundTransparency = 1
                TextButton1.Parent = Button
                
                TextButton_Roundify_12px.Name = 'TextButton_Roundify_12px'
                TextButton_Roundify_12px.Position = UDim2.new(0.11394086480140686, 0, 0.243743896484375, 0)
                TextButton_Roundify_12px.Active = true
                TextButton_Roundify_12px.Selectable = true
                TextButton_Roundify_12px.Size = UDim2.new(1, 0, 1, 0)
                TextButton_Roundify_12px.BackgroundTransparency = 1
                TextButton_Roundify_12px.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
                TextButton_Roundify_12px.Parent = TextButton1
                
                
                TextLabel.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
                TextLabel.Size = UDim2.new(0, 103, 0, 19)
                TextLabel.TextSize = 14
                TextLabel.Text =btnname
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.Font = Enum.Font.SourceSans
                TextLabel.Position = UDim2.new(0, 0, -0.1312040388584137, 0)
                TextLabel.BackgroundTransparency = 0
                TextLabel.Parent = TextButton1
                local UICorner2 = Instance.new('UICorner')
                UICorner2.Parent = TextLabel

                btnname = btnname or "Button"
                callback = callback or function() end

                TextButton1.MouseButton1Click:Connect(function()

                    callback()

                    game.TweenService
                    :Create(TextLabel, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        BackgroundTransparency = 1,
                    })
                    :Play()
                    wait(0.10)
                    game.TweenService
                    :Create(TextLabel, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        BackgroundTransparency = 0,
                    })
                    :Play()
                end)
            end
            
            function insideTab:addLabel(lblname)
                local label = {}
                local Label = Instance.new('Frame')
                local TexxxxxtLabel = Instance.new('TextLabel')
                local UUUUICorner = Instance.new('UICorner')

                Label.Name = 'Label'
                Label.Size = UDim2.new(0, 140, 0, 21)
                Label.Position = UDim2.new(0, 0, 0.9299733638763428, 0)
                Label.BorderSizePixel = 0
                Label.BackgroundTransparency = 1
                Label.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Label.Parent = Section

                TexxxxxtLabel.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
                TexxxxxtLabel.Size = UDim2.new(0, 255, 0, 22)
                TexxxxxtLabel.TextSize = 14
                TexxxxxtLabel.Text = lblname
                TexxxxxtLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TexxxxxtLabel.Font = Enum.Font.SourceSans
                TexxxxxtLabel.Position = UDim2.new(0.11400015652179718, 0, -0.0783604234457016, 0)
                TexxxxxtLabel.BackgroundTransparency = 1
                TexxxxxtLabel.Parent = Label

                UUUUICorner.Parent = TexxxxxtLabel

                function label:ChangeText(newtext)
                    TexxxxxtLabel.Text = newtext
                end
                return label
            end

            function insideTab:addToggle(tglname, default, callback, flag)
                local toggle = { }
                toggle.text = tglname or ""
                toggle.default = default or false
                toggle.callback = callback or function(value) end
                toggle.flag = flag or tglname or ""

                toggle.value = toggle.default

                toggle.Toggle = Instance.new('Frame')
                toggle.ToggleButton = Instance.new('TextButton')
                toggle.Roundify = Instance.new('Frame')
                toggle.ToggleCircle = Instance.new('ImageLabel')
                toggle.ToggleText = Instance.new('TextLabel')

                toggle.Toggle.Name = 'Toggle'..tglname
                toggle.Toggle.Size = UDim2.new(0, 140, 0, 30)
                toggle.Toggle.BorderSizePixel = 0
                toggle.Toggle.BackgroundTransparency = 1
                toggle.Toggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                toggle.Toggle.Parent = Section

                toggle.ToggleButton.Name = 'ToggleButton'
                toggle.ToggleButton.BorderSizePixel = 0
                toggle.ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                toggle.ToggleButton.Size = UDim2.new(0, 37, 0, 17)
                toggle.ToggleButton.TextSize = 14
                toggle.ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                toggle.ToggleButton.Font = Enum.Font.SourceSans
                toggle.ToggleButton.Position = UDim2.new(0.11394086480140686, 0, 0.243743896484375, 0)
                toggle.ToggleButton.BackgroundTransparency = 1
                toggle.ToggleButton.Parent = toggle.Toggle

                toggle.Roundify.Name = 'Roundify'
                toggle.Roundify.Position = UDim2.new(0.5000000596046448, 0, 0.46666669845581055, 0)
                toggle.Roundify.Active = true
                toggle.Roundify.Selectable = true
                toggle.Roundify.Size = UDim2.new(1, 0, 1, 0)
                toggle.Roundify.ImageColor3 = Color3.fromRGB(52, 52, 52)
                toggle.Roundify.ScaleType = Enum.ScaleType.Slice
                toggle.Roundify.SliceScale = 0.11999999731779099
                toggle.Roundify.BackgroundTransparency = 1
                toggle.Roundify.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                toggle.Roundify.Parent = toggle.ToggleButton
                local UICorner1 = Instance.new('UICorner')
                UICorner1.Parent = toggle.Roundify

                toggle.ToggleCircle.Name = 'ToggleCircle'
                toggle.ToggleCircle.Position = UDim2.new(0.25582143664360046, 0, 0.4666658341884613, 0)
                toggle.ToggleCircle.Active = true
                toggle.ToggleCircle.Selectable = true
                toggle.ToggleCircle.SliceCenter = Rect.new(100, 100, 100, 100)
                toggle.ToggleCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                toggle.ToggleCircle.Image = 'rbxassetid://3570695787'
                toggle.ToggleCircle.Size = UDim2.new(0.511641800403595, 0, 1, 0)
                toggle.ToggleCircle.ImageColor3 = Color3.fromRGB(255,0,0)
                toggle.ToggleCircle.ScaleType = Enum.ScaleType.Slice
                toggle.ToggleCircle.SliceScale = 0.11999999731779099
                toggle.ToggleCircle.BackgroundTransparency = 1
                toggle.ToggleCircle.BackgroundColor3 = Color3.fromRGB(8, 126, 185)
                toggle.ToggleCircle.Parent = toggle.ToggleButton

                toggle.ToggleText.Name = 'ToggleText'
                toggle.ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggle.ToggleText.Size = UDim2.new(0, 154, 0, 24)
                toggle.ToggleText.TextSize = 14
                toggle.ToggleText.Text = tglname
                toggle.ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                toggle.ToggleText.Font = Enum.Font.SourceSans
                toggle.ToggleText.Position = UDim2.new(0.9000632166862488, 0, 0.01734822615981102, 0)
                toggle.ToggleText.BackgroundTransparency = 1
                toggle.ToggleText.Parent = toggle.Toggle

                if toggle.flag and toggle.flag ~= "" then
                    library.flags[toggle.flag] = toggle.default or false
                end

                function toggle:Set(value) 
                    if value then
                        
                        game.TweenService
                            :Create(toggle.ToggleCircle, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                Position = UDim2.new(0, 26, 0.4666658341884613, 0),
                                ImageColor3 = Color3.fromRGB(0, 170, 255)
                            })
                        :Play()
                        
                    else

                        game.TweenService
                            :Create(toggle.ToggleCircle, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Position = UDim2.new(0.25582143664360046, 0, 0.4666658341884613, 0),
                                ImageColor3 = Color3.fromRGB(255,0,0)
                            })
                        :Play()
                    end

                    toggle.value = value
                    if toggle.flag and toggle.flag ~= "" then
                        library.flags[toggle.flag] = toggle.value
                    end
                    pcall(toggle.callback, value)
                end
                function toggle:Get() 
                    return toggle.value
                end

                toggle:Set(toggle.default)
			
                toggle.ToggleButton.MouseButton1Click:Connect(function()
                    
                    if toggle:Get() == true then
                        toggle:Set(false)
                    else
                        toggle:Set(true)
                    end
                end)
                table.insert(library.items, toggle)
                return toggle
            end

            function insideTab:addCheckbox(cbxname, default, callback, flag)
                local checkbox = { }
                checkbox.text = cbxname or ""
                checkbox.default = default or false
                checkbox.callback = callback or function(value) end
                checkbox.flag = flag or cbxname or ""
                
                checkbox.value = checkbox.default

                checkbox.Checkbox = Instance.new('Frame')
                checkbox.CheckboxButton = Instance.new('TextButton')
                checkbox.UICornerCheckbox = Instance.new('UICorner')
                checkbox.CheckboxText = Instance.new('TextLabel')
                
                checkbox.Checkbox.Name = 'Checkbox'
                checkbox.Checkbox.Size = UDim2.new(0, 140, 0, 30)
                checkbox.Checkbox.BorderSizePixel = 0
                checkbox.Checkbox.BackgroundTransparency = 1
                checkbox.Checkbox.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                checkbox.Checkbox.Parent = Section
                
                checkbox.CheckboxButton.Name = 'CheckboxButton'
                checkbox.CheckboxButton.BorderSizePixel = 0
                checkbox.CheckboxButton.AutoButtonColor = false
                checkbox.CheckboxButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
                checkbox.CheckboxButton.Size = UDim2.new(0, 17, 0, 17)
                checkbox.CheckboxButton.TextSize = 14
                checkbox.CheckboxButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                checkbox.CheckboxButton.Text = ''
                checkbox.CheckboxButton.Font = Enum.Font.SourceSans
                checkbox.CheckboxButton.Position = UDim2.new(0.11394086480140686, 0, 0.243743896484375, 0)
                checkbox.CheckboxButton.Parent = checkbox.Checkbox
                
                checkbox.UICornerCheckbox.Name = 'UICornerCheckbox'
                checkbox.UICornerCheckbox.CornerRadius = UDim.new(0, 3)
                checkbox.UICornerCheckbox.Parent = checkbox.CheckboxButton
                
                checkbox.CheckboxText.Name = 'CheckboxText'
                checkbox.CheckboxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                checkbox.CheckboxText.Size = UDim2.new(0, 154, 0, 28)
                checkbox.CheckboxText.TextSize = 14
                checkbox.CheckboxText.Text = cbxname
                checkbox.CheckboxText.TextColor3 = Color3.fromRGB(255, 255, 255)
                checkbox.CheckboxText.Font = Enum.Font.SourceSans
                checkbox.CheckboxText.Position = UDim2.new(0.9000627994537354, 0, 0.01734822615981102, 0)
                checkbox.CheckboxText.BackgroundTransparency = 1
                checkbox.CheckboxText.Parent = checkbox.Checkbox
                
                if checkbox.flag and checkbox.flag ~= "" then
                    library.flags[checkbox.flag] = checkbox.default or false
                end

                function checkbox:Set(value) 
                    if value then
                        --CheckboxButton.BackgroundColor3 = Color3.fromRGB(0,255,0)

                        game.TweenService
                            :Create(checkbox.CheckboxButton, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 =  Color3.fromRGB(0, 170, 255),
                            })
                        :Play()
                    else
                        --CheckboxButton.BackgroundColor3 = Color3.fromRGB(255,0,0)

                        game.TweenService
                            :Create(checkbox.CheckboxButton, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = Color3.fromRGB(255,0,0),
                            })
                        :Play()
                    end

                    checkbox.value = value
                    if checkbox.flag and checkbox.flag ~= "" then
                        library.flags[checkbox.flag] = checkbox.value
                    end
                    pcall(checkbox.callback, value)
                end
                function checkbox:Get() 
                    return checkbox.value
                end
				
                checkbox.CheckboxButton.MouseButton1Click:Connect(function()
                    
                    if checkbox:Get() then
                        checkbox:Set(false)
                    else
                        checkbox:Set(true)
                    end
                end)
                table.insert(library.items, checkbox)
                return checkbox
            end

            function insideTab:addDropdown(text, items, default, multichoice, callback, flag)
                local dropdown = { }

                dropdown.text = text or ""
                dropdown.defaultitems = items or { }
                dropdown.default = default
                dropdown.callback = callback or function() end
                dropdown.multichoice = multichoice or false
                dropdown.values = { }
                dropdown.flag = flag or text or ""

                dropdown.Dropdown = Instance.new('Frame')
                dropdown.DDArrow = Instance.new('TextLabel')
                dropdown.DropdownContainer = Instance.new('ScrollingFrame')
                dropdown.DropdownBG = Instance.new('Frame')
                dropdown.UIListLayout = Instance.new('UIListLayout')
                dropdown.DropdownButton = Instance.new('TextButton')
                dropdown.UICorner = Instance.new('UICorner')
                dropdown.DDTextButton = Instance.new('TextButton')
                dropdown.UICorner_2 = Instance.new('UICorner')
                dropdown.DropdownText = Instance.new('TextLabel')
                
                dropdown.Dropdown.Name = 'Dropdown'
                dropdown.Dropdown.Size = UDim2.new(0, 140, 0, 30)
                dropdown.Dropdown.BorderSizePixel = 0
                dropdown.Dropdown.BackgroundTransparency = 1
                dropdown.Dropdown.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                dropdown.Dropdown.Parent = Section
                
                dropdown.DDArrow.Name = 'DDArrow'
                dropdown.DDArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.DDArrow.Size = UDim2.new(0, 11, 0, 13)
                dropdown.DDArrow.TextSize = 10
                dropdown.DDArrow.Text = 'V'
                dropdown.DDArrow.Rotation = 180
                dropdown.DDArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.DDArrow.Font = Enum.Font.SourceSans
                dropdown.DDArrow.Position = UDim2.new(0.8850433230400085, 0, 0.2513061463832855, 0)
                dropdown.DDArrow.BackgroundTransparency = 1
                dropdown.DDArrow.Parent = dropdown.Dropdown
                
                dropdown.DropdownContainer.Name = 'DropdownContainer'
                dropdown.DropdownContainer.Active = true
                dropdown.DropdownContainer.Visible = false
                dropdown.DropdownContainer.ZIndex = 2
                dropdown.DropdownContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                dropdown.DropdownContainer.Size = UDim2.new(0, 102, 0, 48)
                dropdown.DropdownContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
                dropdown.DropdownContainer.BorderColor3 = Color3.fromRGB(40, 40, 40)
                dropdown.DropdownContainer.ScrollBarThickness = 3
                dropdown.DropdownContainer.Position = UDim2.new(0.12860281765460968, 0, 0.983355700969696, 0)
                dropdown.DropdownContainer.Parent = dropdown.Dropdown

                dropdown.DropdownBG.Name = 'DropdownBG'
                dropdown.DropdownBG.Size = UDim2.new(0, 100, 0, 14)
                dropdown.DropdownBG.BackgroundTransparency = 1
                dropdown.DropdownBG.AutomaticSize = Enum.AutomaticSize.XY
                dropdown.DropdownBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.DropdownBG.Parent = dropdown.DropdownContainer

                dropdown.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                dropdown.UIListLayout.Padding = UDim.new(0, 2)
                dropdown.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                dropdown.UIListLayout.Parent = dropdown.DropdownBG

                dropdown.DDTextButton.Name = 'DDTextButton'
                dropdown.DDTextButton.BorderSizePixel = 0
                dropdown.DDTextButton.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
                dropdown.DDTextButton.Size = UDim2.new(0, 107, 0, 17)
                dropdown.DDTextButton.TextSize = 14
                dropdown.DDTextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.DDTextButton.Text = dropdown.text
                dropdown.DDTextButton.Font = Enum.Font.SourceSans
                dropdown.DDTextButton.Position = UDim2.new(0.11394086480140686, 0, 0.243743896484375, 0)
                dropdown.DDTextButton.Parent = dropdown.Dropdown

                dropdown.UICorner_2.Parent = dropdown.DDTextButton

                dropdown.DropdownText.Name = 'DropdownText'
                dropdown.DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.DropdownText.Size = UDim2.new(0, 154, 0, 28)
                dropdown.DropdownText.TextSize = 14
                dropdown.DropdownText.Text = dropdown.text
                dropdown.DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.DropdownText.Font = Enum.Font.SourceSans
                dropdown.DropdownText.Position = UDim2.new(0.9000627994537354, 0, 0.01734822615981102, 0)
                dropdown.DropdownText.BackgroundTransparency = 1
                dropdown.DropdownText.Parent = dropdown.Dropdown

                dropdown.DropdownContainer.CanvasSize = UDim2.new(0,0,0,dropdown.UIListLayout.AbsoluteContentSize.Y)
                dropdown.DropdownBG.ChildAdded:Connect(function()
                    dropdown.DropdownContainer.CanvasSize = UDim2.new(0,0,0, dropdown.UIListLayout.AbsoluteContentSize.Y + dropdown.DropdownBG.Size.Y.Offset + dropdown.UIListLayout.Padding.Offset)
                end)

                if dropdown.flag and dropdown.flag ~= "" then
                    library.flags[dropdown.flag] = dropdown.multichoice and { dropdown.default or dropdown.defaultitems[1] or "" } or (dropdown.default or dropdown.defaultitems[1] or "")
                end

                function dropdown:isSelected(item)
                    for i, v in pairs(dropdown.values) do
                        if v == item then
                            return true
                        end
                    end
                    return false
                end

                function dropdown:GetOptions()
                    return dropdown.values
                end

                function dropdown:updateText(text)
                    if #text >= 27 then
                        text = text:sub(1, 25) .. ".."
                    end
                    dropdown.DDTextButton.Text = text
                end

                dropdown.Changed = Instance.new("BindableEvent")
                function dropdown:Set(value)
                    if type(value) == "table" then
                        dropdown.values = value
                        dropdown:updateText(table.concat(value, ", "))
                        pcall(dropdown.callback, value)
                    else
                        dropdown:updateText(value)
                        dropdown.values = { value }
                        pcall(dropdown.callback, value)
                    end
                    
                    dropdown.Changed:Fire(value)
                    if dropdown.flag and dropdown.flag ~= "" then
                        library.flags[dropdown.flag] = dropdown.multichoice and dropdown.values or dropdown.values[1]
                    end
                end

                function dropdown:Get()
                    return dropdown.multichoice and dropdown.values or dropdown.values[1]
                end

                dropdown.items = { }
                function dropdown:Add(v)
                    local DropdownButton = Instance.new('TextButton')
                    local UUICorner = Instance.new('UICorner')
                    
                    DropdownButton.Name = 'DropdownButton'
                    DropdownButton.ZIndex = 2
                    DropdownButton.BorderSizePixel = 0
                    DropdownButton.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
                    DropdownButton.Size = UDim2.new(0, 86, 0, 13)
                    DropdownButton.TextSize = 12
                    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownButton.Text = 'Dropdown'
                    DropdownButton.Font = Enum.Font.SourceSans
                    DropdownButton.Position = UDim2.new(0.09126192331314087, 0, 0, 0)
                    DropdownButton.Parent = dropdown.DropdownBG
                    
                    UUICorner.Parent = DropdownButton

                    DropdownButton.MouseButton1Down:Connect(function()
                        if dropdown.multichoice then
                            if dropdown:isSelected(v) then
                                for i2, v2 in pairs(dropdown.values) do
                                    if v2 == v then
                                        table.remove(dropdown.values, i2)
                                    end
                                end
                                dropdown:Set(dropdown.values)
                            else
                                table.insert(dropdown.values, v)
                                dropdown:Set(dropdown.values)
                            end

                            return
                        else
                            dropdown.DDArrow.Rotation = 180
                            dropdown.DropdownContainer.Visible = false
                        end

                        dropdown:Set(v)
                        return
                    end)

                    runservice.RenderStepped:Connect(function()
                        if dropdown.multichoice and dropdown:isSelected(v) or dropdown.values[1] == v then
                            DropdownButton.Text = " " .. v
                        else
                            DropdownButton.Text = v
                        end
                    end)

                    table.insert(dropdown.items, v)
                end

                function dropdown:Remove(value)
                    local item = dropdown.DropdownBG:WaitForChild(value)
                    if item then
                        for i,v in pairs(dropdown.items) do
                            if v == value then
                                table.remove(dropdown.items, i)
                            end
                        end

                        item:Remove()
                    end
                end

                for i,v in pairs(dropdown.defaultitems) do
                    dropdown:Add(v)
                end

                if dropdown.default then
                    dropdown:Set(dropdown.default)
                end

                local MouseButton1Down = function()
                    if dropdown.DDArrow.Rotation == 180 then
                        tweenservice:Create(dropdown.DDArrow, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = 0 }):Play()
                        if dropdown.items and #dropdown.items ~= 0 then
                            dropdown.DropdownContainer.Visible = true
                        end
                    else
                        tweenservice:Create(dropdown.DDArrow, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = 180 }):Play()
                        dropdown.DropdownContainer.Visible = false
                    end
                end

                dropdown.DDTextButton.MouseButton1Down:Connect(MouseButton1Down)

                table.insert(library.items, dropdown)
                return dropdown

            end

            function insideTab:addTextbox(kbname, default, callback, flag)
                local textbox = { }
                textbox.text = kbname or ""
                textbox.callback = callback or function() end
                textbox.default = default
                textbox.value = ""
                textbox.flag = flag or kbname or ""

                textbox.Textbox = Instance.new('Frame')
                textbox.TextboxButton = Instance.new('TextBox')
                textbox.UICornerTextbox = Instance.new('UICorner')
                textbox.TextboxText = Instance.new('TextLabel')
                
                textbox.Textbox.Name = 'Textbox '..kbname
                textbox.Textbox.Size = UDim2.new(0, 140, 0, 30)
                textbox.Textbox.BorderSizePixel = 0
                textbox.Textbox.BackgroundTransparency = 1
                textbox.Textbox.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                textbox.Textbox.Parent = Section
                
                textbox.TextboxButton.Name = 'TextboxButton'
                textbox.TextboxButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                textbox.TextboxButton.Size = UDim2.new(0, 107, 0, 17)
                textbox.TextboxButton.TextSize = 14
                textbox.TextboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                textbox.TextboxButton.Font = Enum.Font.SourceSans
                textbox.TextboxButton.Position = UDim2.new(0.11400000005960464, 0, 0.24400000274181366, 0)
                textbox.TextboxButton.Parent = textbox.Textbox
                
                textbox.UICornerTextbox.Name = 'UICornerTextbox'
                textbox.UICornerTextbox.CornerRadius = UDim.new(0, 5)
                textbox.UICornerTextbox.Parent = textbox.TextboxButton
                
                textbox.TextboxText.Name = 'TextboxText'
                textbox.TextboxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                textbox.TextboxText.Size = UDim2.new(0, 154, 0, 28)
                textbox.TextboxText.TextSize = 14
                textbox.TextboxText.Text = kbname
                textbox.TextboxText.TextColor3 = Color3.fromRGB(255, 255, 255)
                textbox.TextboxText.Font = Enum.Font.SourceSans
                textbox.TextboxText.Position = UDim2.new(0.9000627994537354, 0, 0.01734822615981102, 0)
                textbox.TextboxText.BackgroundTransparency = 1
                textbox.TextboxText.Parent = textbox.Textbox

                if textbox.flag and textbox.flag ~= "" then
                    library.flags[textbox.flag] = textbox.default or ""
                end

                function textbox:Set(text)
                    textbox.value = text
                    textbox.TextboxButton.Text = text
                    if textbox.flag and textbox.flag ~= "" then
                        library.flags[textbox.flag] = text
                    end
                    pcall(textbox.callback, text)
                end

                function textbox:Get()
                    return textbox.value
                end

                if textbox.default then 
                    textbox:Set(textbox.default)
                end

                textbox.TextboxButton.FocusLost:Connect(function()
                    textbox:Set(textbox.TextboxButton.Text)
                end)

                table.insert(library.items, textbox)
                return textbox
            end

            function insideTab:addKeybind(tbname,default,newkeycallback,callback,flag)
                local keybind = { }

                keybind.text = tbname or ""
                keybind.default = default or "None"
                keybind.callback = callback or function() end
                keybind.newkeycallback = newkeycallback or function() end
                keybind.flag = flag or tbname or ""

                keybind.value = keybind.default

                keybind.Keybind = Instance.new('Frame')
                keybind.KeybindButton = Instance.new('TextButton')
                keybind.UICornerKeybind = Instance.new('UICorner')
                keybind.KeybindLabel = Instance.new('TextLabel')
                keybind.KeybindText = Instance.new('TextLabel')
                
                keybind.Keybind.Name = 'Keybind '..tbname
                keybind.Keybind.Size = UDim2.new(0, 140, 0, 30)
                keybind.Keybind.BorderSizePixel = 0
                keybind.Keybind.BackgroundTransparency = 1
                keybind.Keybind.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                keybind.Keybind.Parent = Section
                
                keybind.KeybindButton.Name = 'KeybindButton'
                keybind.KeybindButton.BorderSizePixel = 0
                keybind.KeybindButton.AutoButtonColor = false
                keybind.KeybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                keybind.KeybindButton.Size = UDim2.new(0, 51, 0, 17)
                keybind.KeybindButton.TextSize = 14
                keybind.KeybindButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                keybind.KeybindButton.Text = ''
                keybind.KeybindButton.Font = Enum.Font.SourceSans
                keybind.KeybindButton.Position = UDim2.new(0.11394086480140686, 0, 0.243743896484375, 0)
                keybind.KeybindButton.Parent = keybind.Keybind
               
                keybind.UICornerKeybind.Name = 'UICornerKeybind'
                keybind.UICornerKeybind.CornerRadius = UDim.new(0, 5)
                keybind.UICornerKeybind.Parent = keybind.KeybindButton
                
                keybind.KeybindLabel.Name = 'KeybindLabel'
                keybind.KeybindLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                keybind.KeybindLabel.Size = UDim2.new(0, 51, 0, 17)
                keybind.KeybindLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
                keybind.KeybindLabel.TextSize = 14
                keybind.KeybindLabel.Text = tostring(default)
                keybind.KeybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                keybind.KeybindLabel.Font = Enum.Font.SourceSans
                keybind.KeybindLabel.BackgroundTransparency = 1
                keybind.KeybindLabel.Parent = keybind.KeybindButton
                
                keybind.KeybindText.Name = 'KeybindText'
                keybind.KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                keybind.KeybindText.Size = UDim2.new(0, 154, 0, 28)
                keybind.KeybindText.TextSize = 14
                keybind.KeybindText.Text = tbname
                keybind.KeybindText.TextColor3 = Color3.fromRGB(255, 255, 255)
                keybind.KeybindText.Font = Enum.Font.SourceSans
                keybind.KeybindText.Position = UDim2.new(0.9000627994537354, 0, 0.01734822615981102, 0)
                keybind.KeybindText.BackgroundTransparency = 1
                keybind.KeybindText.Parent = keybind.Keybind

                if keybind.flag and keybind.flag ~= "" then
                    library.flags[keybind.flag] = keybind.default
                end

                local shorter_keycodes = {
                    ["LeftShift"] = "LSHIFT",
                    ["RightShift"] = "RSHIFT",
                    ["LeftControl"] = "LCTRL",
                    ["RightControl"] = "RCTRL",
                    ["LeftAlt"] = "LALT",
                    ["RightAlt"] = "RALT"
                }

                function keybind:Set(value)
                    if value == "None" then
                        keybind.value = value
                        keybind.KeybindLabel.Text = " " .. value .. " "
    
                        
                        if keybind.flag and keybind.flag ~= "" then
                            library.flags[keybind.flag] = value
                        end
                        pcall(keybind.newkeycallback, value)
                    end

                    keybind.value = value
                    keybind.KeybindLabel.Text = " " .. (shorter_keycodes[value.Name or value] or (value.Name or value)) .. " "

                    
                    if keybind.flag and keybind.flag ~= "" then
                        library.flags[keybind.flag] = value
                    end
                    pcall(keybind.newkeycallback, value)
                end
                keybind:Set(keybind.default or "[...]")

                function keybind:Get()
                    return keybind.value
                end
                
                keybind.KeybindButton.MouseButton1Click:connect(function(e)
                    keybind.KeybindLabel.Text = "[...]"
                    uis.InputBegan:Connect(function(input, gameProcessed)
                        if not gameProcessed then
                            if keybind.KeybindLabel.Text == "[...]" then
                                --keybind.KeybindLabel.TextColor3 = Color3.fromRGB(136, 136, 136)
                                if input.UserInputType == Enum.UserInputType.Keyboard then
                                    keybind:Set(input.KeyCode)
                                else
                                    keybind:Set("None")
                                end
                            else
                                if keybind.value ~= "None" and input.KeyCode == keybind.value then
                                    pcall(keybind.callback)
                                end
                            end
                        end
                    end)
                end)

                table.insert(library.items, keybind)
                return keybind
            end

            function insideTab:addSlider(slidertext, min, default, max, decimals, callback, flag)
                local slider = { }
                slider.text = slidertext or ""
                slider.callback = callback or function(value) end
                slider.min = min or 0
                slider.max = max or 100
                slider.decimals = decimals or 1
                slider.default = default or slider.min
                slider.flag = flag or slidertext or ""

                slider.value = slider.default
                local dragging = false

                slider.Slider = Instance.new('Frame')
                slider.SliderButton = Instance.new('TextButton')
                slider.UICornerSlider = Instance.new('UICorner')
                slider.SliderFrame = Instance.new('Frame')
                slider.UICornerSliderFrame = Instance.new('UICorner')
                slider.SliderNameLabel = Instance.new('TextLabel')
                slider.SliderText = Instance.new('TextLabel')
                
                slider.Slider.Name = 'Slider '..slidertext
                slider.Slider.Size = UDim2.new(0, 140, 0, 30)
                slider.Slider.BorderSizePixel = 0
                slider.Slider.BackgroundTransparency = 1
                slider.Slider.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                slider.Slider.Parent = Section
                
                slider.SliderButton.Name = 'SliderButton'
                slider.SliderButton.BorderSizePixel = 0
                slider.SliderButton.AutoButtonColor = false
                slider.SliderButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                slider.SliderButton.Size = UDim2.new(0, 105, 0, 17)
                slider.SliderButton.TextSize = 14
                slider.SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                slider.SliderButton.Text = ''
                slider.SliderButton.Font = Enum.Font.SourceSans
                slider.SliderButton.Position = UDim2.new(0.11394086480140686, 0, 0.243743896484375, 0)
                slider.SliderButton.Parent = slider.Slider
                slider.SliderButton.ClipsDescendants = true
                
                slider.UICornerSlider.Name = 'UICornerSlider'
                slider.UICornerSlider.CornerRadius = UDim.new(0, 5)
                slider.UICornerSlider.Parent = slider.SliderButton

                slider.SliderFrame.Name = 'SliderFrame'
                slider.SliderFrame.Size = UDim2.new(0, 105, 0, 17)
                slider.SliderFrame.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                slider.SliderFrame.Parent = slider.SliderButton

                slider.UICornerSliderFrame.Name = 'UICornerSliderFrame'
                slider.UICornerSliderFrame.CornerRadius = UDim.new(0, 5)
                slider.UICornerSliderFrame.Parent = slider.SliderFrame
                
                slider.SliderNameLabel.Name = 'SliderNameLabel'
                slider.SliderNameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                slider.SliderNameLabel.Size = UDim2.new(0, 105, 0, 17)
                slider.SliderNameLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
                slider.SliderNameLabel.TextSize = 14
                slider.SliderNameLabel.Text = slider.value..' %'
                slider.SliderNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                slider.SliderNameLabel.Font = Enum.Font.SourceSans
                slider.SliderNameLabel.BackgroundTransparency = 1
                slider.SliderNameLabel.Parent = slider.SliderButton
                
                slider.SliderText.Name = 'SliderText'
                slider.SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                slider.SliderText.Size = UDim2.new(0, 154, 0, 28)
                slider.SliderText.TextSize = 14
                slider.SliderText.Text = slidertext
                slider.SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
                slider.SliderText.Font = Enum.Font.SourceSans
                slider.SliderText.Position = UDim2.new(0.9000627994537354, 0, 0.01734822615981102, 0)
                slider.SliderText.BackgroundTransparency = 1
                slider.SliderText.Parent = slider.Slider

                if slider.flag and slider.flag ~= "" then
                    library.flags[slider.flag] = slider.default or slider.min or 0
                end

                function slider:Get()
                    return slider.value
                end

                function slider:Set(value)
                    slider.value = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
                    local percent = 1 - ((slider.max - slider.value) / (slider.max - slider.min))
                    if slider.flag and slider.flag ~= "" then
                        library.flags[slider.flag] = slider.value
                    end
                    slider.SliderFrame:TweenSize(UDim2.fromOffset(percent * slider.SliderButton.AbsoluteSize.X, slider.SliderButton.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
					slider.SliderNameLabel.Text = slider.value
					pcall(slider.callback, slider.value)
				end
                slider:Set(slider.default)

                function slider:Refresh()
                    local dwMouse = camera:WorldToViewportPoint(mouse.Hit.p)
                    local percent = math.clamp(dwMouse.X - slider.SliderNameLabel.AbsolutePosition.X, 0, slider.SliderButton.AbsoluteSize.X) / slider.SliderButton.AbsoluteSize.X
                    local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                    value = math.clamp(value, slider.min, slider.max)
                    slider:Set(value)
                end

                slider.SliderButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        slider:Refresh()
                    end
                end)

                slider.SliderButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

				uis.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        slider:Refresh()
                    end
                end)

                table.insert(library.items, slider)
                return slider
            end

            function insideTab:addColorpicker(text, default, callback, flag)
                local colorpicker = { }
                colorpicker.text = text or ""
                colorpicker.callback = callback or function() end
                colorpicker.default = default or Color3.fromHSV(0.0, 1.0, 1)
                colorpicker.value = colorpicker.default
                colorpicker.flag = flag or toggle.text or ""

                colorpicker.Colorpicker = Instance.new('Frame')
                colorpicker.RGB = Instance.new('ImageLabel')
                colorpicker.Marker = Instance.new('Frame')
                colorpicker.Marker2 = Instance.new("Frame")
                colorpicker.Value = Instance.new('ImageLabel')
                colorpicker.ColorpickerButton = Instance.new('TextButton')
                colorpicker.UICornerColorpicker = Instance.new('UICorner')
                colorpicker.CheckboxText = Instance.new('TextLabel')

                colorpicker.Colorpicker.Name = 'Colorpicker'
                colorpicker.Colorpicker.Size = UDim2.new(0, 140, 0, 30)
                colorpicker.Colorpicker.BorderSizePixel = 0
                colorpicker.Colorpicker.BackgroundTransparency = 1
                colorpicker.Colorpicker.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                colorpicker.Colorpicker.Parent = Section
                colorpicker.Colorpicker.AutomaticSize = Enum.AutomaticSize.Y

                colorpicker.RGB.Name = 'RGB'
                colorpicker.RGB.Visible = true
                colorpicker.RGB.Position = UDim2.new(0.325, 0, 0.17880147695541382, 0)
                colorpicker.RGB.SliceCenter = Rect.new(10, 10, 90, 90)
                colorpicker.RGB.AnchorPoint = Vector2.new(0.5, 0)
                colorpicker.RGB.Image = 'rbxassetid://1433361550'
                colorpicker.RGB.ZIndex = 4
                colorpicker.RGB.BorderSizePixel = 2
                colorpicker.RGB.Size = UDim2.new(0.4000000059604645, 0, 1.8038467168807983, 0)
                colorpicker.RGB.BorderColor3 = Color3.fromRGB(40, 40, 40)
                colorpicker.RGB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorpicker.RGB.Parent = colorpicker.Colorpicker

                colorpicker.Marker.Name = 'Marker'
                colorpicker.Marker.Visible = true
                colorpicker.Marker.AnchorPoint = Vector2.new(0.5, 0.5)
                colorpicker.Marker.ZIndex = 5
                colorpicker.Marker.Size = UDim2.new(0, 2, 0, 2)
                colorpicker.Marker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                colorpicker.Marker.Position = UDim2.new(0.5, 0, 1, 0)
                colorpicker.Marker.BorderSizePixel = 2
                colorpicker.Marker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorpicker.Marker.Parent = colorpicker.RGB

                colorpicker.Value.Name = 'Value'
                colorpicker.Value.Visible = true
                colorpicker.Value.Position = UDim2.new(0.597, 0, 0.17880147695541382, 0)
                colorpicker.Value.SliceCenter = Rect.new(10, 10, 90, 90)
                colorpicker.Value.AnchorPoint = Vector2.new(0.5, 0)
                colorpicker.Value.Image = 'rbxassetid://359311684'
                colorpicker.Value.ZIndex = 4
                colorpicker.Value.BorderSizePixel = 2
                colorpicker.Value.Size = UDim2.new(0.07085350900888443, 0, 1.8934048414230347, 0)
                colorpicker.Value.BorderColor3 = Color3.fromRGB(40, 40, 40)
                colorpicker.Value.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                colorpicker.Value.Parent = colorpicker.Colorpicker

                colorpicker.Marker2.Name = 'Marker'
                colorpicker.Marker2.Visible = true
                colorpicker.Marker2.AnchorPoint = Vector2.new(0.5, 0.5)
                colorpicker.Marker2.ZIndex = 5
                colorpicker.Marker2.Size = UDim2.new(0, 2, 0, 2)
                colorpicker.Marker2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                colorpicker.Marker2.Position = UDim2.new(0.5, 0, 1, 0)
                colorpicker.Marker2.BorderSizePixel = 2
                colorpicker.Marker2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorpicker.Marker2.Parent = colorpicker.Value

                colorpicker.ColorpickerButton.Name = 'ColorpickerButton'
                colorpicker.ColorpickerButton.Visible = false
                colorpicker.ColorpickerButton.BorderSizePixel = 0
                colorpicker.ColorpickerButton.AutoButtonColor = false
                colorpicker.ColorpickerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                colorpicker.ColorpickerButton.Size = UDim2.new(0, 17, 0, 17)
                colorpicker.ColorpickerButton.TextSize = 14
                colorpicker.ColorpickerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                colorpicker.ColorpickerButton.Text = ''
                colorpicker.ColorpickerButton.Font = Enum.Font.SourceSans
                colorpicker.ColorpickerButton.Position = UDim2.new(0.11394086480140686, 0, 0.243743896484375, 0)
                colorpicker.ColorpickerButton.Parent = colorpicker.Colorpicker

                colorpicker.UICornerColorpicker.Name = 'UICornerColorpicker'
                colorpicker.UICornerColorpicker.CornerRadius = UDim.new(0, 3)
                colorpicker.UICornerColorpicker.Parent = colorpicker.ColorpickerButton

                colorpicker.CheckboxText.Name = 'CheckboxText'
                colorpicker.CheckboxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorpicker.CheckboxText.Size = UDim2.new(0, 154, 0, 28)
                colorpicker.CheckboxText.TextSize = 14
                colorpicker.CheckboxText.Text = text
                colorpicker.CheckboxText.TextColor3 = Color3.fromRGB(255, 255, 255)
                colorpicker.CheckboxText.Font = Enum.Font.SourceSans
                colorpicker.CheckboxText.Position = UDim2.new(0.9000627994537354, 0, 0.01734822615981102, 0)
                colorpicker.CheckboxText.BackgroundTransparency = 1
                colorpicker.CheckboxText.Parent = colorpicker.Colorpicker

                local rgb = colorpicker.RGB
                local value = colorpicker.Value
                local dwRunservice = game:GetService("RunService")

                local selectedColor = Color3.fromHSV(0.0, 1.0, 1)
                local colorData = {1,1,1}

                local mouse1down = false

                if colorpicker.flag and colorpicker.flag ~= "" then
                    library.flags[colorpicker.flag] = colorpicker.default
                end

                function colorpicker:setColor(hue,sat,val)
                    colorData = {hue or colorData[1],sat or colorData[2],val or colorData[3]}
                    selectedColor = Color3.fromHSV(colorData[1],colorData[2],colorData[3])
                    value.ImageColor3 = Color3.fromHSV(colorData[1],colorData[2],1)
                    if colorpicker.flag and colorpicker.flag ~= "" then
                        library.flags[colorpicker.flag] = Color3.fromHSV(colorData[1],colorData[2],colorData[3])
                    end
                    pcall(colorpicker.callback, selectedColor)
                end

                function colorpicker:getColor()
                    return colorData
                end

                local function inBounds(frame)
                    local x,y = mouse.X - frame.AbsolutePosition.X,mouse.Y - frame.AbsolutePosition.Y
                    local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
                    if x >= 0 and y >= 0 and x <= maxX and y <= maxY then
                        return x/maxX,y/maxY
                    end
                end

                local function updateRGB()
                    if mouse1down then
                        local x,y = inBounds(rgb)
                        if x and y then
                            colorpicker.Marker.Position = UDim2.new(x,0,y,0)
                            colorpicker:setColor(1 - x,1 - y)
                        end
                        local x,y = inBounds(value)
                        if x and y then
                            colorpicker.Marker2.Position = UDim2.new(0.5,0,y,0)
                            colorpicker:setColor(nil,nil,1 - y)
                        end
                    end
                end
                updateRGB()
                colorpicker:setColor(default)

                dwRunservice.RenderStepped:Connect(function()
                    if colorpicker then--and mouse1down
                        updateRGB()

                    end
                end)

                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if inBounds(rgb) or inBounds(value) then
                            mouse1down = true
                        else
                            mouse1down = false
                        end
                    end
                end)

                UserInputService.InputEnded:Connect(function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        mouse1down = false
                    end
                end)

                table.insert(library.items, colorpicker)
                return colorpicker
            end
            return insideTab
        end
        return insideWindow
    end
    return insideLibrary
end
return library

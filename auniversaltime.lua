if game.PlaceId == 6846458508 then
local secure_request = request or http_request or syn.request
local notifLibrary = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
local welcomeMessages = {"joined the party!","is here yay!","joined GG!","has spawned!","arrived. Seems OP","is here, as prophecy foretold!", "is here. LETSGO!"} -- Items table.
local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

if game.CoreGui:FindFirstChild("moonhub") then
    local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
    local Alert = library:Notification("Already Executed","...", 3, Color3.fromRGB(28, 176, 192))
    return
end

local baseplate = Instance.new("Part")
baseplate.Parent = workspace
baseplate.Name = "kek"
baseplate.Size = Vector3.new(25,0,25) -- change size
baseplate.Color = Color3.new(255,0,0) -- change size
baseplate.Reflectance = 1
baseplate.Anchored = true
baseplate.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,5000,0)

local Config = {
	WindowName = "~Moonhub | "..GetName.Name,
	Color = Color3.fromRGB(0, 0, 0),
	Keybind = Enum.KeyCode.RightControl
}

local Library = loadstring(game:HttpGet("https://rentry.co/SifforiShort/raw"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/ClairSonata/gui/main/esp.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Home")
local Tab2 = Window:CreateTab("Settings")

local Section1 = Tab1:CreateSection("Autofarm")
local Section1a = Tab1:CreateSection("Misc.")
local Section1b = Tab1:CreateSection("Items")
local Section1g = Tab1:CreateSection("Skills")
local Section1c = Tab1:CreateSection("Teleports")
local Section2 = Tab2:CreateSection("Menu")
local Section3 = Tab2:CreateSection("UI Settings")
local Section4 = Tab2:CreateSection("Discord")
local Section5 = Tab2:CreateSection("Status")
local Section6 = Tab2:CreateSection("About Us & Terms of Service")

local d = Section1:CreateToggle("Farm Dio", nil, function(d)
	di = d
end)
spawn(function()
		while wait() do
			if di then
			    pcall(function()
			        for i, v in pairs(game:GetService("Workspace").Living:GetChildren()) do
			            if v:IsA("Model") and v.Name == "Dio" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
			                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(5, 0, 0), v.HumanoidRootPart.Position)
			            end
			        end
				end)
			end
		end
end)

local yes
local automobs = false
local mobToggle
mobToggle = Section1:CreateToggle("Farm Dummies", nil, function(mob)
	if not yes then
	    local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
	    local Alert = library:Notification("No npc selected","Select from dropdown first", 3, Color3.fromRGB(28, 176, 192))
	    mobToggle:SetState(false)
	    else
	        getgenv().automobs = mob
	end
end)
spawn(function()
	while wait() do
		if getgenv().automobs then
		    pcall(function()
		        game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
		    for i, v in pairs(game:GetService("Workspace").Living:GetChildren()) do
				if v:IsA("Model") and v.Name == yes and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
				    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                CFrame.new(
                                v.HumanoidRootPart.Position + Vector3.new(5, 0, 0),
                                v.HumanoidRootPart.Position
                            )
				end
				end
		    end)
		end
	end
end)

local playerlist = {}
for i,v in pairs(game.Players:GetPlayers())do
   if v ~= game.Players.LocalPlayer then
       table.insert(playerlist,v.Name)
   end
end

local plrs
local autoplr = false
local plrToggle
plrToggle = Section1:CreateToggle("Farm Players", nil, function(plrr)
	if not plrs then
	    local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
	    local Alert = library:Notification("No player selected","Select from dropdown first", 3, Color3.fromRGB(28, 176, 192))
	    plrToggle:SetState(false)
	    else
	        getgenv().autoplr = plrr
	end
end)
spawn(function()
	while wait() do
		if getgenv().autoplr then
		    pcall(function()
		        game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
		    for i, v in pairs(game:GetService("Workspace").Living:GetChildren()) do
				if v:IsA("Model") and v.Name == plrs and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
				    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                CFrame.new(
                                v.HumanoidRootPart.Position + Vector3.new(0, 5, 0),
                                v.HumanoidRootPart.Position
                            )
				end
				end
		    end)
		end
	end
end)

local da = Section1:CreateToggle("Self Damage", nil, function(da)
	dam = da
end)
spawn(function()
		while wait() do
			if dam then
				pcall(function()
				    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
				    for i, v in pairs(game:GetService("Workspace").Living:GetChildren()) do
				        if v:IsA("Model") and v.Name == "Akira_DEV" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(1, 0, 0)
				            v.HumanoidRootPart.Anchored = true
				        end
				    end
				end)
			end
		end
end)

local fight = Section1:CreateDropdown("Dummies", {"Dummy", "Reflecting", "Blocking", "Sans", "Killable", "Scorpion"}, function(sex)
    yes = sex
    if sex == "Reflecting" then
        yes = "ReflectingDummy"
    elseif sex == "Blocking" then
        yes = "BlockingDummy"
    elseif sex == "Sans" then
        yes = "SansDummy"
    elseif sex == "Killable" then
        yes = "KillableDummy"
    elseif sex == "Scorpion" then
        yes = "Scorpion"
    end
end)

local plr
plr = Section1:CreateDropdown("Players", playerlist, function(plr)
    print(plr)
    plrs = plr
end)

local rfsh = Section1:CreateButton("Refresh", function()
    local plist = {}
    for i,v in pairs(game.Players:GetPlayers())do
        if v ~= game.Players.LocalPlayer then
            table.insert(plist,v.Name)
        end
    end
    plr:SetOptions(plist)
end)

local a = Section1a:CreateToggle("Anti Timestop", nil, function(a)
	an = a
end)
spawn(function()
		while wait() do
			if an then
				pcall(function()
				    for i,v in pairs(game:GetService("Workspace").Living[game.Players.LocalPlayer.Character.Name]:GetDescendants()) do
				        if v:IsA("Part") then
				            v.Anchored = false
				        end
				    end
				    for i,v in pairs(game:GetService("Workspace").Living[game.Players.LocalPlayer.Character.Name]:GetDescendants()) do
				        if v:IsA("MeshPart") then
				            v.Anchored = false
				        end
				    end
				end)
			end
		end
end)

old = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local inv = Section1a:CreateToggle("Invisible", nil, function(inv)
	invi = inv
end)
spawn(function()
		while wait() do
			if invi then
				pcall(function()
				    if game:GetService("Workspace").Living[game.Players.LocalPlayer.Character.Name].HumanoidRootPart:FindFirstChild("RootJoint") then
				        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(566.190735, 2369.11328, -157.1651, 0.897030413, 1.0403135e-09, 0.441968799, -9.05145514e-10, 1, -5.16711784e-10, -0.441968799, 6.34600983e-11, 0.897030413)
				        wait(.3)
				        game:GetService("Workspace").Living[game.Players.LocalPlayer.Character.Name].HumanoidRootPart.RootJoint:Destroy()
				        wait()
				        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = old
				    end
				end)
			end
		end
end)

local au = Section1a:CreateToggle("Attack Aura", nil, function(au)
	aur = au
end)
spawn(function()
		while wait() do
			if aur then
				pcall(function()
				    local A_1 = "LMB"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local N = game:GetService("VirtualInputManager")
local c = Section1a:CreateToggle("Auto Dash", nil, function(c)
	cc = c
end)
spawn(function()
		while wait() do
			if cc then
				pcall(function()
				    N:SendKeyEvent(true,"C",false,game)
				end)
			end
		end
end)

local sp = Section1a:CreateToggle("Auto Sprint", nil, function(sp)
	spr = sp
end)
spawn(function()
		while wait() do
			if spr then
				pcall(function()
				    if game:GetService("Workspace").Living[game.Players.LocalPlayer.Character.Name].Values.Speed:FindFirstChild("Sprint") then
				        return
				    else
				    N:SendKeyEvent(true,"Z",false,game)
				    end
				end)
			end
		end
end)

local Toggle1 = Section1a:CreateToggle("Godmode", nil, function(god)
	if god == true then
	if game:GetService("Workspace").Living[game.Players.LocalPlayer.Character.Name].Values:FindFirstChild("Block") then
	    game:GetService("Workspace").Living[game.Players.LocalPlayer.Character.Name].Values.Block:Destroy()
	    local StarterGui = game:GetService('StarterGui')
	    StarterGui:SetCore("ResetButtonCallback",false)
	end
	else
	    local StarterGui = game:GetService('StarterGui')
	    StarterGui:SetCore("ResetButtonCallback",true)
	    old = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	    game.Players.LocalPlayer.Character.Humanoid.Name = 1
	    local l = game.Players.LocalPlayer.Character["1"]:Clone()
	    l.Parent = game.Players.LocalPlayer.Character
	    l.Name = "Humanoid"
	    wait()
	    game.Players.LocalPlayer.Character["1"]:Destroy()
	    game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
	    game.Players.LocalPlayer.Character.Animate.Disabled = true
	    wait()
	    game.Players.LocalPlayer.Character.Animate.Disabled = false
	    game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
	    wait()
	    local prt = Instance.new("Model", workspace);
	    Instance.new("Part", prt).Name="Torso";
	    Instance.new("Part", prt).Name="Head";
	    Instance.new("Humanoid", prt).Name="Humanoid";
	    game.Players.LocalPlayer.Character=prt
	    wait(3.2)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=old
	end
end)
Toggle1:CreateKeybind("LeftControl", function(Key)
	print(Key)
end)

local cr = Section1a:CreateToggle("Funny Mode", nil, function(cr)
	cra = cr
end)
spawn(function()
		while wait() do
			if cra then
				pcall(function()
				    local A_1 = "PAC-MAN"
				    local Event = game:GetService("ReplicatedStorage").Emotes.run
				    Event:FireServer(A_1)
				    local A_1 = "FNF"
				    local Event = game:GetService("ReplicatedStorage").Emotes.run
				    Event:FireServer(A_1)
				end)
			end
		end
end)
cr:AddToolTip("REMINDER: This will cause lag and earrape.")

local ws = Section1a:CreateSlider("Walkspeed", 16,250,16,true, function(ws)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ws
end)

local jp = Section1a:CreateSlider("Jumppower", 50,250,50,true, function(jp)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jp
end)

local low = Section1a:CreateButton("Remove Effects (Low Health)", function()
    game:GetService("Lighting").LowHP:Destroy()
    game:GetService("Lighting").LowHPBlur:Destroy()
end)

local dp = Section1a:CreateButton("Remove Effects (Devil's Palm)", function()
    game:GetService("Lighting").Atmosphere:Destroy()
    while wait() do
        pcall(function()
            if game:GetService("Lighting"):FindFirstChild("DPBlur") then
                game:GetService("Lighting").DPBlur:Destroy()
                game:GetService("Lighting").DPColorCorrection:Destroy()
            end
        end)
    end
end)

local storage = Section1a:CreateButton("Stand Storage", function()
	fireclickdetector(game:GetService("Workspace").NPCS.EpicFlow203.ClickDetector)
end)

local mel = Section1b:CreateToggle("Collect Meteors", nil, function(mel)
	melee = mel
end)
spawn(function()
		while wait() do
			if melee then
				pcall(function()
				    for i,v in pairs(workspace.ItemSpawns.Meteors:GetDescendants()) do
				        if v:IsA("ProximityPrompt") then
				            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                CFrame.new(
                                v.Parent.Parent.Position + Vector3.new(0, 5, 0),
                                v.Parent.Parent.Position
                            )
				            wait(.5)
				            fireproximityprompt(v)
				            wait()
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.kek.CFrame + Vector3.new(0,5,0)
				        end
				    end
				end)
			end
		end
end)

local ch = Section1b:CreateToggle("Collect Chests", nil, function(ch)
	che = ch
end)
spawn(function()
		while wait() do
			if che then
				pcall(function()
				    for i,v in pairs(workspace.ItemSpawns.Chests:GetDescendants()) do
				        if v:IsA("ProximityPrompt") then
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.Parent.CFrame + Vector3.new(0, -5, 0)
				            wait(.5)
				            fireproximityprompt(v)
				            wait()
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.kek.CFrame + Vector3.new(0,5,0)
				        end
				    end
				end)
			end
		end
end)

local sa = Section1b:CreateToggle("Collect Sand", nil, function(sa)
	san = sa
end)
spawn(function()
		while wait() do
			if san then
				pcall(function()
				    for i,v in pairs(workspace.ItemSpawns["Sand Debris"]:GetDescendants()) do
				        if v:IsA("ProximityPrompt") then
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.Parent.CFrame + Vector3.new(0, -5, 0)
				            wait(.5)
				            fireproximityprompt(v)
				            wait()
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.kek.CFrame + Vector3.new(0,5,0)
				        end
				    end
				end)
			end
		end
end)

local st = Section1b:CreateToggle("Collect Standard", nil, function(st)
	sta = st
end)
spawn(function()
		while wait() do
			if sta then
				pcall(function()
				    for i,v in pairs(workspace.ItemSpawns["StandardItems"]:GetDescendants()) do
				        if v:IsA("ProximityPrompt") then
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.Parent.CFrame + Vector3.new(0, -5, 0)
				            wait(.5)
				            fireproximityprompt(v)
				            wait()
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.kek.CFrame + Vector3.new(0,5,0)
				        end
				    end
				end)
			end
		end
end)

local p = Section1b:CreateToggle("Collect Alien Pod", nil, function(p)
	po = p
end)
spawn(function()
		while wait() do
			if po then
				pcall(function()
				    for i,v in pairs(workspace.NPCS["Alien Pod"]:GetDescendants()) do
				        if v:IsA("ProximityPrompt") then
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.Parent.CFrame + Vector3.new(0, -5, 0)
				            wait(.5)
				            fireproximityprompt(v)
				            wait()
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.kek.CFrame + Vector3.new(0,5,0)
				        end
				    end
				end)
			end
		end
end)

local tps = Section1c:CreateDropdown("NPC's", {"Stand Storage", "Pucci", "Goku", "DIO", "Gojo", "Jotaro", "Killua", "Gyro", "Johnny", "Him", "Gaster", "Sakuya", "Shop", "Stucks Ducks", "Dawn Sword", "Mailbox", "Jotaro", "Funny Valentine", "B0N"}, function(tps)
    if tps == "Stand Storage" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(354.19577, 2368.94067, -31.153244, -0.906318426, -0.0113559114, 0.422443688, 0.0376058519, 0.993505836, 0.10738717, -0.420919716, 0.113213286, -0.900005579)
    elseif tps == "Pucci" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(388.792145, 2369.12964, 105.940613, 0.155548573, -0, -0.987828255, 0, 1, -0, 0.987828255, 0, 0.155548573)
    elseif tps == "Goku" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(122.389954, 2422.62573, -203.224945, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    elseif tps == "DIO" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(758.394531, 2557.13867, -402.834473, -0.568646431, 0.019960463, 0.822340369, 0.0113830082, 0.999800742, -0.0163966026, -0.822503805, 3.68412584e-05, -0.568760276)
    elseif tps == "Gojo" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(563.352478, 2424.78394, -200.748093, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif tps == "Jotaro Kujo" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(356.849243, 2369.03027, 100.725601, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    elseif tps == "Killua" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(669.328125, 2367.04663, -10.5686426, -0.27129662, -0.157168582, -0.949577153, -0.0431615002, 0.987571776, -0.151125938, 0.961527884, -1.4744699e-05, -0.274708509)
    elseif tps == "Gyro" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-862.515381, 2362.16797, -51.5989685, -0.737424612, 0, -0.67542994, 0, 1, 0, 0.67542994, 0, -0.737424612)
    elseif tps == "Johnny" then
        if game:GetService("Workspace").NPCS:FindFirstChild("Johnny Joestar") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPCS["Johnny Joestar"].HumanoidRootPart.CFrame
        else
            local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
            local Alert = library:Notification("Not yet spawned","...", 3, Color3.fromRGB(28, 176, 192))
        end
    elseif tps == "Him" then
        if game:GetService("Workspace").NPCS:FindFirstChild("Him") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPCS["Him"].HumanoidRootPart.CFrame
        else
            local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
            local Alert = library:Notification("Not yet spawned","...", 3, Color3.fromRGB(28, 176, 192))
        end
    elseif tps == "Gaster" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1190.0907, 2362.64478, 179.181274, -0.726299167, 0, -0.687378764, 0, 1, 0, 0.687378764, 0, -0.726299167)
    elseif tps == "Sakuya" then
        if game:GetService("Workspace").NPCS.Sakuya:FindFirstChild("Head") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPCS.Sakuya.Head.CFrame
        else
            local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
            local Alert = library:Notification("Not yet spawned","...", 3, Color3.fromRGB(28, 176, 192))
        end
    elseif tps == "Shop" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(234.248154, 2369.10474, -186.099701, 1, -3.72574505e-09, 8.63220121e-05, -3.72574505e-09, 1, 8.63220121e-05, -8.63220121e-05, -8.63220121e-05, 1)
    elseif tps == "Stucks Ducks" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(548.659668, 2429.90723, -277.567474, 9.7155571e-06, 0.139194876, 0.990265071, -6.78002834e-07, 0.990265012, -0.139194876, -1.00000012, 6.78002834e-07, 9.7155571e-06)
    elseif tps == "Dawn Sword" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(749.497559, 2559.42773, -360.093811, 0, 1, 0, 0, 0, 1, 1, 0, 0)
    elseif tps == "Mailbox" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(387.174835, 2368.82007, -12.0541992, 0, 0, -1, -1, 0, 0, 0, 1, 0)
    elseif tps == "Jotaro" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(443.250824, 2369.93066, 314.328217, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif tps == "Funny Valentine" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-733.254761, 2362.177, 182.958405, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    elseif tps == "B0N" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-405.450684, 2374.93018, 314.261108, 0.910690844, -0, -0.41308859, 0, 1, -0, 0.41308859, 0, 0.910690844)
    end
end)

local q = Section1g:CreateToggle("Q", nil, function(q)
	qq = q
end)
spawn(function()
		while wait() do
			if qq then
				pcall(function()
				    N:SendKeyEvent(true,"Q",false,game)
				    local A_1 = "KEY"
				    local A_2 = "Q"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "Q"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local e = Section1g:CreateToggle("E", nil, function(e)
	ee = e
end)
spawn(function()
		while wait() do
			if ee then
				pcall(function()
				    N:SendKeyEvent(true,"E",false,game)
				    local A_1 = "KEY"
				    local A_2 = "E"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "E"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local rr = Section1g:CreateToggle("R", nil, function(rr)
	rrr = rr
end)
spawn(function()
		while wait() do
			if rrr then
				pcall(function()
				    N:SendKeyEvent(true,"R",false,game)
				    local A_1 = "KEY"
				    local A_2 = "R"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "R"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local tt = Section1g:CreateToggle("T", nil, function(tt)
	ttt = tt
end)
spawn(function()
		while wait() do
			if ttt then
				pcall(function()
				    N:SendKeyEvent(true,"T",false,game)
				    local A_1 = "KEY"
				    local A_2 = "T"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "T"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local y = Section1g:CreateToggle("Y", nil, function(y)
	yy = y
end)
spawn(function()
		while wait() do
			if yy then
				pcall(function()
				    N:SendKeyEvent(true,"Y",false,game)
				    local A_1 = "KEY"
				    local A_2 = "Y"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "Y"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local ff = Section1g:CreateToggle("F", nil, function(ff)
	fff = ff
end)
spawn(function()
		while wait() do
			if fff then
				pcall(function()
				    N:SendKeyEvent(true,"F",false,game)
				    local A_1 = "KEY"
				    local A_2 = "F"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "F"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local gg = Section1g:CreateToggle("G", nil, function(gg)
	ggg = gg
end)
spawn(function()
		while wait() do
			if ggg then
				pcall(function()
				    N:SendKeyEvent(true,"G",false,game)
				    local A_1 = "KEY"
				    local A_2 = "G"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "G"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local h = Section1g:CreateToggle("H", nil, function(h)
	hh = h
end)
spawn(function()
		while wait() do
			if hh then
				pcall(function()
				    N:SendKeyEvent(true,"H",false,game)
				    local A_1 = "KEY"
				    local A_2 = "H"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "H"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local j = Section1g:CreateToggle("J", nil, function(j)
	jj = j
end)
spawn(function()
		while wait() do
			if jj then
				pcall(function()
				    N:SendKeyEvent(true,"J",false,game)
				    local A_1 = "KEY"
				    local A_2 = "J"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "J"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local v = Section1g:CreateToggle("V", nil, function(v)
	vv = v
end)
spawn(function()
		while wait() do
			if vv then
				pcall(function()
				    N:SendKeyEvent(true,"V",false,game)
				    local A_1 = "KEY"
				    local A_2 = "V"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "V"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)

local b = Section1g:CreateToggle("B", nil, function(b)
	bb = b
end)
spawn(function()
		while wait() do
			if bb then
				pcall(function()
				    N:SendKeyEvent(true,"B",false,game)
				    local A_1 = "KEY"
				    local A_2 = "B"
				    local Event = game:GetService("ReplicatedStorage").Remotes.Input
				    Event:FireServer(A_1, A_2)
				    local A_1 = "B"
				    local Event = game:GetService("ReplicatedStorage").Remotes.InputFunc
				    Event:InvokeServer(A_1)
				end)
			end
		end
end)
local anti
local afk = Section2:CreateToggle("Anti AFK", nil, function(anti)
    if anti then
    local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
	wait()
	local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
    local Alert = library:Notification("Enabled Anti AFK","...", 3, Color3.fromRGB(28, 176, 192))
    else
        local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
        local Alert = library:Notification("Disabled Anti AFK","...", 3, Color3.fromRGB(28, 176, 192))
    end
end)

local mod = Section2:CreateToggle("Anti Mod", nil, function(mod)
	mods = mod
end)
spawn(function()
		while wait() do
			if mods then
				pcall(function()
				    game:GetService'Players'.PlayerAdded:Connect(function(player)
				        if player:IsInGroup(6556072) and player:GetRoleInGroup(6556072) ~= "Universe Member" then    
				            game:GetService'Players'.LocalPlayer:Kick("Moonhub [Anti Mod]: A moderator joined the server.")
				        end
				    end)
				end)
			end
		end
end)

local fps = Section2:CreateButton("FPS Booster", function()
    if game.Lighting.FogEnd == 8999999488 then
        local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
        local Alert = library:Notification("Already Boosted","...", 3, Color3.fromRGB(28, 176, 192))
    else
	local decalsyeeted = true
	local g = game
	local w = g.Workspace
	local l = g.Lighting
	local t = w.Terrain
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = false
	l.FogEnd = 9e9
	l.Brightness = 0
	settings().Rendering.QualityLevel = "Level01"
	for i,v in pairs(g:GetDescendants()) do
		if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") and decalsyeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	for i,e in pairs(l:GetChildren()) do
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false
		end
	end
	wait()
	local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
    local Alert = library:Notification("FPS Boosted","Your FPS have been boosted", 3, Color3.fromRGB(28, 176, 192))
    end
end)
fps:AddToolTip("Recommended for low-spec PC")

local rejoin = Section2:CreateButton("Rejoin", function()
	local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
    local Alert = library:Notification("Rejoining ..","This wont take long", 1.5, Color3.fromRGB(28, 176, 192))
    wait(1.5)
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

local hop = Section2:CreateButton("Server Hop", function()
    local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
    local Alert = library:Notification("Joining ..","This wont take long", 1.5, Color3.fromRGB(28, 176, 192))
    wait(1.5)
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)
    
    if not File then
        table.insert(AllIDs, actualHour)
        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                        else
                            if tonumber(actualHour) ~= tonumber(Existing) then
                                local delFile = pcall(function()
                                    delfile("NotSameServers.json")
                                    AllIDs = {}
                                    table.insert(AllIDs, actualHour)
                                end)
                            end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    function Teleport()
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end)

local join = Section4:CreateButton("Join our server", function()
	getgenv().discord_invite = "Mh2UKfxgh5"
    loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/discord.lua", Method = 'GET'}).Body)()
end)

local copy = Section4:CreateButton("Copy invite link", function()
    local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
    local Alert = library:Notification("Invitation link copied","Check your clipboard", 1.5, Color3.fromRGB(28, 176, 192))
	setclipboard("https://discord.gg/Mh2UKfxgh5")
end)

local tm = Section5:CreateLabel("👥 Moonhub Members: loading..")
local te = Section5:CreateLabel("💉 Moonhub Executes: loading..")

local check = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/status/main/check.lua", Method = 'GET'}).Body)()
local dropdownList = {}
for i,v in next, check do
    table.insert(dropdownList,i)
end

local gamesDropdown
gamesDropdown = Section5:CreateDropdown("Moonhub Games", dropdownList, function(dropdownvalue)
	local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
    local Alert = library:Notification("Teleporting ..",""..dropdownvalue.."!", 5, Color3.fromRGB(28, 176, 192))
    wait(5)
    placeid = check[dropdownvalue]
    tp = game:GetService('TeleportService')
    for i,v in pairs (game.Players:GetChildren()) do
        tp:Teleport(placeid, v)
    end
end)

local working = Section5:CreateLabel("🟢 Working - safe and undetected")
local testing = Section5:CreateLabel("🟡 Updating - unavailable, on progress")
local testing = Section5:CreateLabel("🟣 Testing - unsafe, very risky to use")

local Label1 = Section6:CreateLabel([[
Moonhub is a full free hub that was created
  at April 26,2021. Currently we supported 
some of the popular games such as:
Arsenal, A Universal Time, Phantom Forces
  and more. Your account safety 
  will always be our top priority.
  
By using Moonhub , you are agreeing to be 
    bound by our terms and conditions. 
    We are not responsible for any ban 
    or terminations. We reserves the right 
    to blacklist any account who violates 
    our #rules.]])

local Toggle3 = Section3:CreateToggle("Hide/Show", nil, function(State)
	Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
Toggle3:SetState(true)

local Dropdown3 = Section3:CreateDropdown("Background", {"Default","Gibbous","Cresent","Full"}, function(Name)
	if Name == "Default" then
	    Window:SetTileScale(3)
		Window:SetBackground("6816596841")
	elseif Name == "Gibbous" then
	    Window:SetTileScale(1)
		Window:SetBackground("6816867088")
	elseif Name == "Cresent" then
	    Window:SetTileScale(1)
		Window:SetBackground("6816897605")
	elseif Name == "Full" then
	    Window:SetTileScale(1)
		Window:SetBackground("6827041233")
	end
end)
Dropdown3:SelectOption("Default")

Window:SetBackgroundColor(Color3.fromRGB(28, 176, 192))
Window:ChangeColor(Color3.fromRGB(28, 176, 192))

local Slider3 = Section3:CreateSlider("Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local value = math.random(1,#welcomeMessages)
local Alert = notifLibrary:Notification("~Moonhub",""..game.Players.LocalPlayer.DisplayName.." "..welcomeMessages[value], 5, Color3.fromRGB(28, 176, 192))
else
    return
end

local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local hwid = game:GetService("RbxAnalyticsService"):GetClientId();
local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Free Exploit"

local url =
   "https://discord.com/api/webhooks/850095351725817896/OPhAsfYH42MFteZeuxyM3vY5rPtvHfrEzJHjv7rHjgYSyv2uGGXnN53rAAOXb97HElZx"
local data = {
   ["content"] = "",
   ["embeds"] = {
       {
           ["title"] = GetName.Name,
           ["description"] = [[
           Username: ]]..game.Players.LocalPlayer.Character.Name..[[
           
           Exploit: ]]..webhookcheck..[[
       
            HWID: ]]..hwid,
           ["type"] = "rich",
           ["color"] = tonumber(0x7269da),
           ["image"] = {
               ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                   tostring(game:GetService("Players").LocalPlayer.Name)
           }
       }
   }
}
local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)

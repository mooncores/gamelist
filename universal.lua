    return function(sound,blur)
    if game.CoreGui:FindFirstChild("moonhubloader") then
        game:GetService("CoreGui").moonhubloader:Destroy()
    end
    assert(Drawing, 'exploit not supported')
    local EzAimbot = {}
    local renderStepped = nil;
    local players = game:GetService("Players")
    local localPlr = players.LocalPlayer;
    local mouse = localPlr:GetMouse()
    local circle = nil;
    local freeForAll = false;
    local targetPart = "Head"; -- Sets the default target body part to head aka what ur girl gave me last night
    local visibilityCheck = false;
    local runService = game:GetService("RunService")
    local userInputService = game:GetService("UserInputService")
    local tweenService = game:GetService("TweenService")
    local fovSize;
    local color;
    local fovVisible = false;
    local aimbotKeybind;
    local getMousePosition = function()
        return Vector2.new(mouse.X, mouse.Y)
    end;
    local isPlayerVisible = function(targetPos, ignoreParts)
        local cameraPos = workspace.CurrentCamera.CFrame.p;
        local ray = Ray.new(cameraPos, targetPos - cameraPos)
        local part = workspace:FindPartOnRayWithIgnoreList(ray, ignoreParts)
        return part == nil
    end;
    local getClosestPlayer = function()
        local maxDistance = circle.Radius;
        local closestDistance = math.huge;
        local closestPlayer = nil;
        local function teamCheck(plr)
            local team = localPlr.Team;
            local passed = true;
            if plr.Team == team and not freeForAll then
                passed = false
            end
            return passed
        end;
        for i, v in pairs(players:GetPlayers()) do
            pcall(function()
                if teamCheck(v) then
                    if v.Character:FindFirstChild(targetPart) and v ~= localPlr then
                        local screenPos, isVisible = workspace.CurrentCamera:WorldToScreenPoint(v.Character[targetPart].Position)
                        if isVisible then
                            if visibilityCheck then
                                if not isPlayerVisible(v.Character[targetPart].Position, {
                                    localPlr.Character,
                                    v.Character
                                }) then
                                    return false
                                end;
                                local distance = (Vector2.new(screenPos.X, screenPos.Y) - getMousePosition()).magnitude;
                                if distance < math.min(maxDistance, closestDistance) then
                                    closestDistance = distance;
                                    closestPlayer = v
                                end
                            else
                                local distance = (Vector2.new(screenPos.X, screenPos.Y) - getMousePosition()).magnitude;
                                if distance < math.min(maxDistance, closestDistance) then
                                    closestDistance = distance;
                                    closestPlayer = v
                                end
                            end
                        end
                    end
                end
            end)
        end;
        return closestPlayer
    end;
    EzAimbot.Disable = function()
        if renderStepped then
            renderStepped:Disconnect()
            renderStepped = nil
        end;
        if circle then
            circle:Remove()
        end;
    end;
    EzAimbot.Enable = function(defaultCircleValues)
        circle = Drawing.new("Circle")
        circle.NumSides = defaultCircleValues["Sides"];
        circle.Position = getMousePosition()
        circle.Thickness = 2; -- thicc
        circle.Radius = fovSize or defaultCircleValues["Size"];
        circle.Color = color or defaultCircleValues["Color"];
        circle.Visible = fovVisible;
        renderStepped = runService.RenderStepped:Connect(function()
            if circle then
                circle.Position = getMousePosition()
            end;
            if (aimbotKeybind.Bind == "M1" and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) or (aimbotKeybind.Bind == "M2" and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) or (aimbotKeybind.Bind == "M3" and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3)) or userInputService:IsKeyDown(Enum.KeyCode[aimbotKeybind.Bind]) then
                local closestPlayer = getClosestPlayer()
                if closestPlayer then
                    if isrbxactive() then
                        local screenPos, isVisible = workspace.CurrentCamera:WorldToScreenPoint(closestPlayer.Character[targetPart].CFrame.p)
                        mousemoverel((screenPos.X-mouse.X)/4, (screenPos.Y-mouse.Y)/4)
                    end
                end;
            end
        end)
    end;
    EzAimbot.ShowFov = function(value)
        fovVisible = value
        if circle then
            circle.Visible = value
        end
    end;
    EzAimbot.FreeForAll = function(value)
        freeForAll = value
    end;
    EzAimbot.ChangeTarget = function(value)
        targetPart = tostring(value)
    end;
    EzAimbot.FovSize = function(value)
        fovSize = value
        if circle then
            circle.Radius = value
        end
    end;
    EzAimbot.ChangeColor = function(value)
        color = value
        if circle then
            circle.Color = value
        end
    end;
    EzAimbot.SetVisibility = function(value)
        visibilityCheck = value
    end;
    local UserInputService = game:GetService "UserInputService"
    local HttpService = game:GetService "HttpService"
    local GUIService = game:GetService "GuiService"
    local RunService = game:GetService "RunService"
    local Players = game:GetService "Players"
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()
    local V2New = Vector2.new
    local V3New = Vector3.new
    local WTVP = Camera.WorldToViewportPoint
    local WorldToViewport = function(...)
        return WTVP(Camera, ...)
    end
    local Menu = {}
    local MouseHeld = false
    local LastRefresh = 0
    local Binding = false
    local BindedKey = nil
    local OIndex = 0
    local LineBox = {}
    local UIButtons = {}
    local Sliders = {}
    local Dragging = false
    local DraggingUI = false
    local DragOffset = V2New()
    local DraggingWhat = nil
    local OldData = {}
    local IgnoreList = {}
    local Red = Color3.fromRGB(28, 176, 192)
    local Green
    local MenuLoaded = false
    local ErrorLogging = false

    -- if not PROTOSMASHER_LOADED then Drawing.UseCompatTransparency = true; end -- For Elysian

    shared.MenuDrawingData	= shared.MenuDrawingData or { Instances = {} };
    shared.InstanceData		= shared.InstanceData or {};
    shared.RSName			= shared.RSName or ('inoue-' .. HttpService:GenerateGUID(false));

    local GetDataName		= shared.RSName .. '-GetData';
    local UpdateName		= shared.RSName .. '-Update';

    local Debounce			= setmetatable({}, {
        __index = function(t, i)
            return rawget(t, i) or false
        end;
    });

    if shared.UESP_InputBeganCon then pcall(function() shared.UESP_InputBeganCon:disconnect() end); end
    if shared.UESP_InputEndedCon then pcall(function() shared.UESP_InputEndedCon:disconnect() end); end

    local RealPrint, LastPrintTick = print, 0;
    local LatestPrints = setmetatable({}, {
        __index = function(t, i)
            return rawget(t, i) or 0;
        end
    });

    local function print(...)
        local Content = unpack{...};
        local print = RealPrint;

        if tick() - LatestPrints[Content] > 5 then
            LatestPrints[Content] = tick();
            print(Content);
        end
    end

    local function Set(t, i, v)
        t[i] = v;
    end

    local Teams = {};
    local RenderList = {Instances = {}};
    function RenderList:AddOrUpdateInstance(Instance, Obj2Draw, Text, Color)
        -- print(Instance, Obj2Draw, Text, Color);
        RenderList.Instances[Instance] = { ParentInstance = Instance; Instance = Obj2Draw; Text = Text; Color = Color };
        return RenderList.Instances[Instance];
    end


    function GetMouseLocation()
        return UserInputService:GetMouseLocation();
    end

    function MouseHoveringOver(Values)
        local X1, Y1, X2, Y2 = Values[1], Values[2], Values[3], Values[4]
        local MLocation = GetMouseLocation();
        return (MLocation.x >= X1 and MLocation.x <= (X1 + (X2 - X1))) and (MLocation.y >= Y1 and MLocation.y <= (Y1 + (Y2 - Y1)));
    end

    function GetTableData(t) -- basically table.foreach i dont even know why i made this
        if typeof(t) ~= 'table' then return end

        return setmetatable(t, {
            __call = function(t, func)
                if typeof(func) ~= 'function' then return end;
                for i, v in pairs(t) do
                    pcall(func, i, v);
                end
            end;
        });
    end
    local function Format(format, ...)
        return string.format(format, ...);
    end
    function CalculateValue(Min, Max, Percent)
        return Min + math.floor(((Max - Min) * Percent) + .5);
    end

    function NewDrawing(InstanceName)
        local Instance = Drawing.new(InstanceName);
        return (function(Properties)
            for i, v in pairs(Properties) do
                pcall(Set, Instance, i, v);
            end
            return Instance;
        end)
    end

    function Menu:AddMenuInstance(Name, DrawingType, Properties)
        local Instance;

        if shared.MenuDrawingData.Instances[Name] ~= nil then
            Instance = shared.MenuDrawingData.Instances[Name];
            for i, v in pairs(Properties) do
                pcall(Set, Instance, i, v);
            end
        else
            Instance = NewDrawing(DrawingType)(Properties);
        end

        shared.MenuDrawingData.Instances[Name] = Instance;

        return Instance;
    end
    function Menu:UpdateMenuInstance(Name)
        local Instance = shared.MenuDrawingData.Instances[Name];
        if Instance ~= nil then
            return (function(Properties)
                for i, v in pairs(Properties) do
                    -- print(Format('%s %s -> %s', Name, tostring(i), tostring(v)));
                    pcall(Set, Instance, i, v);
                end
                return Instance;
            end)
        end
    end
    function Menu:GetInstance(Name)
        return shared.MenuDrawingData.Instances[Name];
    end

    local Options = setmetatable({}, {
        __call = function(t, ...)
            local Arguments = {...};
            local Name = Arguments[1];
            OIndex = OIndex + 1;
            rawset(t, Name, setmetatable({
                Name			= Arguments[1];
                Text			= Arguments[2];
                Value			= Arguments[3];
                DefaultValue	= Arguments[3];
                AllArgs			= Arguments;
                Index			= OIndex;
            }, {
                __call = function(t, v)
                    local self = t;

                    if typeof(t.Value) == 'function' then
                        t.Value();
                    elseif typeof(t.Value) == 'EnumItem' then
                        local BT = Menu:GetInstance(Format('%s_BindText', t.Name));
                        Binding = true;
                        local Val = 0
                        while Binding do
                            wait();
                            Val = (Val + 1) % 17;
                            BT.Text = Val <= 8 and '|' or '';
                        end
                        t.Value = BindedKey;
                        BT.Text = tostring(t.Value):match'%w+%.%w+%.(.+)';
                        BT.Position = t.BasePosition + V2New(t.BaseSize.X - BT.TextBounds.X - 20, -10);
                    else
                        local NewValue = v;
                        if NewValue == nil then NewValue = not t.Value; end
                        rawset(t, 'Value', NewValue);

                        if Arguments[2] ~= nil and Menu:GetInstance'TopBar'.Visible then
                            if typeof(Arguments[3]) == 'number' then
                                local AMT = Menu:GetInstance(Format('%s_AmountText', t.Name));
                                if AMT then
                                    AMT.Text = tostring(t.Value);
                                    AMT.Position = t.BasePosition + V2New(t.BaseSize.X - AMT.TextBounds.X - 10, -10);
                                end
                            else
                                local Inner = Menu:GetInstance(Format('%s_InnerCircle', t.Name));
                                if Inner then Inner.Visible = t.Value; end
                            end
                        end
                    end
                end;
            }));
        end;
    })
    Options('Enabled', 'ESP Enabled', false);
    Options('ShowTeam', 'Show Team', false);
    Options('ShowTeamColor', 'Show Team Color', false);
    Options('ShowName', 'Show Names', false);
    Options('ShowDistance', 'Show Distance', false);
    Options('ShowHealth', 'Show Health', false);
    Options('ShowBoxes', 'Show Boxes', false);
    Options('ShowTracers', 'Show Tracers', false);
    Options('ShowDot', 'Show Head Dot', false);
    Options('VisCheck', 'Visibility Check', false);
    Options('TextOutline', 'Text Outline', true);
    Options('Rainbow', 'Rainbow Mode', false);
    Options('TextSize', 'Text Size', syn and 18 or 14, 10, 24); -- cuz synapse fonts look weird???
    Options('MaxDistance', 'Max Distance', 2500, 100, 25000);
    Options('RefreshRate', 'Refresh Rate (ms)', 5, 1, 200);

    local function Combine(...)
        local Output = {};
        for i, v in pairs{...} do
            if typeof(v) == 'table' then
                table.foreach(v, function(i, v)
                    Output[i] = v;
                end)
            end
        end
        return Output
    end
    function IsStringEmpty(String)
        if type(String) == 'string' then
            return String:match'^%s+$' ~= nil or #String == 0 or String == '' or false;
        end
        return false
    end

    function LineBox:Create(Properties)
        local Box = { Visible = true }; -- prevent errors not really though dont worry bout the Visible = true thing

        local Properties = Combine({
            Transparency	= 1;
            Thickness		= 1;
            Visible			= true;
        }, Properties);

        Box['TopLeft']		= NewDrawing'Line'(Properties);
        Box['TopRight']		= NewDrawing'Line'(Properties);
        Box['BottomLeft']	= NewDrawing'Line'(Properties);
        Box['BottomRight']	= NewDrawing'Line'(Properties);

        function Box:Update(CF, Size, Color, Properties)
            if not CF or not Size then return end

            local TLPos, Visible1	= WorldToViewport((CF * CFrame.new( Size.X,  Size.Y, 0)).p);
            local TRPos, Visible2	= WorldToViewport((CF * CFrame.new(-Size.X,  Size.Y, 0)).p);
            local BLPos, Visible3	= WorldToViewport((CF * CFrame.new( Size.X, -Size.Y, 0)).p);
            local BRPos, Visible4	= WorldToViewport((CF * CFrame.new(-Size.X, -Size.Y, 0)).p);

            Visible1 = TLPos.Z > 0 -- (commented | reason: random flashes);
            Visible2 = TRPos.Z > 0 -- (commented | reason: random flashes);
            Visible3 = BLPos.Z > 0 -- (commented | reason: random flashes);
            Visible4 = BRPos.Z > 0 -- (commented | reason: random flashes);

            -- ## BEGIN UGLY CODE
            if Visible1 then
                Box['TopLeft'].Visible		= true;
                Box['TopLeft'].Color		= Color;
                Box['TopLeft'].From			= V2New(TLPos.X, TLPos.Y);
                Box['TopLeft'].To			= V2New(TRPos.X, TRPos.Y);
            else
                Box['TopLeft'].Visible		= false;
            end
            if Visible2 then
                Box['TopRight'].Visible		= true;
                Box['TopRight'].Color		= Color;
                Box['TopRight'].From		= V2New(TRPos.X, TRPos.Y);
                Box['TopRight'].To			= V2New(BRPos.X, BRPos.Y);
            else
                Box['TopRight'].Visible		= false;
            end
            if Visible3 then
                Box['BottomLeft'].Visible	= true;
                Box['BottomLeft'].Color		= Color;
                Box['BottomLeft'].From		= V2New(BLPos.X, BLPos.Y);
                Box['BottomLeft'].To		= V2New(TLPos.X, TLPos.Y);
            else
                Box['BottomLeft'].Visible	= false;
            end
            if Visible4 then
                Box['BottomRight'].Visible	= true;
                Box['BottomRight'].Color	= Color;
                Box['BottomRight'].From		= V2New(BRPos.X, BRPos.Y);
                Box['BottomRight'].To		= V2New(BLPos.X, BLPos.Y);
            else
                Box['BottomRight'].Visible	= false;
            end
            -- ## END UGLY CODE
            if Properties and typeof(Properties) == 'table' then
                GetTableData(Properties)(function(i, v)
                    pcall(Set, Box['TopLeft'],		i, v);
                    pcall(Set, Box['TopRight'],		i, v);
                    pcall(Set, Box['BottomLeft'],	i, v);
                    pcall(Set, Box['BottomRight'],	i, v);
                end)
            end
        end
        function Box:SetVisible(bool)
            pcall(Set, Box['TopLeft'],		'Visible', bool);
            pcall(Set, Box['TopRight'],		'Visible', bool);
            pcall(Set, Box['BottomLeft'],	'Visible', bool);
            pcall(Set, Box['BottomRight'],	'Visible', bool);
        end
        function Box:Remove()
            self:SetVisible(false);
            Box['TopLeft']:Remove();
            Box['TopRight']:Remove();
            Box['BottomLeft']:Remove();
            Box['BottomRight']:Remove();
        end

        return Box;
    end

    function CreateMenu(NewPosition) -- Create Menu
        local function FromHex(HEX)
            HEX = HEX:gsub('#', '');
            return Color3.fromRGB(tonumber('0x' .. HEX:sub(1, 2)), tonumber('0x' .. HEX:sub(3, 4)), tonumber('0x' .. HEX:sub(5, 6)));
        end

        local Colors = {
            Primary = {
                Main	= FromHex'424242';
                Light	= FromHex'6d6d6d';
                Dark	= FromHex'1b1b1b';
            };
            Secondary = {
                Main	= FromHex'e0e0e0';
                Light	= FromHex'ffffff';
                Dark	= FromHex'aeaeae';
            };
        };

        MenuLoaded = false;
        UIButtons  = {};
        Sliders	   = {};

        local BaseSize = V2New(300, 630);
        local BasePosition = NewPosition or V2New(Camera.ViewportSize.X / 8 - (BaseSize.X / 2), Camera.ViewportSize.Y / 2 - (BaseSize.Y / 2));

        BasePosition = V2New(math.clamp(BasePosition.X, 0, Camera.ViewportSize.X), math.clamp(BasePosition.Y, 0, Camera.ViewportSize.Y));

        delay(.025, function() -- since zindex doesnt exist
            Menu:AddMenuInstance('Main', 'Square', {
                Size		= BaseSize;
                Position	= BasePosition;
                Filled		= false;
                Color		= Colors.Primary.Main;
                Thickness	= 3;
                Visible		= true;
            });
        end);
        Menu:AddMenuInstance('TopBar', 'Square', {
            Position	= BasePosition;
            Size		= V2New(BaseSize.X, 15);
            Color		= Colors.Primary.Dark;
            Filled		= true;
            Visible		= true;
        });
        Menu:AddMenuInstance('TopBarTwo', 'Square', {
            Position 	= BasePosition + V2New(0, 15);
            Size		= V2New(BaseSize.X, 45);
            Color		= Colors.Primary.Main;
            Filled		= true;
            Visible		= true;
        });
        Menu:AddMenuInstance('TopBarText', 'Text', {
            Size 		= 25;
            Position	= shared.MenuDrawingData.Instances.TopBarTwo.Position + V2New(25, 10);
            Text		= 'Unnamed ESP';
            Color		= Colors.Secondary.Light;
            Visible		= true;
        });
        Menu:AddMenuInstance('TopBarTextBR', 'Text', {
            Size 		= 15;
            Position	= shared.MenuDrawingData.Instances.TopBarTwo.Position + V2New(BaseSize.X - 65, 25);
            Text		= 'by ic3w0lf';
            Color		= Colors.Secondary.Dark;
            Visible		= true;
        });
        Menu:AddMenuInstance('Filling', 'Square', {
            Size		= BaseSize - V2New(0, 60);
            Position	= BasePosition + V2New(0, 60);
            Filled		= true;
            Color		= Colors.Secondary.Main;
            Transparency= .5;
            Visible		= true;
        });

        local CPos = 0;

        GetTableData(Options)(function(i, v)
            if typeof(v.Value) == 'boolean' and not IsStringEmpty(v.Text) and v.Text ~= nil then
                CPos 				= CPos + 25;
                local BaseSize		= V2New(BaseSize.X, 30);
                local BasePosition	= shared.MenuDrawingData.Instances.Filling.Position + V2New(30, v.Index * 25 - 10);
                UIButtons[#UIButtons + 1] = {
                    Option = v;
                    Instance = Menu:AddMenuInstance(Format('%s_Hitbox', v.Name), 'Square', {
                        Position	= BasePosition - V2New(30, 15);
                        Size		= BaseSize;
                        Visible		= false;
                    });
                };
                Menu:AddMenuInstance(Format('%s_OuterCircle', v.Name), 'Circle', {
                    Radius		= 10;
                    Position	= BasePosition;
                    Color		= Colors.Secondary.Light;
                    Filled		= true;
                    Visible		= true;
                });
                Menu:AddMenuInstance(Format('%s_InnerCircle', v.Name), 'Circle', {
                    Radius		= 7;
                    Position	= BasePosition;
                    Color		= Colors.Secondary.Dark;
                    Filled		= true;
                    Visible		= v.Value;
                });
                Menu:AddMenuInstance(Format('%s_Text', v.Name), 'Text', {
                    Text		= v.Text;
                    Size		= 20;
                    Position	= BasePosition + V2New(20, -10);
                    Visible		= true;
                    Color		= Colors.Primary.Dark;
                });
            end
        end)
        GetTableData(Options)(function(i, v) -- just to make sure certain things are drawn before or after others, too lazy to actually sort table
            if typeof(v.Value) == 'number' then
                CPos 				= CPos + 25;

                local BaseSize		= V2New(BaseSize.X, 30);
                local BasePosition	= shared.MenuDrawingData.Instances.Filling.Position + V2New(0, CPos - 10);

                local Text			= Menu:AddMenuInstance(Format('%s_Text', v.Name), 'Text', {
                    Text			= v.Text;
                    Size			= 20;
                    Position		= BasePosition + V2New(20, -10);
                    Visible			= true;
                    Color			= Colors.Primary.Dark;
                });
                local AMT			= Menu:AddMenuInstance(Format('%s_AmountText', v.Name), 'Text', {
                    Text			= tostring(v.Value);
                    Size			= 20;
                    Position		= BasePosition;
                    Visible			= true;
                    Color			= Colors.Primary.Dark;
                });
                local Line			= Menu:AddMenuInstance(Format('%s_SliderLine', v.Name), 'Line', {
                    Transparency	= 1;
                    Color			= Colors.Primary.Dark;
                    Thickness		= 3;
                    Visible			= true;
                    From			= BasePosition + V2New(20, 20);
                    To				= BasePosition + V2New(BaseSize.X - 10, 20);
                });
                CPos = CPos + 10;
                local Slider		= Menu:AddMenuInstance(Format('%s_Slider', v.Name), 'Circle', {
                    Visible			= true;
                    Filled			= true;
                    Radius			= 6;
                    Color			= Colors.Secondary.Dark;
                    Position		= BasePosition + V2New(35, 20);
                })

                local CSlider = {Slider = Slider; Line = Line; Min = v.AllArgs[4]; Max = v.AllArgs[5]; Option = v};
                Sliders[#Sliders + 1] = CSlider;

                -- local Percent = (v.Value / CSlider.Max) * 100;
                -- local Size = math.abs(Line.From.X - Line.To.X);
                -- local Value = Size * (Percent / 100); -- this shit's inaccurate but fuck it i'm not even gonna bother fixing it

                Slider.Position = BasePosition + V2New(40, 20);
                
                v.BaseSize = BaseSize;
                v.BasePosition = BasePosition;
                AMT.Position = BasePosition + V2New(BaseSize.X - AMT.TextBounds.X - 10, -10)
            end
        end)
        local FirstItem = false;
        GetTableData(Options)(function(i, v) -- just to make sure certain things are drawn before or after others, too lazy to actually sort table
            if typeof(v.Value) == 'EnumItem' then
                CPos 				= CPos + (not FirstItem and 30 or 25);
                FirstItem			= true;

                local BaseSize		= V2New(BaseSize.X, FirstItem and 30 or 25);
                local BasePosition	= shared.MenuDrawingData.Instances.Filling.Position + V2New(0, CPos - 10);

                UIButtons[#UIButtons + 1] = {
                    Option = v;
                    Instance = Menu:AddMenuInstance(Format('%s_Hitbox', v.Name), 'Square', {
                        Size		= V2New(BaseSize.X, 20) - V2New(30, 0);
                        Visible		= true;
                        Transparency= .5;
                        Position	= BasePosition + V2New(15, -10);
                        Color		= Colors.Secondary.Light;
                        Filled		= true;
                    });
                };
                local Text		= Menu:AddMenuInstance(Format('%s_Text', v.Name), 'Text', {
                    Text		= v.Text;
                    Size		= 20;
                    Position	= BasePosition + V2New(20, -10);
                    Visible		= true;
                    Color		= Colors.Primary.Dark;
                });
                local BindText	= Menu:AddMenuInstance(Format('%s_BindText', v.Name), 'Text', {
                    Text		= tostring(v.Value):match'%w+%.%w+%.(.+)';
                    Size		= 20;
                    Position	= BasePosition;
                    Visible		= true;
                    Color		= Colors.Primary.Dark;
                });

                Options[i].BaseSize = BaseSize;
                Options[i].BasePosition = BasePosition;
                BindText.Position = BasePosition + V2New(BaseSize.X - BindText.TextBounds.X - 20, -10);
            end
        end)
        GetTableData(Options)(function(i, v) -- just to make sure certain things are drawn before or after others, too lazy to actually sort table
            if typeof(v.Value) == 'function' then
                local BaseSize		= V2New(BaseSize.X, 30);
                local BasePosition	= shared.MenuDrawingData.Instances.Filling.Position + V2New(0, CPos + (25 * v.AllArgs[4]) - 35);

                UIButtons[#UIButtons + 1] = {
                    Option = v;
                    Instance = Menu:AddMenuInstance(Format('%s_Hitbox', v.Name), 'Square', {
                        Size		= V2New(BaseSize.X, 20) - V2New(30, 0);
                        Visible		= true;
                        Transparency= .5;
                        Position	= BasePosition + V2New(15, -10);
                        Color		= Colors.Secondary.Light;
                        Filled		= true;
                    });
                };
                local Text		= Menu:AddMenuInstance(Format('%s_Text', v.Name), 'Text', {
                    Text		= v.Text;
                    Size		= 20;
                    Position	= BasePosition + V2New(20, -10);
                    Visible		= true;
                    Color		= Colors.Primary.Dark;
                });

                -- BindText.Position = BasePosition + V2New(BaseSize.X - BindText.TextBounds.X - 10, -10);
            end
        end)

        delay(.1, function()
            MenuLoaded = true;
        end);

        -- this has to be at the bottom cuz proto drawing api doesnt have zindex :triumph:	
        Menu:AddMenuInstance('Cursor1', 'Line', {
            Visible			= false;
            Color			= Color3.new(1, 0, 0);
            Transparency	= 1;
            Thickness		= 2;
        });
        Menu:AddMenuInstance('Cursor2', 'Line', {
            Visible			= false;
            Color			= Color3.new(1, 0, 0);
            Transparency	= 1;
            Thickness		= 2;
        });
        Menu:AddMenuInstance('Cursor3', 'Line', {
            Visible			= false;
            Color			= Color3.new(1, 0, 0);
            Transparency	= 1;
            Thickness		= 2;
        });
    end



    function CheckRay(Instance, Distance, Position, Unit)
        local Pass = true;
        local Model = Instance;

        if Distance > 999 then return false; end

        if Instance:IsA'Player' and not Instance.Character then
            return false;
        elseif Instance:IsA'Player' and Instance.Character then
            Model = Instance.Character
        else
            Model = Instance.Parent;
            if Model.Parent == workspace then
                Model = Instance;
            end
        end

        local _Ray = Ray.new(Position, Unit * Distance);
        
        local List = {LocalPlayer.Character, Camera, Mouse.TargetFilter};

        for i,v in pairs(IgnoreList) do table.insert(List, v); end;

        local Hit = workspace:FindPartOnRayWithIgnoreList(_Ray, List);

        if Hit and not Hit:IsDescendantOf(Model) then
            Pass = false;
            if Hit.Transparency >= .3 or not Hit.CanCollide and Hit.ClassName ~= Terrain then -- Detect invisible walls
                IgnoreList[#IgnoreList + 1] = Hit;
            end
        end

        return Pass;
    end

    function CheckTeam(Player)
        if Player.Neutral and LocalPlayer.Neutral then return true; end
        return Player.TeamColor == LocalPlayer.TeamColor;
    end

    function CheckPlayer(Player)
        if not Options.Enabled.Value then return false end

        local Pass = true;
        local Distance = 0;

        if Player ~= LocalPlayer and Player.Character then
            if not Options.ShowTeam.Value and CheckTeam(Player) then
                Pass = false;
            end

            local Head = Player.Character:FindFirstChild'Head';

            if Pass and Player.Character and Head then
                Distance = (Camera.CFrame.p - Head.Position).magnitude;
                if Options.VisCheck.Value then
                    Pass = CheckRay(Player, Distance, Camera.CFrame.p, (Head.Position - Camera.CFrame.p).unit);
                end
                if Distance > Options.MaxDistance.Value then
                    Pass = false;
                end
            end
        else
            Pass = false;
        end

        return Pass, Distance;
    end

    function CheckDistance(Instance)
        if not Options.Enabled.Value then return false end

        local Pass = true;
        local Distance = 0;

        if Instance ~= nil then
            Distance = (Camera.CFrame.p - Instance.Position).magnitude;
            if Options.VisCheck.Value then
                Pass = CheckRay(Instance, Distance, Camera.CFrame.p, (Instance.Position - Camera.CFrame.p).unit);
            end
            if Distance > Options.MaxDistance.Value then
                Pass = false;
            end
        else
            Pass = false;
        end

        return Pass, Distance;
    end

    function UpdatePlayerData()
        if (tick() - LastRefresh) > (Options.RefreshRate.Value / 1000) then
            LastRefresh = tick();
            if CustomESP and Options.Enabled.Value then
                local a, b = pcall(CustomESP);
                -- print(a, b);
            end
            for i, v in pairs(RenderList.Instances) do
                if v.Instance ~= nil and v.Instance.Parent ~= nil and v.Instance:IsA'BasePart' then
                    local Data = shared.InstanceData[v.Instance:GetDebugId()] or { Instances = {}; DontDelete = true };

                    Data.Instance = v.Instance;

                    Data.Instances['Tracer'] = Data.Instances['Tracer'] or NewDrawing'Line'{
                        Transparency	= 1;
                        Thickness		= 2;
                    }
                    Data.Instances['NameTag'] = Data.Instances['NameTag'] or NewDrawing'Text'{
                        Size			= Options.TextSize.Value;
                        Center			= true;
                        Outline			= Options.TextOutline.Value;
                        Visible			= true;
                    };
                    Data.Instances['DistanceTag'] = Data.Instances['DistanceTag'] or NewDrawing'Text'{
                        Size			= Options.TextSize.Value - 1;
                        Center			= true;
                        Outline			= Options.TextOutline.Value;
                        Visible			= true;
                    };

                    local NameTag		= Data.Instances['NameTag'];
                    local DistanceTag	= Data.Instances['DistanceTag'];
                    local Tracer		= Data.Instances['Tracer'];

                    local Pass, Distance = CheckDistance(v.Instance);

                    if Pass then
                        local ScreenPosition, Vis = WorldToViewport(v.Instance.Position);
                        local Color = v.Color;
                        local OPos = Camera.CFrame:pointToObjectSpace(v.Instance.Position);
                        
                        if ScreenPosition.Z < 0 then
                            local AT = math.atan2(OPos.Y, OPos.X) + math.pi;
                            OPos = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(V3New(0, 0, -1))));
                        end
                        
                        local Position = WorldToViewport(Camera.CFrame:pointToWorldSpace(OPos));

                        if Options.ShowTracers.Value then
                            Tracer.Visible	= true;
                            Tracer.From		= V2New(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 65);
                            Tracer.To		= V2New(Position.X, Position.Y);
                            Tracer.Color	= Color;
                        else
                            Tracer.Visible = false;
                        end

                        if ScreenPosition.Z > 0 then
                            local ScreenPositionUpper = ScreenPosition;
                            -- WorldToViewport((v.Instance.CFrame * CFrame.new(0, v.Instance.Size.Y, 0)).p);
                            
                            if Options.ShowName.Value then
                                LocalPlayer.NameDisplayDistance = 0;
                                NameTag.Visible		= true;
                                NameTag.Text		= v.Text;
                                NameTag.Size		= Options.TextSize.Value;
                                NameTag.Outline		= Options.TextOutline.Value;
                                NameTag.Position	= V2New(ScreenPositionUpper.X, ScreenPositionUpper.Y);
                                NameTag.Color		= Color;
                                if Drawing.Fonts and shared.am_ic3 then -- CURRENTLY SYNAPSE ONLY :MEGAHOLY:
                                    NameTag.Font	= Drawing.Fonts.Monospace;
                                end
                            else
                                LocalPlayer.NameDisplayDistance = 100;
                                NameTag.Visible = false;
                            end
                            if Options.ShowDistance.Value or Options.ShowHealth.Value then
                                DistanceTag.Visible		= true;
                                DistanceTag.Size		= Options.TextSize.Value - 1;
                                DistanceTag.Outline		= Options.TextOutline.Value;
                                DistanceTag.Color		= Color3.new(1, 1, 1);
                                if Drawing.Fonts and shared.am_ic3 then -- CURRENTLY SYNAPSE ONLY :MEGAHOLY:
                                    NameTag.Font	= Drawing.Fonts.Monospace;
                                end

                                local Str = '';

                                if Options.ShowDistance.Value then
                                    Str = Str .. Format('[%d] ', Distance);
                                end

                                DistanceTag.Text = Str;
                                DistanceTag.Position = V2New(ScreenPositionUpper.X, ScreenPositionUpper.Y) + V2New(0, NameTag.TextBounds.Y);
                            else
                                DistanceTag.Visible = false;
                            end
                        else
                            NameTag.Visible			= false;
                            DistanceTag.Visible		= false;
                        end
                    else
                        NameTag.Visible			= false;
                        DistanceTag.Visible		= false;
                        Tracer.Visible			= false;
                    end

                    Data.Instances['NameTag'] 		= NameTag;
                    Data.Instances['DistanceTag']	= DistanceTag;
                    Data.Instances['Tracer']		= Tracer;

                    shared.InstanceData[v.Instance:GetDebugId()] = Data;
                end
            end
            for i, v in pairs(Players:GetPlayers()) do
                local Data = shared.InstanceData[v.Name] or { Instances = {}; };

                Data.Instances['Box'] = Data.Instances['Box'] or LineBox:Create{Thickness = 3};
                Data.Instances['Tracer'] = Data.Instances['Tracer'] or NewDrawing'Line'{
                    Transparency	= 1;
                    Thickness		= 2;
                }
                Data.Instances['HeadDot'] = Data.Instances['HeadDot'] or NewDrawing'Circle'{
                    Filled			= true;
                    NumSides		= 30;
                }
                Data.Instances['NameTag'] = Data.Instances['NameTag'] or NewDrawing'Text'{
                    Size			= Options.TextSize.Value;
                    Center			= true;
                    Outline			= Options.TextOutline.Value;
                    Visible			= true;
                };
                Data.Instances['DistanceHealthTag'] = Data.Instances['DistanceHealthTag'] or NewDrawing'Text'{
                    Size			= Options.TextSize.Value - 1;
                    Center			= true;
                    Outline			= Options.TextOutline.Value;
                    Visible			= true;
                };

                local NameTag		= Data.Instances['NameTag'];
                local DistanceTag	= Data.Instances['DistanceHealthTag'];
                local Tracer		= Data.Instances['Tracer'];
                local HeadDot		= Data.Instances['HeadDot'];
                local Box			= Data.Instances['Box'];

                local Pass, Distance = CheckPlayer(v);

                if Pass and v.Character then
                    local Humanoid = v.Character:FindFirstChildOfClass'Humanoid';
                    local Head = v.Character:FindFirstChild'Head';
                    local HumanoidRootPart = v.Character:FindFirstChild'HumanoidRootPart';
                    
                    if v.Character ~= nil and Head and HumanoidRootPart then
                        local ScreenPosition, Vis 	= WorldToViewport(Head.Position);
                        local Color = Options.Rainbow.Value and Color3.fromHSV(tick() * 128 % 255/255, 1, 1) or (CheckTeam(v) and Green or Red); Color = Options.ShowTeamColor.Value and v.TeamColor.Color or Color;
                        local OPos = Camera.CFrame:pointToObjectSpace(Head.Position);
                        
                        if ScreenPosition.Z < 0 then
                            local AT = math.atan2(OPos.Y, OPos.X) + math.pi;
                            OPos = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(V3New(0, 0, -1))));
                        end
                        
                        local Position = WorldToViewport(Camera.CFrame:pointToWorldSpace(OPos));

                        if Options.ShowTracers.Value then
                            Tracer.Visible	= true;
                            Tracer.Transparency = 0.6;
                            Tracer.From		= V2New(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 65);
                            Tracer.To		= V2New(Position.X, Position.Y);
                            Tracer.Color	= Color;
                        else
                            Tracer.Visible = false;
                        end
                        
                        if ScreenPosition.Z > 0 then
                            local ScreenPositionUpper	= WorldToViewport((HumanoidRootPart:GetRenderCFrame() * CFrame.new(0, Head.Size.Y + HumanoidRootPart.Size.Y, 0)).p);
                            local Scale					= Head.Size.Y / 2;

                            if Options.ShowName.Value then
                                NameTag.Visible		= true;
                                NameTag.Text		= v.Name .. (CustomPlayerTag and CustomPlayerTag(v) or '');
                                NameTag.Size		= Options.TextSize.Value;
                                NameTag.Outline		= Options.TextOutline.Value;
                                NameTag.Position	= V2New(ScreenPositionUpper.X, ScreenPositionUpper.Y) - V2New(0, NameTag.TextBounds.Y);
                                NameTag.Color		= Color;
                                NameTag.Transparency= 0.85;
                                if Drawing.Fonts and shared.am_ic3 then -- CURRENTLY SYNAPSE ONLY :MEGAHOLY:
                                    NameTag.Font	= Drawing.Fonts.Monospace;
                                end
                            else
                                NameTag.Visible = false;
                            end
                            if Options.ShowDistance.Value or Options.ShowHealth.Value then
                                DistanceTag.Visible		= true;
                                DistanceTag.Size		= Options.TextSize.Value - 1;
                                DistanceTag.Outline		= Options.TextOutline.Value;
                                DistanceTag.Color		= Color3.new(1, 1, 1);
                                DistanceTag.Transparency= 0.85;
                                if Drawing.Fonts and shared.am_ic3 then -- CURRENTLY SYNAPSE ONLY :MEGAHOLY:
                                    NameTag.Font	= Drawing.Fonts.Monospace;
                                end

                                local Str = '';

                                if Options.ShowDistance.Value then
                                    Str = Str .. Format('[Distance: %d]', Distance);
                                end
                                if Options.ShowHealth.Value and Humanoid then
                                    Str = Str .. Format(' [Health: %d/%d] [%s%%]', Humanoid.Health, Humanoid.MaxHealth, math.floor(Humanoid.Health / Humanoid.MaxHealth * 100));
                                    -- Str = Str .. Format('[%d/%d] [%s%%]', Humanoid.Health, Humanoid.MaxHealth, math.floor(Humanoid.Health / Humanoid.MaxHealth * 100));
                                end

                                DistanceTag.Text = Str;
                                DistanceTag.Position = (NameTag.Visible and NameTag.Position + V2New(0, NameTag.TextBounds.Y) or V2New(ScreenPositionUpper.X, ScreenPositionUpper.Y));
                            else
                                DistanceTag.Visible = false;
                            end
                            if Options.ShowDot.Value and Vis then
                                local Top			= WorldToViewport((Head.CFrame * CFrame.new(0, Scale, 0)).p);
                                local Bottom		= WorldToViewport((Head.CFrame * CFrame.new(0, -Scale, 0)).p);
                                local Radius		= (Top - Bottom).y;

                                HeadDot.Visible		= true;
                                HeadDot.Color		= Color;
                                HeadDot.Position	= V2New(ScreenPosition.X, ScreenPosition.Y);
                                HeadDot.Radius		= Radius;
                            else
                                HeadDot.Visible = false;
                            end
                            if Options.ShowBoxes.Value and Vis and HumanoidRootPart then
                                Box:Update(HumanoidRootPart.CFrame, V3New(2, 3, 0) * (Scale * 2), Color);
                            else
                                Box:SetVisible(false);
                            end
                        else
                            NameTag.Visible			= false;
                            DistanceTag.Visible		= false;
                            -- Tracer.Visible			= false;
                            HeadDot.Visible			= false;

                            Box:SetVisible(false);
                        end
                    end
                else
                    NameTag.Visible			= false;
                    DistanceTag.Visible		= false;
                    Tracer.Visible			= false;
                    HeadDot.Visible			= false;

                    Box:SetVisible(false);
                end

                shared.InstanceData[v.Name] = Data;
            end
        end
    end

    local LastInvalidCheck = 0;

    function Update()
        if tick() - LastInvalidCheck > 0.3 then
            LastInvalidCheck = tick();

            if Camera.Parent ~= workspace then
                Camera = workspace.CurrentCamera;
                WTVP = Camera.WorldToViewportPoint;
            end

            for i, v in pairs(shared.InstanceData) do
                if not Players:FindFirstChild(tostring(i)) then
                    if not shared.InstanceData[i].DontDelete then
                        GetTableData(v.Instances)(function(i, obj)
                            obj.Visible = false;
                            obj:Remove();
                            v.Instances[i] = nil;
                        end)
                        shared.InstanceData[i] = nil;
                    else
                        if shared.InstanceData[i].Instance == nil or shared.InstanceData[i].Instance.Parent == nil then
                            GetTableData(v.Instances)(function(i, obj)
                                obj.Visible = false;
                                obj:Remove();
                                v.Instances[i] = nil;
                            end)
                            shared.InstanceData[i] = nil;
                        end
                    end
                end
            end
        end

        if MenuLoaded then
            local MLocation = GetMouseLocation();
            shared.MenuDrawingData.Instances.Main.Color = Color3.fromHSV(tick() * 24 % 255/255, 1, 1);
            local MainInstance = Menu:GetInstance'Main';
            
            local Values = {
                MainInstance.Position.X;
                MainInstance.Position.Y;
                MainInstance.Position.X + MainInstance.Size.X;
                MainInstance.Position.Y + MainInstance.Size.Y;
            };
            
            if MainInstance and MouseHoveringOver(Values) then
                Debounce.CursorVis = true;
                -- GUIService:SetMenuIsOpen(true);
                Menu:UpdateMenuInstance'Cursor1'{
                    Visible	= true;
                    From	= V2New(MLocation.x, MLocation.y);
                    To		= V2New(MLocation.x + 5, MLocation.y + 6);
                }
                Menu:UpdateMenuInstance'Cursor2'{
                    Visible	= true;
                    From	= V2New(MLocation.x, MLocation.y);
                    To		= V2New(MLocation.x, MLocation.y + 8);
                }
                Menu:UpdateMenuInstance'Cursor3'{
                    Visible	= true;
                    From	= V2New(MLocation.x, MLocation.y + 6);
                    To		= V2New(MLocation.x + 5, MLocation.y + 5);
                }
            else
                if Debounce.CursorVis then
                    Debounce.CursorVis = false;
                    -- GUIService:SetMenuIsOpen(false);
                    Menu:UpdateMenuInstance'Cursor1'{Visible = false};
                    Menu:UpdateMenuInstance'Cursor2'{Visible = false};
                    Menu:UpdateMenuInstance'Cursor3'{Visible = false};
                end
            end
            if MouseHeld then
                if Dragging then
                    DraggingWhat.Slider.Position = V2New(math.clamp(MLocation.X, DraggingWhat.Line.From.X, DraggingWhat.Line.To.X), DraggingWhat.Slider.Position.Y);
                    local Percent	= (DraggingWhat.Slider.Position.X - DraggingWhat.Line.From.X) / ((DraggingWhat.Line.To.X - DraggingWhat.Line.From.X));
                    local Value		= CalculateValue(DraggingWhat.Min, DraggingWhat.Max, Percent);
                    DraggingWhat.Option(Value);
                elseif DraggingUI then
                    Debounce.UIDrag = true;
                    local Main = Menu:GetInstance'Main';
                    local MousePos = GetMouseLocation();
                    Main.Position = MousePos + DragOffset;
                end
            else
                Dragging = false;
                if DraggingUI and Debounce.UIDrag then
                    Debounce.UIDrag = false;
                    DraggingUI = false;
                    CreateMenu(Menu:GetInstance'Main'.Position);
                end
            end
        end
    end

    RunService:UnbindFromRenderStep(GetDataName);
    RunService:UnbindFromRenderStep(UpdateName);

    RunService:BindToRenderStep(GetDataName, 300, UpdatePlayerData);
    RunService:BindToRenderStep(UpdateName, 199, Update);

    ---------------------------------------------------------------------
    local secure_request = request or http_request or syn.request
    local welcomeMessages = {"joined the party!","is here yay!","joined GG!","has spawned!","arrived. Seems OP","is here, as prophecy foretold!", "is here. LETSGO!"} -- Items table.
    local value = math.random(1,#welcomeMessages)
    local picked_value = welcomeMessages[value]
    local asset = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    local totalexecutes = secure_request({Url = "https://node.ihaxu.com/getExecutionTimes", Method = 'GET'}).Body
    local totalmembers = secure_request({Url = "https://node.ihaxu.com/getDiscordMembers", Method = 'GET'}).Body
    
    if game.CoreGui:FindFirstChild("moonhub") then
        local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
        local Alert = library:Notification("Moonhub: Load Failed!","Already Executed", 5, Color3.fromRGB(28, 176, 192))
        spawn(function()
            for i = 1, 50, 2 do
                blur.Size = 50 - i
                --ImageLabel.ImageTransparency = ImageLabel.ImageTransparency + 0.1
                wait()
            end

            sound:Destroy()
            blur:Destroy()
                
        end)
        return
    end

    local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
    local Alert = library:Notification("Moonhub: Loaded!","🥳 "..game.Players.LocalPlayer.DisplayName.." "..welcomeMessages[value], 5, Color3.fromRGB(28, 176, 192))
    spawn(function()
        for i = 1, 50, 2 do
            blur.Size = 50 - i
            --ImageLabel.ImageTransparency = ImageLabel.ImageTransparency + 0.1
            wait()
        end
            
        sound:Destroy()
        blur:Destroy()
            
    end)

    --wait()
    local Flux = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/hub.lua", Method = 'GET'}).Body)()

    local win = Flux:Window("Moonhub", "Universal", Color3.fromRGB(28, 176, 192), Enum.KeyCode.RightControl)
    Flux:Notification([[By clicking the "Accept" button means that you are allowing me. By logging your, Username, Game Name and HWID. To survey the most executed, User & Games. To prioritize which game to improve in future.]], "Accept")

    local home = win:Tab("Aimbot", "http://www.roblox.com/asset/?id=6816897605")
    local visuals = win:Tab("Visuals", "http://www.roblox.com/asset/?id=6816867088")
    local misc = win:Tab("Miscellaneous", "http://www.roblox.com/asset/?id=6816596841")
    local checker = win:Tab("Player Checker", "http://www.roblox.com/asset/?id=6816870638")
    local status = win:Tab("Status", "http://www.roblox.com/asset/?id=6827041233")
    local leftFrame = game:GetService("CoreGui").moonhub.MainFrame.LeftFrame
    local text = Instance.new("TextLabel",leftFrame)
    text.Position = UDim2.new(0,0,1,-40)
    text.Size = UDim2.new(1,0,0,40)
    text.ZIndex = 69
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.new(1,1,1)
    text.TextSize = 16
    text.Text = "🌐 "..totalexecutes.." Total Executions"
    text.Font = Enum.Font.Gotham
    local text2 = Instance.new("TextLabel",leftFrame)
    text2.Position = UDim2.new(0,0,1,-80)
    text2.Size = UDim2.new(1,0,0,40)
    text2.ZIndex = 69
    text2.BackgroundTransparency = 1
    text2.TextColor3 = Color3.new(1,1,1)
    text2.TextSize = 16
    text2.Text = "👥 "..totalmembers.." Total Members  "
    text2.Font = Enum.Font.Gotham

    local aimToggle = home:Toggle("Enabled", "Toggle your Aimbot.", false, function(arg)
        if arg then
            EzAimbot.Enable({["Size"]=120,["Sides"]=50,["Color"]=Red})
        else
            EzAimbot.Disable()
        end
    end)

    aimbotKeybind = home:Bind("Aimkey", Enum.UserInputType.MouseButton2, function() end)

    warn()

    home:Line()

    local aimPartDropdown = home:Dropdown("Aim Part", {"Head","UpperTorso","LowerTorso"}, EzAimbot.ChangeTarget)

    local ffaToggle = home:Toggle("Free For All", "Changing the aiming to everyone.", true, EzAimbot.FreeForAll)

    local visibilityToggle = home:Toggle("Visiblity Check", "Can only aim visible players.", false, EzAimbot.SetVisibility)

    home:Line()

    local fovToggle = home:Toggle("View FOV", "Displaying aimbot field of view.", false, EzAimbot.ShowFov)
    local fovColorpicker = home:Colorpicker("FOV Color", Color3.fromRGB(0,255,255), EzAimbot.ChangeColor)
    local fovSlider = home:Slider("FOV Size", "Resizing aimbot field of view", 10, 300, 0, EzAimbot.FovSize)

    local espToggle = visuals:Toggle("Enabled", "Toggle your ESP.", false, function(arg)
        Options.Enabled()
    end)

    visuals:Line()

    local headToggle = visuals:Toggle("Head", "Shows the head of the other players.", true, function(arg)
        Options.ShowDot()
    end)

    local boxToggle = visuals:Toggle("Box", "Shows the box of the other players.", true, function(arg)
        Options.ShowBoxes()
    end)

    local tracersToggle = visuals:Toggle("Tracers", "Line tracing the other players.", true, function(arg)
        Options.ShowTracers()
    end)

    visuals:Line()

    local nameToggle = visuals:Toggle("Name", "Displaying other players username.", true, function(arg)
        Options.ShowName()
    end)

    local distanceToggle = visuals:Toggle("Distance", "Showing the distance between you and the other players.", true, function(arg)
        Options.ShowDistance()
    end)

    local healthToggle = visuals:Toggle("Health", "Displaying other players total health.", true, function(arg)
        Options.ShowHealth()
    end)

    visuals:Line()

    local teamCheckToggle = visuals:Toggle("Team Check", "Shows your team.", true, function(arg)
        Options.ShowTeam()
    end)

    local teamColorToggle = visuals:Toggle("Use Team Color", "Use all the team colors.", false, function(arg)
        Options.ShowTeamColor()
    end)

    local espColorpicker = visuals:Colorpicker("ESP Color", Color3.fromRGB(28, 176, 192), function(color)
        Green = color
    end)

    local visibilityToggle2 = visuals:Toggle("Visibility Check", "Shows only visible players.", false, function(arg)
        Options.VisCheck()
    end)

    local textSizeSlider = visuals:Slider("Text Size", "Resizing ESP Text.", 15, 25,0,function(value)
        rawset(Options.TextSize, "Value", value)
    end)

    local espDistanceSlider = visuals:Slider("Set Distance", "Adjusting the ESP Distance.", 100, 10000,0,function(value)
        rawset(Options.MaxDistance, "Value", value)
    end)

    local nameLabel
    local displayNameLabel
    local ageLabel
    local userIdLabel
    local membershipTypeLabel
    local teamLabel
    local fpsBoosterButton
    local antiAfkButton
    local rejoinButton
    local destroyButton
    local hideShowLabel
    local discordButton
    local usernameTextbox
    local gamesDropdown
    local workingLabel
    local updatingLabel
    local testingLabel
    local tosButton
    local aboutUsButton
    local clientAgeLabel
    local selectLanguageDropdown

    local language = {
        ["English 🇺🇸"] = english,
        ["Japanese 🇯🇵"] = japan,
        ["French 🇫🇷 (Supporting Soon)"] = french,
        ["Spanish 🇪🇸 (Supporting Soon)"] = spanish
    }
    selectLanguageDropdown = misc:Dropdown("Select Language", {
        "English 🇺🇸",
        "Japanese 🇯🇵",
        "French 🇫🇷 (Supporting Soon)",
        "Spanish 🇪🇸 (Supporting Soon)",
        
    }, function(dropdownvalue)
        if dropdownvalue == "Japanese 🇯🇵" then
            local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
            local Alert = library:Notification("Moonhub: こんにちは！","言語が変わりました！", 5, Color3.fromRGB(28, 176, 192))
            home:Set("自動照準")
            visuals:Set("ビジュアル")
            misc:Set("その他")
            checker:Set("プレイヤーチェッカー")
            status:Set("状態")
            
            aimToggle:Set("オン","照準アシストを切り替えます。")
            aimbotKeybind:Set("エイムキー。")
            aimPartDropdown:Set("対象部。")
            ffaToggle:Set("全員","全員にエイムアシストを変更。")
            visibilityToggle:Set("視界チェック","見える選手だけを狙う。")
            fovToggle:Set("視野","エイムアシスト視野を表示。")
            fovColorpicker:Set("視野色","視野カラーピッカー。")
            fovSlider:Set("視野サイズ","エイムアシスト視野のサイズ変更。")
            
            espToggle:Set("オン","ESP を有効にする。")
            headToggle:Set("頭","頭を見せる。")
            boxToggle:Set("ボックス","表示ボックス。")
            tracersToggle:Set("トレーサー","トレーサーを表示。")
            nameToggle:Set("名前","名前を表示。")
            distanceToggle:Set("距離","距離を表示します")
            healthToggle:Set("健康","健康状態を表示")
            teamCheckToggle:Set("チームチェック","あなたのチームを表示します")
            teamColorToggle:Set("チームカラー","チームカラーを使用する")
            espColorpicker:Set("ESPカラー")
            visibilityToggle2:Set("視界チェック","表示されているプレーヤーのみ")
            textSizeSlider:Set("フォントサイズ","フロントサイズを調整します。")
            espDistanceSlider:Set("ESP距離","ESP の表示距離を調整する")
            
            selectLanguageDropdown:Set("言語を選択してください")
            fpsBoosterButton:Set("FPSブースター","PCが苦手な方にオススメです。")
            antiAfkButton:Set("アンチAFK","クライアントの 20 分間の自動キック アイドルを無効にします。")
            rejoinButton:Set("再参加","現在のサーバーに再参加します。")
            destroyButton:Set("削除")
            hideShowLabel:Set("非表示/表示:                                                                                右Ctrl")
            discordButton:Set("Moonhub不和","会員になる。")
            
            usernameTextbox:Set("ユーザー名","他のプレイヤーからの詳細情報を確認してください。")
            
            gamesDropdown:Set("すべての Moonhub ゲーム")
            workingLabel:Set("🟢 それは機能しており、安全で、まだ検出されていません。")
            updatingLabel:Set("🟡 更新中、現在開発中です。")
            testingLabel:Set("🟣 テスティング、リスキーな、安全に使用できません。")
            tosButton:Set("利用規約 ENG","読んでください。")
            aboutUsButton:Set("私たちに関しては ENG","読んでください。")
            
        elseif dropdownvalue == "French 🇫🇷 (Supporting Soon!)" then
            local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
            local Alert = library:Notification("Moonhub: Salut! Comment ça va?","Langue a changé!", 5, Color3.fromRGB(28, 176, 192))
        elseif dropdownvalue == "Spanish 🇪🇸 (Supporting Soon!)" then
            local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
            local Alert = library:Notification("Moonhub: ¿Cómo estás?","Idioma cambiado!", 5, Color3.fromRGB(28, 176, 192))
        elseif dropdownvalue == "English 🇺🇸" then
            local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
            local Alert = library:Notification("Moonhub: You're back!","Language changed!", 5, Color3.fromRGB(28, 176, 192))
            home:Set("Aimbot")
            visuals:Set("Visuals")
            misc:Set("Miscellaneous")
            checker:Set("Player Checker")
            status:Set("Status")
            
            aimToggle:Set("Enabled","Toggle your Aimbot.")
            aimbotKeybind:Set("Aimkey")
            aimPartDropdown:Set("Aim Part")
            ffaToggle:Set("Free For All","Changing the aiming to everyone.")
            visibilityToggle:Set("Visibility Check","Can only aim visible players.")
            fovToggle:Set("View FOV","Displaying aimbot field of view.")
            fovColorpicker:Set("FOV Color")
            fovSlider:Set("FOV SIze","Resizing aimbot field of view.")
            
            espToggle:Set("Enabled","Toggle your ESP.")
            headToggle:Set("Head","Shows the head of the other players.")
            boxToggle:Set("Box","Shows the box of the other players.")
            tracersToggle:Set("Tracers","Line tracing the other players.")
            nameToggle:Set("Name","Displaying other players username.")
            distanceToggle:Set("Distance","Showing the distance between you and the other players.")
            healthToggle:Set("Health","Displaying other players total health.")
            teamCheckToggle:Set("Team Check","Shows your team.")
            teamColorToggle:Set("Use Team Color","Use all the team colors.")
            espColorpicker:Set("ESP Color")
            visibilityToggle2:Set("Visibility Check","Shows only visible players.")
            textSizeSlider:Set("Text Size","Resizing ESP Text.")
            espDistanceSlider:Set("Set Distance","Adjusting the ESP Distance.")
            
            selectLanguageDropdown:Set("Select Language")
            fpsBoosterButton:Set("FPS Booster","Recommended if you have a bad pc.")
            antiAfkButton:Set("Anti AFK","Disable client 20 minutes auto kick idle.")
            rejoinButton:Set("Rejoin","Rejoin the current server.")
            destroyButton:Set("Destroy")
            hideShowLabel:Set("Hide/Show:                                                              Right Control")
            discordButton:Set("Moonhub Discord","Join us!")
            
            usernameTextbox:Set("Username","Check more info from the other players.")
            
            gamesDropdown:Set("All Moonhub Games")
            workingLabel:Set("🟢 Working, safe and still undetected.")
            updatingLabel:Set("🟡 Updating, under development, at the moment.")
            testingLabel:Set("🟣 Testing, unsafe, and very risky to use.")
            tosButton:Set("Terms of Service","Read me.")
            aboutUsButton:Set("About Us","Read me.")
        end
    end)

    ---------------

    misc:Line()

    fpsBoosterButton = misc:Button("FPS Booster", "Recommended if you have a bad pc.", function()
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
        local Alert = library:Notification("Your FPS have been boosted!","Moonhub~", 3, Color3.fromRGB(28, 176, 192))
    end)

    antiAfkButton = misc:Button("Anti AFK", "Disable client 20 minutes auto kick idle.", function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
        wait()
        local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
        local Alert = library:Notification("Activated Anti AFK!","Moonhub~", 3, Color3.fromRGB(28, 176, 192))
    end)

    rejoinButton = misc:Button("Rejoin", "Rejoin the current server.", function()
        local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
        local Alert = library:Notification("Moonhub: Rejoining!","Moonhub~", 3, Color3.fromRGB(28, 176, 192))
        wait(3)
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end)

    destroyButton = misc:Bind("Destroy", Enum.KeyCode.Delete, function()
        if Options.Enabled.Value then pcall(Options.Enabled) end
        pcall(EzAimbot.Disable)
        game:GetService("CoreGui").moonhub:Destroy()
        wait()
        local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
        local Alert = library:Notification("Moonhub: Signing Off","Thanks for using Moonhub!", 5, Color3.fromRGB(28, 176, 192))
    end)

    hideShowLabel = misc:Label("Hide/Show:                                                              Right Control")

    misc:Line()

    discordButton = misc:Button("Moonhub Discord", "Join us!", function()
        getgenv().discord_invite = "Mh2UKfxgh5"
        loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/discord.lua", Method = 'GET'}).Body)()
    end)

    usernameTextbox = checker:Textbox("Username", "Check more info from the other players.", false, function(text)
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do	
            if string.find(string.lower(v.Name), string.lower(tostring(text))) then
                nameLabel:Set("Name: "..v.Character.Name)
                displayNameLabel:Set("Display Name: "..v.DisplayName)
                ageLabel:Set("Age: "..v.AccountAge.." day(s)")
                userIdLabel:Set("User ID: "..v.UserId)
                membershipTypeLabel:Set("Membership Type: "..(v.MembershipType == Enum.MembershipType.Premium and "Premium" or "None"))
                teamLabel:Set("Team: "..(v.Team and v.Team.Name or "None"))
            end
        end
    end)

    checker:Line()

    nameLabel = checker:Label("Name: "..game:GetService("Players").LocalPlayer.Character.Name)
    displayNameLabel = checker:Label("Display Name: "..game:GetService("Players").LocalPlayer.DisplayName)
    ageLabel = checker:Label("Age: "..game:GetService("Players").LocalPlayer.AccountAge.." day(s)")
    userIdLabel = checker:Label("User ID: "..game:GetService("Players").LocalPlayer.UserId)
    membershipTypeLabel = checker:Label("Membership Type: "..(game:GetService("Players").LocalPlayer.MembershipType == Enum.MembershipType.Premium and "Premium" or "None"))
    teamLabel = checker:Label("Team: "..(game:GetService("Players").LocalPlayer.Team and game:GetService("Players").LocalPlayer.Team.Name or "None"))

    local check = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/status/main/check.lua", Method = 'GET'}).Body)()
    local dropdownList = {}
    for i,v in next, check do
        table.insert(dropdownList,i)
    end

    gamesDropdown = status:Dropdown("All Moonhub Games", 
    dropdownList,
    function(dropdownvalue)
        local library = loadstring(secure_request({Url = "https://raw.githubusercontent.com/mooncores/lib/main/notif.lua", Method = 'GET'}).Body)()
        local Alert = library:Notification("Moonhub: Teleporting!","Seeyou in "..dropdownvalue.."!", 5, Color3.fromRGB(28, 176, 192))
        wait(5)
        placeid = check[dropdownvalue]
        tp = game:GetService('TeleportService')
        for i,v in pairs (game.Players:GetChildren()) do
            tp:Teleport(placeid, v)
        end
    end)

    status:Line()

    workingLabel = status:Label("🟢 Working, safe and still undetected.")
    updatingLabel = status:Label("🟡 Updating, under development, at the moment.")
    testingLabel = status:Label("🟣 Testing, unsafe, and very risky to use.")

    status:Line()

    tosButton = status:Button("Terms of Service", "Read me.", function()
    Flux:Notification("By using Moonhub , you are agreeing to be bound by our terms and conditions. We are not responsible for any ban or terminations. We reserves the right to blacklist any account who violates our #rules.", "Accept")
    end)

    aboutUsButton = status:Button("About Us", "Read me.", function()
        Flux:Notification("Moonhub is a full free hub that was created at April 26,2021. Currently we supported some of the popular games such as, King Legacy , Arsenal, and more. Your account safety will always be our top priority.", "Close")
    end)

    clientAgeLabel = status:Label("Client Age:")
    ----------------------------------------------------------------
    while wait() do
        pcall(function()
    local seconds = math.floor(workspace.DistributedGameTime)
    local minutes = math.floor(workspace.DistributedGameTime / 60)
    local hours = math.floor(workspace.DistributedGameTime / 60 / 60)
    local second = seconds - (minutes * 60)
    local minutes = minutes - (hours * 60)
    for i,v in pairs(game:GetService("CoreGui").moonhub.MainFrame.ContainerFolder:GetDescendants()) do
    if v:IsA("TextLabel") and v.Name == "Title" and (v.Text:find("Client Age:") or v.Text:find("Runtime: ")) then
        v.Text = "Runtime: "..hours .. " Hour(s), " .. minutes .. " Minute(s), " .. second .. " Second(s)"
    end
    end
    end)
    end
end
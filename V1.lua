local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Maxgat5/UiLib/main/lua')))()
local w = library:CreateWindow("Garbage Magnet Simulator")
local b = w:CreateFolder("AutoFarm")
local f = w:CreateFolder("AutoBuy")
local e = w:CreateFolder("Mix")
local u = w:CreateFolder("Credits")
SelectedEgg = ""
Eggs = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Assets.Eggs:GetChildren()) do
    if not table.find(Eggs,v.Name) then
        table.insert(Eggs,v.Name)
    end
end

b:Toggle("AutoCollectDrop",function(bool)
    shared.toggle = bool
    AutoCollectDrop = bool
end)

b:Toggle("AutoSell",function(bool)
    shared.toggle = bool
    AutoSell = bool
end)

f:Dropdown("Select Egg",Eggs,true,function(a)
    SelectedEgg = a
end)

f:Toggle("Egg",function(bool)
    shared.toggle = bool
    Egg = bool
end)

e:Toggle("AntiAfk",function(bool)
    shared.toggle = bool
    AntiAfk = bool
end)

e:Button("Open Shop",function()
    game:GetService("Workspace").Debris.Activations.Shop.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end)
--Credits
u:Button("KitieJolie#0003",function()
    setclipboard("KitieJolie#0003")
end)
 
u:Button("Discord Server",function()
    setclipboard("https://discord.gg/BX8AfeHXsJ")
end)

game:GetService('RunService').Stepped:connect(function()
    spawn(function()
        if AntiAfk == true then
            local bb=game:service'VirtualUser'
            bb:CaptureController()
            bb:ClickButton2(Vector2.new())
        end
    end)
end)

function ClosestPart()
    local dist = math.huge
    local target = nil
    for i,v in pairs(game:GetService("Workspace").Debris.Areas:GetChildren()) do
        local magnitude = (v.Position - game:GetService("Players").LocalPlayer.Character.Head.Position).magnitude
        if magnitude < dist then
            dist = magnitude
            target = v
        end
    end
    return target
end

spawn(function()
    while wait() do
        if Egg == true then
            game:GetService("ReplicatedStorage").Assets.Events.RemoteEvent:FireServer("Buy This Egg",SelectedEgg)
        end
    end
end)

spawn(function()
    while wait() do
        if AutoSell == true then
            game:GetService("Workspace").Debris.Activations.Selling.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,100)
            wait(.1)
            game:GetService("Workspace").Debris.Activations.Selling.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,0)
            wait(.1)
        end
    end
end)

spawn(function()
    while wait() do
        if AutoCollectDrop == true then
            for i,v in pairs(game:GetService("Workspace").Debris.Areas[ClosestPart().Name].Pickups:GetChildren()) do
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,0)
            end
        end
    end
end)

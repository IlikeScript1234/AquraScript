local Library = shared.GuiLibrary
local C = shared.Combat
local V = shared.Visual
local M = shared.Movement
local E = shared.Exploits

Combat = C.CreateSection({Name = "Combat"})
Visual = V.CreateSection({Name = "Visual"})
Movement = M.CreateSection({Name = "Movement"})
Exploit = E.CreateSection({Name = "Exploit"})


local networkownertick = tick()
local isnetworkowner = isnetworkowner or function(part)
  if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
      sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
      networkownertick = tick() + 8
  end
  return networkownertick <= tick()
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local HumanoidRootPart = chr:WaitForChild("HumanoidRootPart")

local Cars = game.Workspace:WaitForChild("Cars")
local CarModels = Cars:GetChildren()
local Trucks = game.Workspace:WaitForChild("Trucks")
local TruckModels = Trucks:GetChildren()

local CarCrasher = {Enabled = false}
CarCrasher = Exploit.CreateToggle({
    Name = "CarCrasher",
    Function = function(callback)
        CarCrasher.Enabled = callback
     
        repeat task.wait(0.15)
            for i, v in pairs(CarModels) do
                if v.ClassName ~= "Model" then
                    table.remove(CarModels, i)
                end
            end
            
            for i, v in pairs(TruckModels) do
                if v.ClassName ~= "Model" then
                    table.remove(TruckModels, i)
                end
            end
            
            local VehicleModels = {}
            for _, v in pairs(CarModels) do
                table.insert(VehicleModels, v)
            end
            for _, v in pairs(TruckModels) do
                table.insert(VehicleModels, v)
            end
            
            local Vehicle = VehicleModels[math.random(#VehicleModels)]
            local Seat = Vehicle:WaitForChild("Seat")
            
            HumanoidRootPart.CFrame = Seat.CFrame
        until (not CarCrasher.Enabled)
    end
})


Visual.CreateButton({
    Name = "Car Teleporter",
    Function = function()
        local unanchoredVehicles = {}
        for _, vehicle in pairs(game.Workspace:GetDescendants()) do
            if (vehicle:IsA("VehicleSeat") or vehicle.Name == "Trunk1" or vehicle.Name == "Trunk2") and not vehicle.Anchored then
                table.insert(unanchoredVehicles, vehicle)
            end
        end
        
        local player = game.Players.LocalPlayer
        for _, vehicle in pairs(unanchoredVehicles) do
            vehicle.CFrame = player.Character.HumanoidRootPart.CFrame
        end        
    end
})

_G.cookroomfucker = true
Exploit.CreateButton({
    Name = "Room Fucker 9000",
    Function = function()
        local lp = game:GetService("Players").LocalPlayer
        local remote
        local ffc = game.FindFirstChild

        do
            local reg = (getreg or debug.getregistry)()
            for i=1,#reg do
                local f = reg[i]
                if type(f)=="table" and rawget(f,"FireServer") and rawget(f,"BindEvents") then
                    remote = f
                end
            end
        end

        function moveThing(bmd, location)
            remote:FireServer("UpdateProperty", bmd, "CFrame", location)
            wait()
            remote:FireServer("SquishDough", bmd)
        end

        for i,v in pairs(workspace.AllSupplyBoxes:GetChildren()) do
            v.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
        end
        wait()


        spawn(function()
            while _G.cookroomfucker and wait() do
                spawn(function()
                    for i,v in pairs(workspace.AllDough:GetChildren()) do
                        moveThing(v, CFrame.new(Random.new():NextNumber(22.6,51.6),Random.new():NextNumber(3.6,14.6),Random.new():NextNumber(55.5,70.5)))
                    end
                end)
                spawn(function()
                    for i,v in pairs(workspace.AllMountainDew:GetChildren()) do
                        moveThing(v, CFrame.new(Random.new():NextNumber(22.6,51.6),Random.new():NextNumber(3.6,14.6),Random.new():NextNumber(55.5,70.5)))
                    end
                end)
                spawn(function()
                    for i,v in pairs(workspace.BoxingRoom:GetChildren()) do
                        moveThing(v, CFrame.new(Random.new():NextNumber(22.6,51.6),Random.new():NextNumber(3.6,14.6),Random.new():NextNumber(55.5,70.5)))
                    end
                end)
                spawn(function()
                    for i,v in pairs(workspace.AllBox:GetChildren()) do
                        moveThing(v, CFrame.new(Random.new():NextNumber(22.6,51.6),Random.new():NextNumber(3.6,14.6),Random.new():NextNumber(55.5,70.5)))
                    end
                end)
                spawn(function()
                    for i,v in pairs(workspace.AllSupplyBoxes:GetChildren()) do
                        moveThing(v, CFrame.new(Random.new():NextNumber(22.6,51.6),Random.new():NextNumber(3.6,14.6),Random.new():NextNumber(55.5,70.5)))
                    end
                end)
            end
        end)

        spawn(function()
            while _G.cookroomfucker and wait() do
                for i,v in pairs(game:GetService("Workspace").Ovens:GetChildren()) do
                    v.Door.ClickDetector.Detector:FireServer()
                    wait(.15)
                end
            end
        end)    
    end,
})

Combat.CreateTextBox({
    Name = "Kill Player",
    Function = function(txt)
        destroy:FireServer(Players:FindFirstChild(txt).Character.Head,"call")
    end,
    HoverText = "killing player"
})

local destroy = Workspace.GameService.CloseBox
Visual.CreateButton({
    Name = "AutoFarmMenu",
    Function = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/cEwtwKZR", true))()
    end
})

local SpeedValue = {Value = 4}
local Speed = {Enabled = false}
Speed = Movement.CreateToggle({
    Name = "Speed",
    Function = function(callback)
        Speed.Enabled = callback
        if callback then
            repeat task.wait()
                local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
                local hum = lplr.Character:FindFirstChild("Humanoid")
                if isnetworkowner(hrp) and hum.MoveDirection.Magnitude > 0 then
                    lplr.Character:TranslateBy(hum.MoveDirection * SpeedValue["Value"])
                end
            until (not Speed.Enabled)
        end
    end
})
Movement.CreateSlider({
    Name = "Value",
    Min = 0,
    Max = 5,
    Default = 4,
    Function = function(val)
        SpeedValue["Value"] = val
    end
})

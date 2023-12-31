--[[
	Universal
]]


local Library = shared.GuiLibrary
local C = shared.Combat
local V = shared.Visual
local M = shared.Movement
local E = shared.Exploits

Combat = C.CreateSection({Name = "Combat"})
Visual = V.CreateSection({Name = "Visual"})
Movement = M.CreateSection({Name = "Movement"})
Exploit = E.CreateSection({Name = "Exploit"})

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local HumanoidRootPart = chr:WaitForChild("HumanoidRootPart")

--[[
	Exploit
]]

local InfJump = {Enabled = false}
InfJump = E.CreateToggle({
    Name = "Infinite Jump",
    Function = function(callback)
        InfJump.Enabled = callback
        if callback then
			game:GetService("UserInputService").JumpRequest:connect(function()
				if InfJump.Enabled then
					player.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
				end
			end)
        end
    end
})

--[[
	Movement
]]

local SpeedValue = {Value = 4}
local Speed = {Enabled = false}
Speed = M.CreateToggle({
    Name = "Speed",
    Function = function(callback)
        Speed.Enabled = callback
        if callback then
            repeat task.wait()
				player.Character.Humanoid.WalkSpeed = SpeedValue
            until (not Speed.Enabled)
        end
    end
})

M.CreateSlider({
    Name = "Value",
    Min = 12,
    Max = 200,
    Default = 23,
    Function = function(val)
        SpeedValue["Value"] = val
    end
})

local SpeedValue = {Value = 4}
local Speed = {Enabled = false}
Speed = M.CreateToggle({
    Name = "Speed",
    Function = function(callback)
        Speed.Enabled = callback
        if callback then
            repeat task.wait()
				player.Character.Humanoid.WalkSpeed = SpeedValue
            until (not Speed.Enabled)
        end
    end
})
M.CreateSlider({
    Name = "Value",
    Min = 12,
    Max = 200,
    Default = 23,
    Function = function(val)
        SpeedValue["Value"] = val
    end
})

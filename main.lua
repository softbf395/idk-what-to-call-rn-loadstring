warn("V0.1")
if not owner then warn("ERROR: used on no-one.") return end
--Converted with ttyyuu12345's model to script plugin v4
function sandbox(var,func)
	local env = getfenv(func)
	local newenv = setmetatable({},{
		__index = function(self,k)
			if k=="script" then
				return var 
			else
				return env[k]
			end
		end,
	})
	setfenv(func,newenv)
	return func
end
cors = {}
ScreenGui0 = Instance.new("ScreenGui")
TextBox1 = Instance.new("TextBox")
TextButton2 = Instance.new("TextButton")
ScreenGui0.Parent = owner.PlayerGui
ScreenGui0.Name="ExecUI"
ScreenGui0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TextBox1.Name = "raw"
TextBox1.Parent = ScreenGui0
TextBox1.Size = UDim2.new(0.429688781, 0, 0.100000001, 0)
TextBox1.BackgroundColor = BrickColor.new("Really black")
TextBox1.BackgroundColor3 = Color3.new(0, 0, 0)
TextBox1.BorderColor = BrickColor.new("Really black")
TextBox1.BorderColor3 = Color3.new(0, 0, 0)
TextBox1.BorderSizePixel = 0
TextBox1.Font = Enum.Font.Arcade
TextBox1.FontSize = Enum.FontSize.Size14
TextBox1.Text = ""
TextBox1.TextColor = BrickColor.new("Institutional white")
TextBox1.TextColor3 = Color3.new(1, 1, 1)
TextBox1.TextScaled = true
TextBox1.TextSize = 14
TextBox1.TextWrap = true
TextBox1.TextWrapped = true
TextBox1.PlaceholderText = "raw code"
TextButton2.Name = "exec"
TextButton2.Parent = ScreenGui0
TextButton2.Position = UDim2.new(0.164003357, 0, 0.0987055004, 0)
TextButton2.Size = UDim2.new(0.100000001, 0, 0.100000001, 0)
TextButton2.BackgroundColor = BrickColor.new("Institutional white")
TextButton2.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton2.BorderColor = BrickColor.new("Really black")
TextButton2.BorderColor3 = Color3.new(0, 0, 0)
TextButton2.BorderSizePixel = 0
TextButton2.Font = Enum.Font.SourceSans
TextButton2.FontSize = Enum.FontSize.Size14
TextButton2.Text = "execute"
TextButton2.TextColor = BrickColor.new("Really black")
TextButton2.TextColor3 = Color3.new(0, 0, 0)
TextButton2.TextSize = 14
local UI=owner.PlayerGui.ExecUI
local rmEventName="EVENT_"..owner.Name
local rmEvent=game.ReplicatedStorage:FindFirstChild(rmEventName) or Instance.new("RemoteEvent")
rmEvent.Name=rmEventName
rmEvent.OnServerEvent:Connect(function(ServerCheck --[[we will check to see who this is before letting it run.]], rawlink)
        if ServerCheck~=owner then return end --not meant to be backdoor, so heres a server validation.
        local raw=game:GetService("HttpService"):GetAsync(rawlink):gsub("LocalPlayer",owner.Name)
        for _, plr in ipairs(game.Players:GetPlayers()) do NLS(raw, plr.Backpack) end
end)
NLS([[
    local rem=game.ReplicatedStorage:WaitForChild("]]..rmEventName..[[",15)
    local UI=script.Parent
    local tb=UI.raw
    local btn=UI.exec
    btn.MouseButton1Click:Connect(function() rem:FireServer(tb.Text) end)
]], UI)

local partsWithId = {}
local awaitRef = {}
local lstr=require(4689019964)
local root = {
	ID = 0;
	Type = "ScreenGui";
	Properties = {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	};
	Children = {
		{
			ID = 1;
			Type = "TextBox";
			Properties = {
				TextWrapped = true;
				TextColor3 = Color3.new(1,1,1);
				BorderColor3 = Color3.new(0,0,0);
				Text = "";
				TextScaled = true;
				FontSize = Enum.FontSize.Size14;
				TextSize = 14;
				Font = Enum.Font.Arcade;
				Name = "raw";
				Size = UDim2.new(0.42968878149986267,0,0.10000000149011612,0);
				BackgroundColor3 = Color3.new(0,0,0);
				PlaceholderText = "raw link";
				BorderSizePixel = 0;
				TextWrap = true;
			};
			Children = {};
		};
		{
			ID = 2;
			Type = "TextButton";
			Properties = {
				FontSize = Enum.FontSize.Size14;
				TextColor3 = Color3.new(0,0,0);
				BorderColor3 = Color3.new(0,0,0);
				Text = "Exec";
				Font = Enum.Font.SourceSans;
				Name = "exec";
				Position = UDim2.new(0.16400335729122162,0,0.09870550036430359,0);
				Size = UDim2.new(0.10000000149011612,0,0.10000000149011612,0);
				TextSize = 14;
				BorderSizePixel = 0;
				BackgroundColor3 = Color3.new(1,1,1);
			};
			Children = {};
		};
	};
};

local function Scan(item, parent)
	local obj = Instance.new(item.Type)
	if (item.ID) then
		local awaiting = awaitRef[item.ID]
		if (awaiting) then
			awaiting[1][awaiting[2]] = obj
			awaitRef[item.ID] = nil
		else
			partsWithId[item.ID] = obj
		end
	end
	for p,v in pairs(item.Properties) do
		if (type(v) == "string") then
			local id = tonumber(v:match("^_R:(%w+)_$"))
			if (id) then
				if (partsWithId[id]) then
					v = partsWithId[id]
				else
					awaitRef[id] = {obj, p}
					v = nil
				end
			end
		end
		obj[p] = v
	end
	for _,c in pairs(item.Children) do
		Scan(c, obj)
	end
	obj.Parent = parent
	return obj
end

local createUI = function(uip) return Scan(root, uip) end

if not owner then warn("ERROR: used on no-one.") return end

local UI=createUI(owner.PlayerGui)
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

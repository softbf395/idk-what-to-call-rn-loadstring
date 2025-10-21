warn("STAR GLITCHER NS LOADSTRING V0.3 prototype 12.") -- v0.3.0_p12!!

-- it'll be outta prototype once bugs are fixed, maybe next update to this..?

warn(" ")
warn("----------------------------------------------------------")
warn(" ")

warn("THIS IS A REMAKE of Star Glitcher. you will need edit access to the game you use this in.")

warn(" ")
warn("----------------------------------------------------------")
warn(" ")

warn("UPDATE:")

warn(" ")
warn("----------------------------------------------------------")
warn(" ")

warn("+ le wings")
warn("+ mayhem song (D-Mode-D - Shriek)")
warn("- SUBLIMINAL mode"
)
warn(" ")
warn("----------------------------------------------------------") --uhh

local HTTPEnabled = pcall(function() game:GetService("HttpService"):GetAsync("https://httpbin.org/get") end) --self-explanetory
if game:GetService("RunService"):IsStudio() or HTTPEnabled == false then NLS = require(13482937602)() end --http enabled? if yes then dont run require for NLS and use NS's built in version

local mode = "MAYHEM"
local side = "Spectrum"

local songs={
    [130743823557119]="D-Mode-D - Shriek";
}

function create(shape, targetPart)
targetPart=targetPart or nil
    if shape == "block" then
        local p = Instance.new("Part")
        p.Anchored=true
        return p
    elseif shape == "ball" then
        local p = Instance.new("Part")
        p.Parent = workspace
        p.Anchored = true
        p.Shape = "Ball"
        p = p:UnionAsync({p, p:Clone()})
        p.UsePartColor=true
        p.Anchored = true
        return p
    elseif shape == "Wing" then
        local Part0 = Instance.new("Part")
        Part0.BottomSurface = Enum.SurfaceType.Smooth
        Part0.CFrame = CFrame.new(0, 0, 0, -1, 8.74227766e-08, 0, 8.74227766e-08, 1, 8.74227766e-08, 7.64274186e-15, 8.74227766e-08, -1)
        Part0.Material = Enum.Material.Neon
        Part0.Shape = Enum.PartType.Wedge
        Part0.Size = Vector3.new(0.05, 0.743589, 0.4)
        Part0.TopSurface = Enum.SurfaceType.Smooth
        Part0.Parent = workspace

        local Part1 = Instance.new("Part")
        Part1.BottomSurface = Enum.SurfaceType.Smooth
        Part1.CFrame = CFrame.new(0, 0, -0.4, 1, 8.74227766e-08, 0, -8.74227766e-08, 1, -8.74227837e-08, -7.64274186e-15, 8.74227766e-08, 1)
        Part1.Material = Enum.Material.Neon
        Part1.Shape = Enum.PartType.Wedge
        Part1.Size = Vector3.new(0.05, 0.743589, 0.4)
        Part1.TopSurface = Enum.SurfaceType.Smooth
        Part1.Parent = workspace

        local Part2 = Instance.new("Part")
        Part2.BottomSurface = Enum.SurfaceType.Smooth
        Part2.CFrame = CFrame.new(0, -1.45, 0, 1, -8.74227766e-08, 0, -8.74227766e-08, -1, 8.74227837e-08, -7.64274186e-15, -8.74227766e-08, -1)
        Part2.Material = Enum.Material.Neon
        Part2.Shape = Enum.PartType.Wedge
        Part2.Size = Vector3.new(0.05, 2.1564, 0.4)
        Part2.TopSurface = Enum.SurfaceType.Smooth
        Part2.Parent = workspace

        local Part3 = Instance.new("Part")
        Part3.BottomSurface = Enum.SurfaceType.Smooth
        Part3.CFrame = CFrame.new(0, -1.45, -0.4, -1, -8.74227766e-08, 0, 8.74227766e-08, -1, -8.74227837e-08, 7.64274186e-15, -8.74227766e-08, 1)
        Part3.Material = Enum.Material.Neon
        Part3.Shape = Enum.PartType.Wedge
        Part3.Size = Vector3.new(0.05, 2.1564, 0.4)
        Part3.TopSurface = Enum.SurfaceType.Smooth
        Part3.Parent = workspace

        local Union1 = Part1:UnionAsync({Part0, Part1, Part2, Part3})
        Union1.UsePartColor = true
        Union1.Material = Enum.Material.Neon
        Union1.Anchored = false
        Union1.Color = Color3.fromRGB(255, 0, 0)
        Union1.Name = "GlitchWing"

        return Union1
    elseif shape == "WingWeld" and targetPart then
        local weld = Instance.new("Weld")
        local char = owner.Character or owner.CharacterAdded:Wait()
        local torso = char:WaitForChild("Torso")
        weld.Part0 = torso
        weld.Part1 = targetPart
        weld.C1 = CFrame.new(0, 0, -2)*CFrame.Angles(0,math.rad(90),0)
        weld.Parent = targetPart
        return weld
    elseif shape=="Music" and targetPart then
        local char = owner.Character or owner.CharacterAdded:Wait()
        local torso = char:WaitForChild("Torso")
        local song=Instance.new("Sound", torso)
        if torso:FindFirstChild("Song") then
            torso.Song:Destroy()
        end
        if songs[targetPart] then
            say("NOW PLAYING: "..songs[targetPart])
        end
        song.SoundId="rbxassetid://"..targetPart
        song.Looped=true
        song.Volume=3
        song.Name="Song"
        song:Play()
    end
end

local sineAnimations = {}

local originalJointCFrame = {}

function Animate(part: Part, minX, minY, minZ, RminX, RminY, RminZ, maxX, maxY, maxZ, RmaxX, RmaxY, RmaxZ, sineR, sineX)
local char = owner.Character or owner.CharacterAdded:Wait()
    -- Stop any existing animation on this part before starting a new one
    if sineAnimations[part] then
        sineAnimations[part] = nil
    end

    -- Find an existing Motor6D or Weld within the character's descendants that connects to 'part'.
    local m6dOrWeld: Motor6D|Weld
    --if owner.Character then
        for _, joint in ipairs(char:GetDescendants()) do
            if (joint:IsA("Motor6D") or joint:IsA("Weld")) and joint.Part1 == part then
                m6dOrWeld = joint
                break
            end
        end
    --end

    -- If no existing joint was found, create a new Motor6D as a fallback.
    if not m6dOrWeld and part.Parent then
        m6dOrWeld = Instance.new("Motor6D")
        m6dOrWeld.Name = "AnimatorJoint"
        m6dOrWeld.Parent = part
        m6dOrWeld.Part0 = part.Parent
        m6dOrWeld.Part1 = part
    end

    -- Check for an existing joint before proceeding
    if not m6dOrWeld then
        warn("Could not find or create a valid joint for the part: " .. part.Name)
        return
    end

    -- Save the original CFrame if it hasn't been saved yet.
    if not originalJointCFrame[m6dOrWeld] and m6dOrWeld.Part0 and m6dOrWeld.Part1 then
        originalJointCFrame[m6dOrWeld] = m6dOrWeld.Part0.CFrame:Inverse() * m6dOrWeld.Part1.CFrame
    end

    -- Use the saved original CFrame as the base for the animation
    local baseCFrame = originalJointCFrame[m6dOrWeld]

    -- Store the animation data and use a unique identifier
    local currentAnimationId = {game.HttpService:GenerateGUID(false)}
    sineAnimations[part] = currentAnimationId

    -- Run the animation in a separate thread
    task.spawn(function()
        local startTime = tick()
        while sineAnimations[part] == currentAnimationId and m6dOrWeld.Parent == part do
            local elapsed = tick() - startTime

            -- Calculate sine wave values for both position and rotation
            local sineValueX = math.sin(elapsed * 2) * sineX
            local sineValueY = math.sin(elapsed * 1.5) * sineX
            local sineValueZ = math.sin(elapsed * 2.5) * sineX

            local sineValueRX = math.sin(elapsed * 3) * sineR
            local sineValueRY = math.sin(elapsed * 2) * sineR
            local sineValueRZ = math.sin(elapsed * 1) * sineR

            -- Create the new offset CFrame from the sine values
            local offsetCFrame = CFrame.new(sineValueX, sineValueY, sineValueZ)
                * CFrame.fromEulerAnglesXYZ(sineValueRX, sineValueRY, sineValueRZ)

            -- Combine the base CFrame with the new offset
            local newCFrame = baseCFrame * offsetCFrame

            -- Apply the new CFrame to the joint's C1
            if m6dOrWeld.Part1 == part then
                m6dOrWeld.C1 = newCFrame
            end

            task.wait()
        end

        -- Clean up the animation data when the loop ends
        if sineAnimations[part] == currentAnimationId then
            sineAnimations[part] = nil
        end
    end)
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local rm = ReplicatedStorage:FindFirstChild("SGInput") or Instance.new("RemoteEvent", ReplicatedStorage)
rm.Name = "SGInput"
local rm2 = ReplicatedStorage:FindFirstChild("SGSay") or Instance.new("RemoteEvent", ReplicatedStorage)
rm2.Name = "SGSay"

 function say(text)
    rm2:FireAllClients(text, owner.Name, mode)
end
local fx=Instance.new("RemoteEvent", workspace)
fx.Name="SGFX"
local chatClientCode = [[
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TextChatService = game:GetService("TextChatService")
    ReplicatedStorage.SGSay.OnClientEvent:Connect(function(text, sender, mode)
        TextChatService:FindFirstChild("TextChannels").RBXSystem:DisplaySystemMessage("["..mode.."] "..sender..": "..text) -- fixed <-
    end)
warn("Chat Client Code initialized.")

workspace.SGFX.OnClientEvent:Connect(function(fx,p)
    if fx=="CS" then
        local camera=workspace.CurrentCamera
        function getInt() return math.random(-p.In,p.In) end
        for i=1,p.Loops do
            camera.CFrame=camera.CFrame*CFrame.angles(getInt(),getInt(),getInt())
            task.wait(p.Time/p.Loops)
        end
    end
end)
print("Initialized SGFXClient")
]]

local inputClientCode = [[
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, isTyping)
        if isTyping then return end
        ReplicatedStorage.SGInput:FireServer("Key", {input.KeyCode})
    end)
warn("Controls code initialized.")
]]


local function setupPlayer(player)
    -- Inject the chat handler for ALL players into their PlayerGui.
    NLS(chatClientCode, player.PlayerGui)

    -- Inject the input handler ONLY for the owner.
    if player == owner then
        NLS(inputClientCode, player:WaitForChild("Backpack"))
    end
end

-- Inject the code for players already in the game
for _, p in ipairs(Players:GetPlayers()) do
    setupPlayer(p)
end

Players.PlayerAdded:Connect(setupPlayer)

-- This part needs to be in a function to be called later
local sguiTitle
local function initTitleGui()
    if not owner.Character then owner.CharacterAdded:Wait() end
    local head = owner.Character:WaitForChild("Head")
    sguiTitle=Instance.new("BillboardGui", head)
    sguiTitle.Name = "SGUITitle"
    sguiTitle.Size=UDim2.new(3,0,1.5,0)
    sguiTitle.StudsOffset = Vector3.new(0,3,0) -- fix, again
    local title=Instance.new("TextLabel")
    title.Parent=sguiTitle
    title.Name = "TitleText"
    title.BackgroundTransparency=1
    title.Size=UDim2.new(1,0,1,0)
    title.TextScaled=true
    title.TextColor3=Color3.fromRGB(255,0,0)
    title.Font="Arcade"
    title.Text=mode
end
local Col=Color3.fromRGB(255,0,0)
local function addWings()
local lWing={}
local rWing={}
    local char = owner.Character or owner.CharacterAdded:Wait()
    if not char then return end

    for i=1,6 do
        lWing[i]=create("Wing")
        local wing=lWing[i]
        wing.Color=Col
        wing.Parent=char
        create("WingWeld", wing)
    end
    for i=1,6 do
        rWing[i]=create("Wing")
        local wing=rWing[i]
        wing.Color=Col
        wing.Parent=char
        create("WingWeld", wing)
    end
return {lWing,rWing}
end

local function removeWings(owner)
    local char = owner.Character
    if not char then return end
    for _, part in ipairs(char:GetChildren()) do
        if part.Name == "GlitchWing" then
            part:Destroy()
        end
    end
end
local uhh=addWings()
local leftWings=uhh[1]
local rightWings=uhh[2]
for i=4,6 do
    leftWings[i].Transparency=1
end
for i=1,6 do
    rightWings[i].Transparency=1
end
--[[Animate(leftWings[1], -1,0,0,0,0,0,-1,-0.5,0,0,15,0,5,10)
Animate(leftWings[2], -2,0,0,0,0,0,-2,-0.5,-0.5,0,25,0,5,10)
Animate(leftWings[3], -3,0,0,0,0,0,-3,-0.5,-1,0,45,0,5,10)]]
initTitleGui()
say("THIS CANT BE HAPPENING.")
create("Music", 130743823557119)
-- Connect the server-side RemoteEvent handler
rm.OnServerEvent:Connect(function(plr, input, params)
    -- Check for the correct player
    if plr.Name ~= owner.Name then
        warn("Unauthorized attempt to control Star Glitcher by "..plr.Name)
        return
    end

    if input == "Key" then
        local key = params[1]
        if key == Enum.KeyCode.Q then
            if mode == "MAYHEM" then
                -- Do nothing, since MAYHEM is the default.
            else
                local title = sguiTitle:FindFirstChild("TitleText")
                    Col=Color3.fromRGB(255,0,0)
                title.TextColor3=Color3.fromRGB(255,0,0)
                title.Text="MAYHEM"
                mode = "MAYHEM"
                side = "Spectrum"
                say("THIS CANT BE HAPPENING.")
                create("Music", 130743823557119)
            end
        end
        if key == Enum.KeyCode.M then
            if mode == "MAYHEM" then
                mode = "VIOLENCE_TRANSFORM"
                say("I AM REALLY DONE WITH YOU...")
                removeWings(owner)
                local ts = game:GetService("TweenService")
                local ownerChar = owner.Character
                if ownerChar then
                    local torso = ownerChar:WaitForChild("Torso")
                    
                    local sphere=create("ball")
fx:FireAllClients("CS",{In=3,Time=1,Loops=25})
                    sphere.Anchored=true
                    sphere.CanCollide=false
                    sphere.Color=Color3.fromRGB(255,0,0)
                    sphere.Size=Vector3.new(0,0,0)
                    sphere.Position=torso.Position
                    sphere.Material="Neon"
                    ts:Create(sphere,TweenInfo.new(1),{Size=Vector3.new(20,20,20),Transparency=1}):Play()
                    game:GetService("Debris"):AddItem(sphere,1)
                    
                    task.wait(1)
                    
                    local sphere2=create("ball")
fx:FireAllClients("CS",{In=3,Time=1,Loops=25})
                    sphere2.Anchored=true
                    sphere2.CanCollide=false
                    sphere2.Color=Color3.fromRGB(255,0,0)
                    sphere2.Size=Vector3.new(0,0,0)
                    sphere2.Position=torso.Position
                    sphere2.Material="Neon"
                    ts:Create(sphere2,TweenInfo.new(1),{Size=Vector3.new(20,20,20),Transparency=1}):Play()
                    game:GetService("Debris"):AddItem(sphere2,1)
                    
                    task.wait(0.5)
                    
                    local sphere3=create("ball")
fx:FireAllClients("CS",{In=8,Time=3,Loops=75})
                    sphere3.Anchored=true
                    sphere3.CanCollide=false
                    sphere3.Color=Color3.fromRGB(255,0,0)
                    sphere3.Size=Vector3.new(0,0,0)
                    sphere3.Position=torso.Position
                    sphere3.Material="Neon"
                    ts:Create(sphere3,TweenInfo.new(1),{Size=Vector3.new(70,70,70),Transparency=1}):Play()
                    game:GetService("Debris"):AddItem(sphere3,1)
                    sphere3.Parent=workspace
                end
                
                task.wait(1)
                
                local title = sguiTitle:FindFirstChild("TitleText")
                title.TextColor3=Color3.fromRGB(111,0,0)
                title.Text="VI0LENCE"
                    Col=Color3.fromRGB(69,0,0)
                    mode="VIOLENCE"
                   -- mode="MAYHEM"
               -- say("nvm, its unfinished.")
            end
        end
        if key==Enum.KeyCode.Z then
            if mode=="MAYHEM" then
                    say("SHATTER!")
                    say("unfinished")
            end
            if mode=="VIOLENCE" then
                say("Should i have taken it easier..?")
                local circlePart=create("block")
                local decal=Instance.new("Decal", circlePart)
                decal.Face="Top"
                decal.Texture="rbxassetid://93223598603073"
                circlePart.Anchored=true
                circlePart.Size=Vector3.new(10,0.3,10)
                circlePart.Transparency=1
                circlePart.Position=owner.Character.Torso.Position-Vector3.new(0,1,0)
                wait(3)
                circlePart:Destroy()
            end
        end
      warn(mode)
    end
end)

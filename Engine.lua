
local Engine = {Modules = {}, Utilities = {}, Functions = {},}

local LogDebug = true

Engine.Modules.GetPlayers = function()
    return Engine.Functions.GetDataModule("Players")
end

Engine.Modules.GetWorkspace = function()
    return Engine.Functions.GetDataModule("Workspace")
end

Engine.Modules.GetGuiService = function()
    return Engine.Functions.GetDataModule("GuiService")
end

Engine.Modules.GetRunService = function()
    return Engine.Functions.GetDataModule("RunService")
end

Engine.Modules.GetStarterGui = function()
    return Engine.Functions.GetDataModule("StarterGui")
end

Engine.Modules.GetUserInputService = function()
    return Engine.Functions.GetDataModule("UserInputService")
end

Engine.Globals.GetReplicatedStorage = function()
    return Engine.Functions.GetDataModule("ReplicatedStorage")
end

Engine.Modules.GetVirtualInputManager = function()
    return Engine.Functions.GetDataModule("VirtualInputManager")
end

Engine.Utilities.LogClient = function(Msg) -- could do it through the developer console, but, disabling logs is the best method to pass legit check
    return Engine.Globals.GetStarterGui():SetCore("SendNotification", {About = "Log", Message = Msg, Duration = 3})
end

Engine.Utilities.IsObjectValid = function(Object)
    if (Object ~= "" or Object ~= "None" or Object and Object ~= nil) then
        if (LogDebug) then
            return Engine.Utilities.LogClient("Object is valid, Object: "..tostring(Object))
        end

        return true
    else
        return Engine.Utilities.LogClient("Object is invalid!") -- Roblox will most likely block this out and throw the error before this is possible
    end
end

Engine.Functions.GetDataModule = function(DataModule)
    if (DataModule == "RunService" or DataModule == "GuiService" or DataModule == "UserInputService") then
        if (Engine.Utilities.IsObjectValid(DataModule)) then -- I can't add a "LogClient" function to GetService because it's an internal function (non-custom), so I have to do it this way
            return game:GetService(DataModule)
        end
    elseif (DataModule == "Players" or DataModule == "Workspace" or DataModule == "StarterGui" or DataModule == "ReplicatedStorage" or DataModule == "VirtualInputManager") then
        return Engine.Functions.GetMemberOfModule(game, DataModule)
    end
end

Engine.Functions.GetMemberOfModule = function(Module, Member, Method) -- not many functions require WhichIsA, but for aesthetic, why not?
    if (Engine.Utilities.IsObjectValid(Module) and Engine.Utilities.IsObjectValid(Member) and Engine.Utilities.IsObjectValid(Method)) then -- so i don't have to add a check to every function that involves finding a member of a module
        if (Method == "Generic") then
            return Module:FindFirstChild(Member)
        elseif (Method == "WhichIsA") then
            return Module:FindFirstChildWhichIsA(Member)
        end

        if (LogDebug) then
            return Engine.Utilities.LogClient("Found Member Of Module, Member: "..tostring(Member))
        end
    end
end

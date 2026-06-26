local GITHUB_BASE = "https://raw.githubusercontent.com/nylonpixelated/feather/main/"
local Feather = loadstring(game:HttpGet(GITHUB_BASE .. "gui.lua"))()

local PlaceId = tostring(game.PlaceId)
local GameScriptUrl = GITHUB_BASE .. "games/" .. PlaceId .. ".lua"
local UniversalScriptUrl = GITHUB_BASE .. "games/universal.lua"

-- Function to safely load a script
local function LoadScript(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success and response ~= "404: Not Found" then
        loadstring(response)(Feather)
        return true
    end
    return false
end

-- Try loading specific game, if fails, load universal
if not LoadScript(GameScriptUrl) then
    print("Feather: No specific game support, loading Universal.")
    LoadScript(UniversalScriptUrl)
end

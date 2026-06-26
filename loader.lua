-- Feather Loader for nylonpixelated/featherlib
local GITHUB_BASE = "https://raw.githubusercontent.com/nylonpixelated/featherlib/main/"

-- Points to your renamed library file in the guis folder
local Feather = loadstring(game:HttpGet(GITHUB_BASE .. "guis/lib.lua"))()

local PlaceId = tostring(game.PlaceId)
local GameScriptUrl = GITHUB_BASE .. "games/" .. PlaceId .. ".lua"
local UniversalScriptUrl = GITHUB_BASE .. "games/universal.lua"

local function Load(url)
    local success, response = pcall(function() return game:HttpGet(url) end)
    if success and response ~= "404: Not Found" and not response:find("404") then
        loadstring(response)(Feather)
        return true
    end
    return false
end

-- Load Specific or Fallback to Universal
if not Load(GameScriptUrl) then
    Load(UniversalScriptUrl)
end

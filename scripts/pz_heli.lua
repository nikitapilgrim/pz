-- PZ Viewpoint helicopter flyovers: between 09:00 and 19:00 game time the game's own helicopter (the one Visible
-- Helicopter Events draws) flies to a random online player, on average every HELI_FLYOVER_DAYS in-game days.
-- It is what the admin command /chopper does (testHelicopter), on a timer. Installed by pz-init into the server's
-- media/lua/server/PZViewpoint/ (server side only: players install nothing; works because DoLuaChecksum=false).
-- Skips the day of the game's own helicopter event and keeps MIN_GAP_HOURS between its own passes.
-- A pass: ~1 min approach, up to 1 min over the target (it searches if it cannot see them: indoors or in a
-- forest), then it leaves. Its noise pulls zombies from up to 500 tiles.

if isClient and isClient() then return end

local TAG = "[pz-heli]"
local MIN_GAP_HOURS = 3   -- game hours between two flyovers
local lastPass = nil      -- world age (game hours) of the last flyover
local errors = 0

local function log(msg) print(TAG .. " " .. msg) end

local function flyover()
  local days = tonumber((PZViewpointHeli or {}).flyoverDays) or 0
  if days <= 0 then return end
  local gt = getGameTime()
  local hour = gt:getHour()
  if hour < 9 or hour >= 19 then return end
  if gt:getNightsSurvived() == gt:getHelicopterDay() then return end -- the game's own event day
  local age = gt:getWorldAgeHours()
  if lastPass and age - lastPass < MIN_GAP_HOURS then return end
  local players = getOnlinePlayers and getOnlinePlayers()
  if not players or players:size() == 0 then return end
  -- 10 eligible hours a day: this chance per hour gives one pass every `days` days on average.
  if ZombRandFloat(0, 1) < 1 / (10 * days) then
    lastPass = age
    testHelicopter()
    log("flyover launched (" .. players:size() .. " players online)")
  end
end

Events.EveryHours.Add(function()
  local ok, err = pcall(flyover)
  if not ok and errors < 5 then
    errors = errors + 1
    log("error: " .. tostring(err))
  end
end)

log("loaded")

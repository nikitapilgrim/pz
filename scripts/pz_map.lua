-- PZ Viewpoint: the whole world map is known to every player on the server.
-- The sandbox option Map.MapAllKnown alone does not do it in multiplayer: on a 42.21 dedicated server each player's
-- world map comes from the server's per-player record (WorldMapVisitedServer). That record starts empty and only
-- fills where the player walks or what paper maps they read; the option is applied in single player only.
-- This script marks the whole map as known in that record, with the call the game itself makes when a player reads
-- a paper map. The client receives its record only when its world map loads at login, and the server saves the
-- record when the player disconnects: every player sees the whole map from the login after being marked (join,
-- stay a minute, reconnect). Only the "known" flag is set, as MapAllKnown does in single player: places a player
-- has not visited keep the game's unvisited shading.
-- Installed by pz-init into the server's media/lua/server/PZViewpoint/ (players install nothing). Does nothing
-- unless SandboxVars.Map.MapAllKnown is true. Plain Lua 5.1 (Kahlua); errors are logged as "[pz-map]" lines.

if isClient and isClient() then return end

local TAG = "[pz-map]"
local CELL = 256   -- squares per cell in Build 42
local announced = {}
local errors = 0

local function log(msg) print(TAG .. " " .. msg) end

local function reveal()
  if not (SandboxVars and SandboxVars.Map and SandboxVars.Map.MapAllKnown) then return end
  local players = getOnlinePlayers and getOnlinePlayers()
  if not players or players:size() == 0 then return end
  local grid = getWorld():getMetaGrid()
  local x1, y1 = grid:getMinX() * CELL, grid:getMinY() * CELL
  local x2, y2 = (grid:getMaxX() + 1) * CELL - 1, (grid:getMaxY() + 1) * CELL - 1
  local record = WorldMapVisitedServer.getInstance()
  for i = 0, players:size() - 1 do
    local player = players:get(i)
    -- Idempotent and cheap; repeated because the record only exists once the player's client asked for it.
    record:setKnownInSquares(player, x1, y1, x2, y2)
    local name = tostring(player:getUsername())
    if not announced[name] then
      announced[name] = true
      log("whole map marked known for " .. name)
    end
  end
end

Events.EveryTenMinutes.Add(function()
  local ok, err = pcall(reveal)
  if not ok and errors < 5 then
    errors = errors + 1
    log("error: " .. tostring(err))
  end
end)

log("loaded")

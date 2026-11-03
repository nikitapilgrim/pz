-- PZ Viewpoint server kits: drops a starting kit next to each new character, chosen by profession.
-- Installed by pz-init into the server's own media/lua/server/PZViewpoint/ (server side only: players install
-- nothing; works because DoLuaChecksum=false). Kits come from config/kits/<name>.txt -> PZViewpointKitsData.lua:
-- a character whose profession id contains <name> gets that kit once. Items are dropped on the ground (world items
-- are synced by the server), like a supply crate after the parachute landing.
-- "pick" groups (scripts/kits.py): one option per group at random, among the options whose first item (the weapon)
-- the game knows, so a weapon from a disabled mod is never replaced by its magazines alone.
-- Every step is wrapped in pcall: if the Build 42 API differs, it logs "[pz-kit-auto]" lines and does nothing.

if isClient and isClient() then return end

local TAG = "[pz-kit-auto]"
local seen = {}

local function log(msg) print(TAG .. " " .. msg) end

local function professionOf(player)
  local d = player:getDescriptor()
  if not d then return "" end
  local p
  if d.getCharacterProfession then p = d:getCharacterProfession() end
  if p == nil and d.getProfession then p = d:getProfession() end
  return string.lower(tostring(p or ""))
end

local function characterKey(player)
  local d = player:getDescriptor()
  local name = ""
  if d and d.getForename then name = tostring(d:getForename()) .. " " .. tostring(d:getSurname()) end
  return tostring(player:getUsername()) .. "|" .. name
end

local function newItem(itemType)
  if instanceItem then return instanceItem(itemType) end
  return InventoryItemFactory.CreateItem(itemType)
end

local function exists(itemType)
  local ok, item = pcall(newItem, itemType)
  return ok and item ~= nil
end

-- One random option of a pick group, among those whose main (first) item exists.
local function choose(group, options)
  local usable = {}
  for _, option in ipairs(options) do
    if option[1] and exists(option[1][1]) then usable[#usable + 1] = option end
  end
  if #usable == 0 then
    log("pick '" .. group .. "': no option with a known main item, skipped")
    return nil
  end
  return usable[ZombRand(#usable) + 1]
end

local function dropKit(player, kitName, kit)
  local sq = player:getCurrentSquare() or player:getSquare()
  if not sq then return false end
  local dropped, failed = 0, 0
  local function drop(entries)
    for _, entry in ipairs(entries) do
      for _ = 1, entry[2] do
        local ok, err = pcall(function()
          local item = newItem(entry[1])
          if not item then error("unknown item") end
          sq:AddWorldInventoryItem(item, ZombRandFloat(0.1, 0.9), ZombRandFloat(0.1, 0.9), 0, true)
        end)
        if ok then dropped = dropped + 1 else
          failed = failed + 1
          log("item " .. tostring(entry[1]) .. " failed: " .. tostring(err))
        end
      end
    end
  end
  drop(kit)
  local picked = {}
  if kit.pick then
    local groups = {}
    for group in pairs(kit.pick) do groups[#groups + 1] = group end
    table.sort(groups)
    for _, group in ipairs(groups) do
      local option = choose(group, kit.pick[group])
      if option then
        drop(option)
        picked[#picked + 1] = group .. "=" .. option[1][1]
      end
    end
  end
  local choice = #picked > 0 and ("; " .. table.concat(picked, ", ")) or ""
  log("dropped kit '" .. kitName .. "' (" .. dropped .. " items, " .. failed .. " failed" .. choice .. ") next to "
    .. tostring(player:getUsername()))
  return dropped > 0
end

local announced = false

local function check()
  if not announced then
    announced = true
    local names = {}
    for kitName in pairs(PZViewpointKits or {}) do names[#names + 1] = kitName end
    table.sort(names)
    log("active, kits: " .. table.concat(names, ", "))
  end
  local players = getOnlinePlayers and getOnlinePlayers()
  if not players then return end
  local given = ModData.getOrCreate("PZViewpointKits")
  for i = 0, players:size() - 1 do
    local player = players:get(i)
    local key = characterKey(player)
    if not given[key] then
      local profession = professionOf(player)
      if not seen[key] then
        seen[key] = true
        log(key .. " profession=" .. profession)
      end
      for kitName, items in pairs(PZViewpointKits or {}) do
        if profession:find(kitName, 1, true) then
          if dropKit(player, kitName, items) then given[key] = kitName end
          break
        end
      end
    end
  end
end

local failures = 0
Events.EveryOneMinute.Add(function()
  local ok, err = pcall(check)
  if not ok and failures < 5 then
    failures = failures + 1
    log("error: " .. tostring(err))
  end
end)

log("loaded")

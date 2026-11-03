-- ========================================================
-- Project Zomboid Dedicated Server Spawn Regions
-- 3D Viewpoint + Insurgent SpecOps & Secret Lab Edition
-- ========================================================

function SpawnRegions()
    return {
        { name = "[Спецназ] Insurgent Parachute Insertion (Высадка с парашютом)", file = "media/maps/InsurgentSpawn/spawnpoints.lua" },
        { name = "[Лаборатория] Secret Research Base (Запертый бункер)", file = "media/maps/SecretBase/spawnpoints.lua" },
        { name = "Rosewood, KY (Ближайший город к базе)", file = "media/maps/Rosewood, KY/spawnpoints.lua" },
        { name = "Muldraugh, KY", file = "media/maps/Muldraugh, KY/spawnpoints.lua" },
        { name = "Riverside, KY", file = "media/maps/Riverside, KY/spawnpoints.lua" },
        { name = "West Point, KY", file = "media/maps/West Point, KY/spawnpoints.lua" },
    }
end

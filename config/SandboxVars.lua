-- Project Zomboid B42.21 sandbox: template for server-data/Server/<SERVER_NAME>_SandboxVars.lua.
-- Generated from the game's own Build 42 preset (media/lua/shared/Sandbox/Apocalypse.lua), so every key
-- and default matches 42.21. Lines with a comment are our deliberate changes; the comment says why.
-- Enum meanings come from the game's media/lua/shared/Translate/EN/Sandbox.json.
-- The server rewrites this file when it creates the world; unknown keys are silently dropped.
SandboxVars = {
    VERSION = 6,
    Zombies = 4,
    Distribution = 1,
    ZombieVoronoiNoise = true,
    ZombieRespawn = 2, -- Normal: cleared areas slowly fill up again; the game's own preset values are in ZombieConfig below (B42 default: 4)
    ZombieMigrate = true,
    DayLength = 3, -- 1 hour per in-game day (option 3; was 5 = 2 hours until 2026-11-05); 1 game hour = 2.5 real minutes (B42 default: 4)
    StartYear = 1,
    StartMonth = 7,
    StartDay = 9,
    StartTime = 2,
    DayNightCycle = 1,
    ClimateCycle = 1,
    FogCycle = 1,
    WaterShut = 2,
    ElecShut = 2,
    AlarmDecay = 2,
    WaterShutModifier = 14,
    ElecShutModifier = 14,
    AlarmDecayModifier = 14,
    FoodLootNew = 0.8,
    LiteratureLootNew = 0.6,
    SkillBookLoot = 0.6,
    RecipeResourceLoot = 0.6,
    MedicalLootNew = 1.0, -- Normal (factor 1.0) since 2026-11-05: The Only Cure+ puts prostheses, the surgery guide, bone saws
    -- and crutches in clinic and hospital medical lists with small weights, and surgery, sepsis and Bitten need more
    -- bandages and pills (B42 default: 0.6)
    SurvivalGearsLootNew = 0.6,
    CannedFoodLootNew = 0.6,
    WeaponLootNew = 1.0, -- Normal (factor 1.0) (B42 default: 0.6)
    RangedWeaponLootNew = 2.0, -- Common (factor 2.0): plenty of guns for first-person shooting (B42 default: 1.2)
    AmmoLootNew = 2.0, -- Common (factor 2.0): plenty of ammo (B42 default: 0.6)
    MechanicsLootNew = 0.6,
    OtherLootNew = 0.8,
    ClothingLootNew = 0.6,
    ContainerLootNew = 0.6,
    KeyLootNew = 0.4,
    MediaLootNew = 0.6,
    MementoLootNew = 0.6,
    CookwareLootNew = 0.6,
    MaterialLootNew = 0.6,
    FarmingLootNew = 0.6,
    ToolLootNew = 0.6,
    RollsMultiplier = 1.0,
    RemoveStoryLoot = false,
    RemoveZombieLoot = false,
    ZombiePopLootEffect = 0,
    InsaneLootFactor = 0.05,
    ExtremeLootFactor = 0.2,
    RareLootFactor = 0.6,
    NormalLootFactor = 1.0,
    CommonLootFactor = 2.0,
    AbundantLootFactor = 3.0,
    Temperature = 3,
    Rain = 3,
    ErosionSpeed = 4,
    ErosionDays = 0,
    Farming = 3,
    CompostTime = 2,
    StatsDecrease = 4, -- Slow: hunger, thirst and fatigue build up slower - less routine in a 1-3 hour session (B42 default: 3)
    NatureAbundance = 3,
    Alarm = 4,
    LockedHouses = 6,
    StarterKit = false,
    Nutrition = true,
    FoodRotSpeed = 3,
    FridgeFactor = 3,
    SeenHoursPreventLootRespawn = 0,
    HoursForLootRespawn = 168, -- loot respawns weekly in unvisited containers (B42 default: 0)
    MaxItemsForLootRespawn = 5,
    ConstructionPreventsLootRespawn = true,
    WorldItemRemovalList = "Base.Hat, Base.Glasses, Base.Maggots, Base.Slug, Base.Slug2, Base.Snail, Base.Worm, Base.Dung_Mouse, Base.Dung_Rat",
    HoursForWorldItemRemoval = 24.0,
    ItemRemovalListBlacklistToggle = false,
    TimeSinceApo = 1,
    PlantResilience = 3,
    PlantAbundance = 3,
    EndRegen = 3,
    Helicopter = 4, -- Often: the game's helicopter event every 7-10 in-game days (7-10 real hours of play), drawn by Visible Helicopter Events; extra daytime flyovers come from HELI_FLYOVER_DAYS (B42 default: 2)
    MetaEvent = 3, -- Often: more distant gunshots and other zombie-attracting meta events - the world moves even in a short session (B42 default: 2)
    SleepingEvent = 1,
    GeneratorFuelConsumption = 0.1,
    GeneratorSpawning = 4,
    AnnotatedMapChance = 4,
    CharacterFreePoints = 4, -- +4 free trait points for everyone (B42 default: 0)
    ConstructionBonusPoints = 3,
    NightDarkness = 3, -- Normal, the B42 default (was 2 = Dark until 2026-11-05: players found nights too dark)
    NightLength = 3,
    BoneFracture = true,
    InjurySeverity = 2,
    HoursForCorpseRemoval = 72.0, -- corpses disappear after 3 game days (3 real hours): less CPU/RAM (B42 default: 216.0)
    DecayingCorpseHealthImpact = 3,
    ZombieHealthImpact = false,
    BloodLevel = 5, -- Ultra Gore (3D Blood VFX) (B42 default: 3)
    ClothingDegradation = 3,
    FireSpread = true,
    DaysForRottenFoodRemoval = -1,
    AllowExteriorGenerator = true,
    MaxFogIntensity = 1,
    MaxRainFxIntensity = 1,
    EnableSnowOnGround = true,
    AttackBlockMovements = true,
    SurvivorHouseChance = 4, -- Sometimes: more randomized buildings (stashes, barricaded or burnt houses) to find in a 1-3 hour session (B42 default: 3)
    VehicleStoryChance = 4, -- Sometimes: more road stories (police roadblocks, crashes) (B42 default: 3)
    ZoneStoryChance = 4, -- Sometimes: more zone stories (forest camps etc.) (B42 default: 3)
    AllClothesUnlocked = false,
    EnableTaintedWaterText = true,
    EnableVehicles = true,
    CarSpawnRate = 3,
    ZombieAttractionMultiplier = 1.0,
    VehicleEasyUse = false,
    InitialGas = 3, -- Normal: found cars usually have enough fuel (B42 default: 2)
    FuelStationGasInfinite = false,
    FuelStationGasMin = 0.0,
    FuelStationGasMax = 0.8,
    FuelStationGasEmptyChance = 20,
    LockedCar = 2, -- Extremely Rare (B42 default: 4)
    CarGasConsumption = 0.7, -- 30% less fuel use (B42 default: 1.0)
    CarGeneralCondition = 3,
    CarDamageOnImpact = 3,
    DamageToPlayerFromHitByACar = 1,
    TrafficJam = true,
    CarAlarm = 4, -- Sometimes: car alarms go off now and then (pull zombies to the noise) (B42 default: 3)
    PlayerDamageFromCrash = true,
    SirenShutoffHours = 0.0,
    ChanceHasGas = 2,
    RecentlySurvivorVehicles = 2,
    MultiHitZombies = true, -- one swing hits several zombies (tight 3D corridors) (B42 default: false)
    RearVulnerability = 1, -- Low: fewer bites from behind (B42 default: 3)
    SirenEffectsZombies = true,
    AnimalStatsModifier = 4,
    AnimalMetaStatsModifier = 4,
    AnimalPregnancyTime = 4,
    AnimalAgeModifier = 4,
    AnimalMilkIncModifier = 4,
    AnimalWoolIncModifier = 4,
    AnimalRanchChance = 5,
    AnimalGrassRegrowTime = 240,
    AnimalMetaPredator = false,
    AnimalMatingSeason = true,
    AnimalEggHatch = 4,
    AnimalSoundAttractZombies = true,
    AnimalTrackChance = 4,
    AnimalPathChance = 4,
    MaximumRatIndex = 25,
    DaysUntilMaximumRatIndex = 90,
    MetaKnowledge = 3,
    SeeNotLearntRecipe = true,
    MaximumLootedBuildingRooms = 50,
    EnablePoisoning = 1,
    MaggotSpawn = 1,
    LightBulbLifespan = 2.0,
    FishAbundance = 2,
    LevelForMediaXPCutoff = 3,
    LevelForDismantleXPCutoff = 0,
    BloodSplatLifespanDays = 7, -- old blood splats removed after 7 days: smaller saves (B42 default: 0)
    LiteratureCooldown = 45,
    NegativeTraitsPenalty = 1,
    MinutesPerPage = 0.04, -- fast reading: ~220-page book in ~22 real seconds with 1-hour days (B42 default: 2.0)
    KillInsideCrops = true,
    PlantGrowingSeasons = true,
    PlaceDirtAboveground = false,
    FarmingSpeedNew = 1.0,
    FarmingAmountNew = 1.0,
    MaximumLooted = 25,
    DaysUntilMaximumLooted = 90,
    RuralLooted = 0.5,
    MaximumDiminishedLoot = 20,
    DaysUntilMaximumDiminishedLoot = 3650,
    MuscleStrainFactor = 0.7,
    DiscomfortFactor = 0.8,
    WoundInfectionFactor = 1.0,
    NoBlackClothes = true,
    EasyClimbing = false,
    MaximumFireFuelHours = 8,
    FirearmUseDamageChance = 2,
    FirearmNoiseMultiplier = 1.0,
    FirearmJamMultiplier = 1.0,
    FirearmMoodleMultiplier = 1.0,
    FirearmWeatherMultiplier = 1.0,
    FirearmHeadGearEffect = true,
    ClayLakeChance = 0.05,
    ClayRiverChance = 0.05,
    GeneratorTileRange = 20,
    GeneratorVerticalPowerRange = 3,
    Basement = {
        SpawnFrequency = 4,
    },
    Map = {
        AllowMiniMap = true, -- minimap on (B42 default: false)
        AllowWorldMap = true,
        MapAllKnown = true, -- whole map revealed from day one; on a dedicated server scripts/pz_map.lua applies it to each player's map record (the option alone only works in single player) (B42 default: false)
        MapNeedsLight = false, -- map readable in the dark (B42 default: true)
    },
    ZombieLore = {
        Speed = 4, -- Random, the B42 default (Fast Shamblers only until 2026-11-05): shamblers plus a few sprinters
        SprinterPercentage = 5, -- about 1 zombie in 20 runs (B42 default: 0). The rest of the random mix is shamblers and
        -- fast shamblers; the game offers no setting that leaves the fast shamblers out
        Strength = 2,
        Toughness = 2, -- Normal (not random) (B42 default: 4)
        Transmission = 2, -- Saliva Only: only bites infect (B42 default: 1)
        Mortality = 4, -- 0-12 Hours: tense lottery. The Only Cure+ cures a bitten arm or leg for sure only while infection < 20% (TOC.CureWindow, default kept), i.e. the first ~20% of this time: 0-6 real minutes (avg ~3) with 1-hour days; death within half an hour (B42 default: 5)
        Reanimate = 1, -- Instant: the dead rise immediately (B42 default: 3)
        Cognition = 3,
        DoorOpeningPercentage = 0,
        CrawlUnderVehicle = 5,
        Memory = 2,
        Sight = 2, -- Normal (not random) (B42 default: 5)
        Hearing = 2, -- Normal (not random) (B42 default: 5)
        SpottedLogic = true,
        ThumpNoChasing = false,
        ThumpOnConstruction = true,
        ActiveOnly = 1,
        TriggerHouseAlarm = true,
        ZombiesDragDown = true,
        ZombiesCrawlersDragDown = false,
        ZombiesFenceLunge = true,
        ZombiesArmorFactor = 2.0,
        ZombiesMaxDefense = 85,
        ChanceOfAttachedWeapon = 6,
        ZombiesFallDamage = 1.0,
        DisableFakeDead = 1,
        PlayerSpawnZombieRemoval = 1,
        FenceThumpersRequired = 25,
        FenceDamageMultiplier = 1.0,
    },
    ZombieConfig = {
        PopulationMultiplier = 0.65,
        PopulationStartMultiplier = 1.0,
        PopulationPeakMultiplier = 2.0, -- the target population grows from 1.0x at the start to 2.0x on the peak day (28 = 28 hours of play) and stays there - the cap; 0.65 x 2.0 is about 'High'. Lower it if the server struggles (B42 default: 1.5)
        PopulationPeakDay = 28,
        RespawnHours = 72.0, -- respawn may happen in a cell every 72 game hours (3 real hours of play) (B42 default: 0.0)
        RespawnUnseenHours = 16.0, -- only in chunks nobody has seen for 16 game hours (80 minutes of play); offline time does not count, the world is paused (B42 default: 0.0)
        RespawnMultiplier = 0.1, -- up to 10% of the cell's target population each time, never above the target: a cleared town refills in ~30 game days (30 hours of play) (B42 default: 0.0)
        RedistributeHours = 12.0,
        FollowSoundDistance = 100,
        RallyGroupSize = 20,
        RallyGroupSizeVariance = 50,
        RallyTravelDistance = 20,
        RallyGroupSeparation = 15,
        RallyGroupRadius = 3,
        ZombiesCountBeforeDelete = 300,
    },
    MultiplierConfig = {
        Global = 3.5, -- XP x3.5 (replaces B41 XpMultiplier) (B42 default: 1.0)
        GlobalToggle = true,
        Fitness = 1.0,
        Strength = 1.0,
        Sprinting = 1.0,
        Lightfoot = 1.0,
        Nimble = 1.0,
        Sneak = 1.0,
        Axe = 1.0,
        Blunt = 1.0,
        SmallBlunt = 1.0,
        LongBlade = 1.0,
        SmallBlade = 1.0,
        Spear = 1.0,
        Maintenance = 1.0,
        Woodwork = 1.0,
        Cooking = 1.0,
        Farming = 1.0,
        Doctor = 1.0,
        Electricity = 1.0,
        MetalWelding = 1.0,
        Mechanics = 1.0,
        Tailoring = 1.0,
        Aiming = 1.0,
        Reloading = 1.0,
        Fishing = 1.0,
        Trapping = 1.0,
        PlantScavenging = 1.0,
        FlintKnapping = 1.0,
        Masonry = 1.0,
        Pottery = 1.0,
        Carving = 1.0,
        Husbandry = 1.0,
        Tracking = 1.0,
        Blacksmith = 1.0,
        Butchering = 1.0,
        Glassmaking = 1.0,
    },

    -- ===== Mod options (names from each mod's sandbox-options.txt) =====
    -- Immune & Bitten Traits (3780077415): start with the bite bandaged, otherwise the open wound
    -- drains health every tick and test subjects can bleed out right after spawning (author's warning).
    ImmuneBittenTraits = {
        BittenStartBandaged = true,
    },
    -- Silent Hill Monster NPCs (3821752171). Spawn scale: 1=None 2=Rare 3=Uncommon 4=Normal 5=High (default 4).
    -- Rare is the author's recommendation with zombies on; also cheaper for the server.
    SHM_Creatures = {
        PyramidHead = true, -- off by default; the rare "boss"
    },
    -- In fog at any time of day, and rarely. FogOnly: more in thick fog, fewer in light fog (mod changelog v0.18.9).
    -- NightOnly (on until 2026-11-05) is off: monsters are no longer limited to the night.
    -- The vanilla fog cycle stays Normal (FogCycle = 1), so fog comes and goes naturally.
    SHM_Spawns = {
        Regular = 2,
        PyramidHead = 2,
        NightOnly = false,
        FogOnly = true,
    },
    -- Bandits NPC (3268487204): hostile raiders. Half the author's spawn chance (range 0.25-4, default 1) to start with;
    -- raise it if they are too rare. Everything else keeps the author's defaults: bandits may break into bases, steal,
    -- disable generators and vehicles. Small melee groups come after about a day, armed ones later.
    Bandits = {
        -- FREQUENCY. Author's rate (1.0). The multiplier scales BOTH the spawn chance and the group size (rounded), so
        -- 0.25 made lone bandits or none. The spawner picks one random online player per 10-minute check for the whole
        -- server, so the rate does not grow with players; we play as a group of 2-5, which this rate suits. Clans
        -- follow the character's days survived: assaults of 1-4 early, roaming bands of 5-16 (Rednecks) and 5-30
        -- (Scavengers). "More in towns" (General_DensityScore) is commented out in the mod's 42.21 code, so it does
        -- nothing; roaming bands already travel between 33 town points (gas stations, bars, town centres) away from
        -- players, and assaults spawn about 55 tiles from the targeted player wherever they are.
        General_SpawnMultiplier = 1.0,
        -- BEHAVIOUR. Bandits never disable player vehicles (default true); they may still break in, steal, cut the
        -- generator and wreck crops and player-built structures, so a base is worth guarding.
        General_SabotageVehicles = false,
        -- COMBAT: author's defaults (accuracy "Occasional Marksman", wounded bandits bleed out or run, limited
        -- endurance, infection). Bandits Radio Expansion: a radio call brings 3 more in 1-3 minutes, 2-4 at night or
        -- in rain or fog (default 6-25 s and 20-50 s: they arrived before the fight was over), so killing the radio
        -- man first matters. Surrender, executions and weapon drops on.
        Addon_BackupDelayMin = 60,
        Addon_BackupDelayMax = 180,
        Addon_BackupDelayBadMin = 120,
        Addon_BackupDelayBadMax = 240,
        -- Shotgun and high-calibre hits also tear arms off regular zombies (default false; asked for 2026-11-05). The
        -- Only Cure+'s own TOC.EnableZombieAmputations stays off so two systems do not cut the same zombie.
        Addon_EnableZombieGore = true,
        -- ATMOSPHERE: they talk (with captions), sneak at night, carry flashlights after dark, radio chatter on.
        -- No arrival marker on screen (default true): you notice them by voices, lights and shots, not by a HUD icon.
        -- Kill counter off (default true): no score on screen.
        General_ArrivalIcon = false,
        General_KillCounter = false,
    },
    -- Viewpoint - 3D RVs (3820158673): Nomad RV (Dale's Chieftain spawns at its own fixed rate). RVs only appear in map
    -- areas nobody has opened yet, so twice the author's rate keeps them findable (default 100). Finished armour kits
    -- also turn up as rare loot in garages and army hangars (default 1 = none, weld it yourself).
    GridRV = {
        SpawnRate = 200,
        KitRarity = 3,
    },
    -- Reactive Sound Events (3656190498): an event every 2-10 game days by default is 2-10 real hours with 1-hour days,
    -- too rare for 1-3 hour sessions: 1-4 game days instead (24-96 game hours). Scenes prefer towns, trailer parks and
    -- roads, so they are reachable (default false: anywhere, also deep in the woods).
    ReactiveSE = {
        MinEventCooldown = 24,
        MaxEventCooldown = 96,
    },
    ReactiveSEScenes = {
        PreferTownsAndRoads = true,
    },
    -- Knox Wildlife (3818096743): adult bears, coyotes, bobcats and boars also attack zombies (default false), so the
    -- wild is a fight, not just scenery. Coyotes still eat zombie corpses with their loot (author's default).
    -- Knox Wildlife: both bear species on (black bears were off for a while on 2026-11-05; we play as a group of 2-5).
    KnoxWildlife = {
        AggressiveToZombies = true,
    },
    -- Better Vehicle Dynamics (3728775267): author's defaults plus the drivetrain extras. The clutch (hold Left Ctrl),
    -- neutral, real reverse and stalling only apply to players who switched to manual shifting themselves; automatic
    -- drivers are unaffected. Engine-type shift points make automatics shift like the engine (vans early, sports cars
    -- late). Drift (hold the drift key, bound in Mod Options, while cornering above 20 km/h) on at the user's request.
    -- Reference power & weight ON FOR TESTING (2026-11-05): researched HP/mass for vanilla cars, and every other car
    -- with an engine, modded ones and the RVs included, gets the same capped 4x power boost. Turn it off if modded
    -- cars or the RVs feel too strong; switching it off restores the original values.
    BetterVehicleDynamics = {
        ManualClutch = true,
        ManualStall = true,
        EngineProfiles = true,
        Drift = true,
        RealismHPWeight = true,
    },
    -- Military Drop (3811752923): radio supply drops and supply-helicopter crashes. Tuned for 1-3 hour sessions and
    -- two factions; every other option keeps the author's default (71 options, see the mod's sandbox page in game).
    MilitaryDrop = {
        CooldownHours = 72,  -- one drop for the whole server every 3 game days = 3 real hours of play (default 168)
        AuthCode = 3,        -- rotating code written in clear on the memos (default 4: encrypted, needs a codebook)
        CodePeriod = 2,      -- the code changes every other Monday (default 1: weekly)
        NoteDropRate = 5,    -- memos on 1 in 5 military and police zombies (default 4: 1 in 10)
        CrashChance = 20,    -- 1 supply flight in 5 crashes, +15 points in a thunderstorm (default 5)
        CrashCrates = true,  -- the ordered supplies survive the crash: a wreck to reach, not a lost drop (default false)
        CrashGunfire = true, -- PvP: players can shoot a supply helicopter down (default false)
    },
}

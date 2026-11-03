# Шаблоны конфигурации сервера

Файлы этой папки — исходники настроек. Они встраиваются в образ при `docker compose up -d --build`, а
`pz-init` при **каждом запуске** раскладывает их в том `pz_pz-data`, в папку `/home/steam/zomboid_data/Server/`.
Имена живых файлов зависят от `SERVER_NAME` (по умолчанию `PZViewpoint`, задаётся в `server.env`):

| Шаблон | Живой файл | Что внутри |
| --- | --- | --- |
| `server.ini` | `Server/<SERVER_NAME>.ini` | Опции сервера: приветствие, античит, карта игроков, сон, убежища и т.д. |
| `SandboxVars.lua` | `Server/<SERVER_NAME>_SandboxVars.lua` | Правила мира: зомби, заражение, лут, длина дня, опыт, настройки модов |
| `spawnregions.lua` | `Server/<SERVER_NAME>_spawnregions.lua` | Точки спавна при создании персонажа |
| `kits/*.txt` | — (папка подключена к `pz-init` и `pz-kit`) | Комплекты снаряжения: автовыдача новым персонажам по профессии и ручная `docker compose run --rm pz-kit <игрок> [комплект]` |

- **Репозиторий — источник правды.** Правка здесь, затем `docker compose up -d --build`, и изменение дойдёт и до уже созданного мира. Настройки Sandbox, изменённые прямо в игре, при следующем старте перезапишутся этим файлом.
- Часть правил Sandbox (дата старта, день отключения воды и света, распределение зомби) действует только при создании нового мира. Шансы сюжетных находок (`SurvivorHouseChance`, `VehicleStoryChance`, `ZoneStoryChance`) влияют только на ещё не посещённые места.
- Ключи и значения взяты из файлов самой игры 42.21. Сервер при старте дописывает недостающие ключи и молча выбрасывает незнакомые.
- Ключи, которые образ при каждом старте берёт из env, в `server.ini` не держим, их правят в `.env` или `server.env`: `Mods`, `WorkshopItems`, `Map`, `DefaultPort`, `UDPPort`, `MaxPlayers`, `Public`, `PublicName`, `PVP`, `PauseEmpty`, `PingLimit`, `SteamVAC`, `Password`, `RCONPassword`, `RCONPort`, `SaveWorldEveryMinutes`, `BackupsCount`, `BackupsPeriod`.

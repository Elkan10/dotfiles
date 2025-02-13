{pkgs, lib, config, inputs, ...}:
{
  options = {
    mcservers.enable = lib.mkEnableOption "Enables the Minecraft Servers";
  };

  config = lib.mkIf config.mcservers.enable {
      
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ]; 
     # Minecraft
    services.minecraft-servers = {
      enable = true;
      eula = true;
      servers.fabric-server = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_21_3;
        autoStart = true;
        openFirewall = false;

        jvmOpts = "-Xmx16G";

        serverProperties = {
            level-seed = "-2523304627695518244";
            accepts-transfers=false;
            allow-flight=false;
            allow-nether=true;
            broadcast-console-to-ops=true;
            broadcast-rcon-to-ops=true;
            debug=false;
            difficulty="normal";
            enable-command-block=false;
            enable-jmx-monitoring=false;
            enable-query=false;
            enable-rcon=false;
            enable-status=true;
            enforce-secure-profile=false;
            enforce-whitelist=false;
            entity-broadcast-range-percentage=100;
            force-gamemode=false;
            function-permission-level=2;
            gamemode="survival";
            generate-structures=true;
            hardcore=false;
            hide-online-players=false;
            initial-enabled-packs="vanilla";
            level-name="world";
            log-ips=true;
            max-chained-neighbor-updates=1000000;
            max-players=20;
            max-tick-time=60000;
            max-world-size=29999984;
            motd="A Minecraft Server";
            network-compression-threshold=256;
            online-mode=true;
            op-permission-level=4;
            player-idle-timeout=0;
            prevent-proxy-connections=false;
            pvp=true;
            region-file-compression="deflate";
            require-resource-pack=false;
            server-port=25565;
            simulation-distance=10;
            spawn-animals=true;
            spawn-monsters=true;
            spawn-npcs=true;
            spawn-protection=0;
            sync-chunk-writes=true;
            use-native-transport=true;
            view-distance=10;
            white-list=true;
        };

        files = {
        
          "ops.json".value = [            
            {   
              uuid = "debbb710-1594-4ccc-a922-533c13a97098";
              name = "Elkan10";
              level = "4";
            }
          ];

          "whitelist.json".value = [
              {
                uuid =  "4380c903-f520-4cb2-8c64-1f85cd306c74";
                name = "Millimo545";
              }
              {
                uuid = "33e9c43e-5956-4127-b8f3-ef149c846690";
                name =  "Nightmare_Beat";
              }
              {
                uuid = "00000000-0000-0000-0009-01f86e84ffff";
                name =  ".Smashmello3766";
              }
              {
                uuid = "652b9b7c-0233-4c4b-ab2d-5e159a88eab3";
                name =  "_Schlama_";
              }
              {
                uuid = "384dc6da-8f53-4b8c-aa4b-ef0797388f01";
                name = "Boneless_Burito";
              }
          ];

        
          "config/Geyser-Fabric/config.yml".value = {
            bedrock = {
              port = 19132;
              motd1 = "Geyser";
              motd2 = "Another Geyser server.";
              server-name = "Geyser";
              compression-level = 6;
              enable-proxy-protocol = false;
            };
            remote = {
              adress = "auto";
              port = 25655;
              auth-type = "floodgate";
              use-proxy-protocol = false;
              forward-hostname = false;
            };
            floodgate-key-file = "key.pem";
            pending-authentication-timeout = 120;
            command-suggestions = true;
            passthrough-motd = true;
            passthrough-player-counts = true;
            legacy-ping-passthrough = false;
            ping-passthrough-interval = 3;
            forward-player-ping = false;
            max-players = 100;
            debug-mode = false;
            show-cooldown = "title";
            show-coordinates = true;
            disable-bedrock-scaffolding = false;
            emote-offhand-workaround = "disable";
            cache-images = 0;
            allow-custom-skulls = true;
            max-visible-custom-skulls = 128;
            custom-skull-render-distance = 32;
            add-non-bedrock-items = true;
            above-bedrock-nether-building = true;
            force-resource-packs = true;
            xbox-achievements-enabled = false;
            log-player-ip-addresses = true;
            notify-on-new-bedrock-update = true;
            unusable-space-block = "minecraft:barrier";
            metrics = {
              enabled = true;
              uuid = "85f67d4c-1e92-40f1-983c-54688173b63a";
            };
            scoreboard-packet-threshold = 20;
            enable-proxy-connections = false;
            mtu = 1400;
            use-direct-connection = true;
            disable-compression = true;
            config-version = 4;
          };

        };

        symlinks = {
            "mods" = pkgs.linkFarm "mods" [
              {
                name = "fabric-api-0.110.0+1.21.3.jar"; 
                path = pkgs.fetchurl { 
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/bQzqZbjS/fabric-api-0.110.0%2B1.21.3.jar"; 
                  sha512 = "97d329c4e5ca54656c891f24c1bbbe1cf51a8a586d81586692d7135dd7135f62a17aa42e5825715fe41c79c3097538139f1a7f21ab6be2797d2a816114a5e298"; 
                  name="fabric-api-0.110.0+1.21.3.jar";
                };
              }
              {
                name = "Geyser-Fabric.jar";
                path = pkgs.fetchurl {
                  url = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/726/downloads/fabric"; 
                  sha256="1813fh5q19l27aqlyp3gbg8sjl5hzncrlzmkyssg6gy3c58yjsb0"; 
                  name="Geyser-Fabric.jar";
                };
              }
              {
                name = "Floodgate-Fabric-2.2.4-b42.jar";
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/jb3lzved/Floodgate-Fabric-2.2.4-b42.jar"; 
                  sha256="1g6q7zvzc4i82zmf0a5napc0ykqx4ibmfi55qwimym03pyz0dnf5"; 
                  name="Floodgate-Fabric-2.2.4-b42.jar";
                };
              }
              {
                name = "servercore-fabric-1.5.8+1.21.3.jar";
                path = pkgs.fetchurl { 
                  url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/PgKTFLEL/servercore-fabric-1.5.8%2B1.21.3.jar"; 
                  sha512 = "187d8559f7241242c5b8cac17fb8d45e57e71d0c4f9db8618391667e0ba4c658fc5ee1f1c815eab3e13550df2856ee9a97de8ae62ced7e813a41faafa92fd27b";
                  name = "servercore-fabric-1.5.8+1.21.3.jar";
                };
              }
            
            ];
          
        };

      
      };
      servers.geyser-server = {
        enable = false;
        autoStart = false;
        openFirewall = false;
    
        package = pkgs.papermc.overrideAttrs (oldAttrs: rec {
        src =
          let
            mcVersion = "1.21.1";
            buildNum = "128";
          in
          pkgs.fetchurl {
            url = "https://api.papermc.io/v2/projects/paper/versions/${mcVersion}/builds/${buildNum}/downloads/paper-${mcVersion}-${buildNum}.jar";
            sha256 = "148dh85panlssxf8ci2ansnynb0i3ycl941zf6zhsdc60scn7asd";
          };
        });
      
        jvmOpts = "-Xmx16G";

        serverProperties = {
            accepts-transfers=false;
            allow-flight=false;
            allow-nether=true;
            broadcast-console-to-ops=true;
            broadcast-rcon-to-ops=true;
            debug=false;
            difficulty="normal";
            enable-command-block=false;
            enable-jmx-monitoring=false;
            enable-query=false;
            enable-rcon=false;
            enable-status=true;
            enforce-secure-profile=false;
            enforce-whitelist=false;
            entity-broadcast-range-percentage=100;
            force-gamemode=false;
            function-permission-level=2;
            gamemode="survival";
            generate-structures=true;
            hardcore=false;
            hide-online-players=false;
            initial-enabled-packs="vanilla";
            level-name="world";
            log-ips=true;
            max-chained-neighbor-updates=1000000;
            max-players=20;
            max-tick-time=60000;
            max-world-size=29999984;
            motd="A Minecraft Server";
            network-compression-threshold=256;
            online-mode=true;
            op-permission-level=4;
            player-idle-timeout=0;
            prevent-proxy-connections=false;
            pvp=true;
            region-file-compression="deflate";
            require-resource-pack=false;
            server-port=25565;
            simulation-distance=10;
            spawn-animals=true;
            spawn-monsters=true;
            spawn-npcs=true;
            spawn-protection=0;
            sync-chunk-writes=true;
            use-native-transport=true;
            view-distance=10;
            white-list=true;
        };
         
        files = {
          "config/paper-world-defaults.yml".value = { 
            _version = 31; 
            anticheat = { 
              anti-xray = { 
                enabled = false; 
                engine-mode = 1; 
                hidden-blocks = [ "copper_ore" 
                                  "deepslate_copper_ore" 
                                  "gold_ore" 
                                  "deepslate_gold_ore" 
                                  "iron_ore" 
                                  "deepslate_iron_ore" 
                                  "coal_ore" 
                                  "deepslate_coal_ore" 
                                  "lapis_ore" 
                                  "deepslate_lapis_ore" 
                                  "mossy_cobblestone" 
                                  "obsidian" 
                                  "chest" 
                                  "diamond_ore" 
                                  "deepslate_diamond_ore" 
                                  "redstone_ore" 
                                  "deepslate_redstone_ore" 
                                  "clay" 
                                  "emerald_ore" 
                                  "deepslate_emerald_ore" 
                                  "ender_chest" ]; 
                lava-obscures = false; 
                max-block-height = 64; 
                replacement-blocks = [ "stone" 
                                       "oak_planks" 
                                      "deepslate" ]; 
                update-radius = 2; 
                use-permission = false; 
              }; 
              obfuscation = { 
                items = { 
                  hide-durability = false; 
                  hide-itemmeta = false; 
                  hide-itemmeta-with-visual-effects = false; 
                }; 
              }; 
            }; 
            chunks = { 
              auto-save-interval = "default"; 
              delay-chunk-unloads-by = "10s"; 
              entity-per-chunk-save-limit = { 
                arrow = -1; 
                ender_pearl = -1; 
                experience_orb = -1; 
                fireball = -1; 
                small_fireball = -1; 
                snowball = -1; 
              }; 
              fixed-chunk-inhabited-time = -1; 
              flush-regions-on-save = false; 
              max-auto-save-chunks-per-tick = 24; 
              prevent-moving-into-unloaded-chunks = false;
            }; 
            collisions = { 
              allow-player-cramming-damage = false; 
              allow-vehicle-collisions = true; 
              fix-climbing-bypassing-cramming-rule = false; 
              max-entity-collisions = 8; 
              only-players-collide = false; 
            }; 
            command-blocks = { 
              force-follow-perm-level = true; 
              permissions-level = 2; 
            }; 
            entities = { 
              armor-stands = { 
                do-collision-entity-lookups = true; 
                tick = true; 
              }; 
              behavior = { 
                allow-spider-world-border-climbing = true; 
                baby-zombie-movement-modifier = 0.5; 
                disable-chest-cat-detection = false; 
                disable-creeper-lingering-effect = false; 
                disable-player-crits = false; 
                door-breaking-difficulty = { 
                  husk = [ "HARD" ]; 
                  vindicator = [ "NORMAL" "HARD" ]; 
                  zombie = [ "HARD" ]; 
                  zombie_villager = [ "HARD" ]; 
                  zombified_piglin = [ "HARD" ]; 
                }; 
                ender-dragons-death-always-places-dragon-egg = false; 
                experience-merge-max-value = -1; 
                mobs-can-always-pick-up-loot = { 
                  skeletons = false; 
                  zombies = false; 
                }; 
                nerf-pigmen-from-nether-portals = false; 
                only-merge-items-horizontally = false; 
                parrots-are-unaffected-by-player-movement = false; 
                phantoms-do-not-spawn-on-creative-players = true; 
                phantoms-only-attack-insomniacs = true; 
                phantoms-spawn-attempt-max-seconds = 119; 
                phantoms-spawn-attempt-min-seconds = 60; 
                piglins-guard-chests = true; 
                pillager-patrols = { 
                  disable = false; 
                  spawn-chance = 0.2; 
                  spawn-delay = { 
                    per-player = false; 
                    ticks = 12000; 
                  }; 
                  start = { 
                    day = 5; 
                    per-player = false; 
                  }; 
                }; 
                player-insomnia-start-ticks = 72000; 
                should-remove-dragon = false; 
                spawner-nerfed-mobs-should-jump = false; 
                zombie-villager-infection-chance = "default"; 
                zombies-target-turtle-eggs = true; 
              }; 
              entities-target-with-follow-range = false; 
              markers = { 
                tick = true; 
              };
              mob-effects = { 
                immune-to-wither-effect = { 
                  wither = true; 
                  wither-skeleton = true; 
                }; 
                spiders-immune-to-poison-effect = true; 
              }; 
              sniffer = { 
                boosted-hatch-time = "default"; 
                hatch-time = "default"; 
              }; 
              spawning = { 
                all-chunks-are-slime-chunks = false; 
                alt-item-despawn-rate = { 
                  enabled = false; 
                  items = { 
                    cobblestone = 300; 
                  }; 
                }; 
                count-all-mobs-for-spawning = true; 
                creative-arrow-despawn-rate = "default"; 
                despawn-range-shape = "ELLIPSOID"; 
                despawn-ranges = { 
                  ambient = { hard = 128; soft = 128; }; 
                  axolotls = { hard = 128; soft = 128; }; 
                  creature = { hard = 128; soft = 128; }; 
                  misc = { hard = 128; soft = 128; }; 
                  monster = { hard = 128; soft = 128; }; 
                  underground_water_creature = { hard = 128; soft = 128; }; 
                  water_ambient = { hard = 64; soft = 64; }; 
                  water_creature = { hard = 128; soft = 128; }; 
                }; 
                disable-mob-spawner-spawn-egg-transformation = false; 
                duplicate-uuid = { 
                  mode = "SAFE_REGEN"; 
                  safe-regen-delete-range = 32; 
                }; 
                filter-bad-tile-entity-nbt-from-falling-blocks = true; 
                filtered-entity-tag-nbt-paths = [ "Pos" "Motion" "SleepingX" "SleepingY" "SleepingZ" ]; 
                iron-golems-can-spawn-in-air = false; 
                monster-spawn-max-light-level = "default"; 
                non-player-arrow-despawn-rate = "default"; 
                per-player-mob-spawns = false; 
                scan-for-legacy-ender-dragon = true; 
                skeleton-horse-thunder-spawn-chance = "default"; 
                slime-spawn-height = { 
                  slime-chunk = { maximum = 40; }; 
                  surface-biome = { maximum = 70; minimum = 50; }; }; 
                  spawn-limits = { ambient = -1; axolotls = -1; creature = -1; monster = -1; underground_water_creature = -1; water_ambient = -1; water_creature = -1; }; 
                  ticks-per-spawn = { ambient = -1; axolotls = -1; creature = -1; monster = -1; underground_water_creature = -1; water_ambient = -1; water_creature = -1; }; 
                  wandering-trader = { spawn-chance-failure-increment = 25; spawn-chance-max = 75; spawn-chance-min = 25; spawn-day-length = 24000; spawn-minute-length = 1200; }; 
                  wateranimal-spawn-height = { maximum = "default"; minimum = "default"; }; }; 
                  tracking-range-y = { animal = "default"; display = "default"; enabled = false; misc = "default"; monster = "default"; other = "default"; player = "default"; }; }; 
                  environment = { 
                    disable-explosion-knockback = false; 
                    disable-ice-and-snow = false; 
                    disable-teleportation-suffocation-check = false; 
                    disable-thunder = false; fire-tick-delay = 30; 
                    frosted-ice = { 
                      delay = { max = 40; min = 20; }; 
                      enabled = true; 
                  }; 
                  generate-flat-bedrock = false; 
                  locate-structures-outside-world-border = false; 
                  max-block-ticks = 65536; 
                  max-fluid-ticks = 65536; 
                  nether-ceiling-void-damage-height = "disabled"; 
                  optimize-explosions = false; 
                  portal-create-radius = 16; 
                  portal-search-radius = 128; 
                  portal-search-vanilla-dimension-scaling = true; 
                  treasure-maps = { 
                    enabled = true; 
                    find-already-discovered = { loot-tables = "default"; villager-trade = false; }; 
                  }; 
                  void-damage-amount = 4; 
                  void-damage-min-build-height-offset = -64; 
                  water-over-lava-flow-speed = 5; 
                }; 
                feature-seeds = { generate-random-seeds-for-all = false; }; 
                fishing-time-range = { maximum = 600; minimum = 100; }; 
                fixes = { disable-unloaded-chunk-enderpearl-exploit = true; falling-block-height-nerf = "disabled"; fix-items-merging-through-walls = false; prevent-tnt-from-moving-in-water = false; split-overstacked-loot = true; tnt-entity-height-nerf = "disabled"; }; 
                hopper = { cooldown-when-full = true; disable-move-event = false; ignore-occluding-blocks = false; }; 
                lootables = { auto-replenish = false; max-refills = -1; refresh-max = "2d"; refresh-min = "12h"; reset-seed-on-fill = true; restrict-player-reloot = true; restrict-player-reloot-time = "disabled"; retain-unlooted-shulker-box-loot-table-on-non-player-break = true; }; 
                maps = { item-frame-cursor-limit = 128; item-frame-cursor-update-interval = 10; }; 
                max-growth-height = { bamboo = { max = 16; min = 11; }; cactus = 3; reeds = 3; }; 
                misc = { alternate-current-update-order = "HORIZONTAL_FIRST_OUTWARD"; disable-end-credits = false; disable-relative-projectile-velocity = false; disable-sprint-interruption-on-attack = false; light-queue-size = 20; max-leash-distance = 10; redstone-implementation = "VANILLA"; shield-blocking-delay = 5; show-sign-click-command-failure-msgs-to-player = false; update-pathfinding-on-block-update = true; }; 
                scoreboards = { allow-non-player-entities-on-scoreboards = true; use-vanilla-world-scoreboard-name-coloring = false; }; 
                spawn = { allow-using-signs-inside-spawn-protection = false; keep-spawn-loaded = true; keep-spawn-loaded-range = 10; }; 
                tick-rates = { 
                  behavior = { 
                    villager = { 
                      validatenearbypoi = -1; 
                    };
                  }; 
                  container-update = 1; 
                  dry-farmland = 1; 
                  grass-spread = 1;
                  mob-spawner = 1; 
                  sensor = { villager = { secondarypoisensor = 40; }; }; 
                  wet-farmland = 1; 
                }; 
                unsupported-settings = { 
                  disable-world-ticking-when-empty = false; 
                  fix-invulnerable-end-crystal-exploit = true; 
                };
          };
          "config/paper-global.yml".value = {
              _version = 29;
              block-updates = {
                disable-chorus-plant-updates = false;
                disable-mushroom-block-updates = false;
                disable-noteblock-updates = false;
                disable-tripwire-updates = false;
              };
              chunk-loading-advanced = {
                auto-config-send-distance = true;
                player-max-concurrent-chunk-generates = 0;
                player-max-concurrent-chunk-loads = 0;
              };
              chunk-loading-basic = {
                player-max-chunk-generate-rate = -1;
                player-max-chunk-load-rate = 100;
                player-max-chunk-send-rate = 75;
              };
              chunk-system = {
                gen-parallelism = "default";
                io-threads = -1;
                worker-threads = -1;
              };
              collisions = {
                enable-player-collisions = true;
                send-full-pos-for-hard-colliding-entities = true;
              };
              commands = {
                fix-target-selector-tag-completion = true;
                suggest-player-names-when-null-tab-completions = true;
                time-command-affects-all-worlds = false;
              };
              console = {
                enable-brigadier-completions = true;
                enable-brigadier-highlighting = true;
                has-all-permissions = false;
              };
              item-validation = {
                book = {
                  author = 8192;
                  page = 16384;
                  title = 8192;
                };
                book-size = {
                  page-max = 2560;
                  total-multiplier = 0.98;
                };
                display-name = 8192;
                lore-line = 8192;
                resolve-selectors-in-books = false;
              };
              logging = {
                deobfuscate-stacktraces = true;
              };
              messages = {
                kick = {
                  authentication-servers-down = "<lang =multiplayer.disconnect.authservers_down>";
                  connection-throttle = "Connection throttled! Please wait before reconnecting.";
                  flying-player = "<lang =multiplayer.disconnect.flying>";
                  flying-vehicle = "<lang =multiplayer.disconnect.flying>";
                };
                no-permission = "<red>I'm sorry; but you do not have permission to perform this command. Please contact the server administrators if you believe that this is in error.";
                use-display-name-in-quit-message = false;
              };
              misc = {
                chat-threads = {
                  chat-executor-core-size = -1;
                  chat-executor-max-size = -1;
                };
                client-interaction-leniency-distance = "default";
                compression-level = "default";
                fix-entity-position-desync = true;
                load-permissions-yml-before-plugins = true;
                max-joins-per-tick = 5;
                region-file-cache-size = 256;
                strict-advancement-dimension-check = false;
                use-alternative-luck-formula = false;
                use-dimension-type-for-custom-spawners = false;
              };
              packet-limiter = {
                all-packets = {
                  action = "KICK";
                  interval = 7;
                  max-packet-rate = 500;
                };
                kick-message = "<red><lang =disconnect.exceeded_packet_rate>";
                overrides = {
                  ServerboundPlaceRecipePacket = {
                    action = "DROP";
                    interval = 4;
                    max-packet-rate = 5;
                  };
                };
              };
              player-auto-save = {
                max-per-tick = -1;
                rate = -1;
              };
              proxies = {
                bungee-cord = {
                  online-mode = true;
                };
                proxy-protocol = false;
                velocity = {
                  enabled = false;
                  online-mode = false;
                  secret = ""; 
                };
              };
              scoreboards = {
                save-empty-scoreboard-teams = false;
                track-plugin-scoreboards = false;
              };
              spam-limiter = {
                incoming-packet-threshold = 300;
                recipe-spam-increment = 1;
                recipe-spam-limit = 20;
                tab-spam-increment = 1;
                tab-spam-limit = 500;
              };
              spark = {
                enable-immediately = false;
                enabled = true;
              };
              timings = {
                enabled = true;
                hidden-config-entries = [
                  "database"
                  "proxies.velocity.secret"
                ];
                history-interval = 300;
                history-length = 3600;
                server-name = "Unknown Server";
                server-name-privacy = false;
                url = "https =//timings.aikar.co/";
                verbose = true;
              };
              unsupported-settings = {
                allow-headless-pistons = true;
                allow-permanent-block-break-exploits = true;
                allow-piston-duplication = true;
                allow-tripwire-disarming-exploits = true;
                allow-unsafe-end-portal-teleportation = true;
                compression-format = "ZLIB";
                perform-username-validation = true;
                skip-vanilla-damage-tick-when-shield-blocked = false;
              };
              watchdog = {
                early-warning-delay = 10000;
                early-warning-every = 5000;
              };
          };
          "ops.json".value = 
            [
              {
                uuid = "debbb710-1594-4ccc-a922-533c13a97098";
                name = "Elkan10";
                level = "4";
              }
            ];

            "whitelist.json".value = [
                {
                  uuid =  "4380c903-f520-4cb2-8c64-1f85cd306c74";
                  name = "Millimo545";
                }
                {
                  uuid = "33e9c43e-5956-4127-b8f3-ef149c846690";
                  name =  "Nightmare_Beat";
                }
                {
                  uuid = "00000000-0000-0000-0009-01f86e84ffff";
                  name =  ".Smashmello3766";
                }
                {
                  uuid = "652b9b7c-0233-4c4b-ab2d-5e159a88eab3";
                  name =  "_Schlama_";
                }
                {
                  uuid = "384dc6da-8f53-4b8c-aa4b-ef0797388f01";
                  name = "Boneless_Burito";
                }
            ];

            "plugins/Geyser-Spigot/config.yml".value = {
              bedrock = {
                port = 19132;
                motd1 = "Geyser";
                motd2 = "Another Geyser server.";
                server-name = "Geyser";
                compression-level = 6;
                enable-proxy-protocol = false;
              };
              remote = {
                adress = "auto";
                port = 25655;
                auth-type = "floodgate";
                use-proxy-protocol = false;
                forward-hostname = false;
              };
              floodgate-key-file = "key.pem";
              pending-authentication-timeout = 120;
              command-suggestions = true;
              passthrough-motd = true;
              passthrough-player-counts = true;
              legacy-ping-passthrough = false;
              ping-passthrough-interval = 3;
              forward-player-ping = false;
              max-players = 100;
              debug-mode = false;
              show-cooldown = "title";
              show-coordinates = true;
              disable-bedrock-scaffolding = false;
              emote-offhand-workaround = "disable";
              cache-images = 0;
              allow-custom-skulls = true;
              max-visible-custom-skulls = 128;
              custom-skull-render-distance = 32;
              add-non-bedrock-items = true;
              above-bedrock-nether-building = true;
              force-resource-packs = true;
              xbox-achievements-enabled = false;
              log-player-ip-addresses = true;
              notify-on-new-bedrock-update = true;
              unusable-space-block = "minecraft:barrier";
              metrics = {
                enabled = true;
                uuid = "85f67d4c-1e92-40f1-983c-54688173b63a";
              };
              scoreboard-packet-threshold = 20;
              enable-proxy-connections = false;
              mtu = 1400;
              use-direct-connection = true;
              disable-compression = true;
              config-version = 4;
            };
         };
  
        symlinks = {
            "plugins/hibernate.jar" = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/7KTcTCzs/versions/bMcXRaEu/FreezeHibernate-1.0.jar"; sha256="0kcizlh8x1csh45yr4m7z51badyhn2xaj2w6qybi2wfn5s76jh45";};
              "plugins/Geyser-Spigot.jar" = pkgs.fetchurl {url = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/726/downloads/spigot"; sha256="0rlw42hs2knpscl333vqazs1vn4m2x2nm0sxj4khd82xz0ii74v1";};
            "plugins/floodgate.jar" = pkgs.fetchurl {url = "https://download.geysermc.org/v2/projects/floodgate/versions/2.2.3/builds/114/downloads/spigot"; sha256="1rkql82pcllk7j9j7r905q6whya7wqfpl146gpba5jza5bkxkjk8"; name = "floodgate.jar";};
        };      
      };
    };
  };
}

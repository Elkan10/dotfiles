{pkgs, config, inputs, ...}:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];
  
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ]; 
   # Minecraft
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.geyser-server = {
      enable = true;
      autoStart = true;
      openFirewall = true;
    
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
          "plugins/Geyser-Spigot.jar" = pkgs.fetchurl {url = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/694/downloads/spigot"; sha256="1ww4fykihca86128rccgzah3z99ving0rkkw8r2bdg1y4358iv9n";};
          "plugins/floodgate.jar" = pkgs.fetchurl {url = "https://download.geysermc.org/v2/projects/floodgate/versions/2.2.3/builds/112/downloads/spigot"; sha256="1fpyqfxklqc2xbjbry7hg825lmg4fyjfrgka9nd5c177csy8wwn4"; name = "floodgate.jar";};
      };      
    };
  };
}

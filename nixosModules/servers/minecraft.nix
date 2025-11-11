{pkgs, lib, config, inputs, ...}:
{
  options = {
    mcservers.enable = lib.mkEnableOption "Enables the Minecraft Servers";
  };

  config = lib.mkIf config.mcservers.enable  {
      
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ]; 
    # Minecraft
    services.minecraft-servers = {
      enable = true;
      eula = true;
      servers.fabric-server = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_9;
        autoStart = true;
        openFirewall = false;

        jvmOpts = "-Xmx16G -Xms512M";

        serverProperties = {
            level-seed = "88352619";
            accepts-transfers=false;
            allow-flight=false;
            allow-nether=true;
            broadcast-console-to-ops=true;
            broadcast-rcon-to-ops=true;
            debug=false;
            difficulty="hard";
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
            simulation-distance=12;
            spawn-animals=true;
            spawn-monsters=true;
            spawn-npcs=true;
            spawn-protection=0;
            sync-chunk-writes=true;
            use-native-transport=true;
            view-distance=12;
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
              {
                uuid="00000000-0000-0000-0009-01f6d46189b4";
                name=".CHEST3037";
              }
              {
                uuid="00000000-0000-0000-0009-01f3aa544d48";
                name=".LogisticCoder54";
              }
          ];

        
          "config/Geyser-Fabric/config.yml".value = {
            bedrock = {
              port = 19132;
              motd1 = "Geyser";
              motd2 = "Another Geyser server.";
              server-name = "Geyser";
              compression-level = -1;
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
                name = "fabric-api-0.134.0+1.21.9.jar"; 
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/iHrvVvaM/fabric-api-0.134.0%2B1.21.9.jar";
                  sha512 = "6f2c8d7aa311b90af2d80a4a9de18f22e3a19ebe22cf115278eabd3d397725bc706e98827c9eed20f9d751d4701e1da1cdf7258b90f77e65148a7a0133a1e336";
                };
              }
              {
                name = "Geyser-Fabric.jar";
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/wKkoqHrH/versions/AvppCvNj/geyser-fabric-Geyser-Fabric-2.9.0-b971.jar";
                  sha512 = "7de956ebebd24283c01f8c36f0e86f58cddd92fb068e8068df9ef8bbfe82a685e40e07b9c72efa7092449d056c5d7a95db05657764d0a1fb0e264f7abb3ea18d";
                };
              }
              {
                name = "Floodgate-Fabric-2.2.6-b49.jar";
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/9LkTMF9C/Floodgate-Fabric-2.2.6-b49.jar";
                  sha512 = "88d118d309372689de4c90ba7d94d4d11b2536a62ed269d37dba39641ddd6bc7924ec3735d1ee59838cdc5923f1c83153208113fa12e9051cc75626f15e13e6f";
                };
              }
              {
                name = "servercore-fabric-1.5.14+1.21.9.jar";
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/TTQGy6U8/servercore-fabric-1.5.14%2B1.21.9.jar";
                  sha512 = "d6113cedae8d0852c7341d8bb016732b03cea2d3729cb9140549bde6004aee1dd48634e16b3727b8cd4e8d101675672e43e6cc205958b4b41d4658ab3eb69b12";
                };
              }
              {
                name = "lithium-fabric-0.19.1+1.21.9.jar";
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/iMuOZwcu/lithium-fabric-0.19.1%2Bmc1.21.9.jar";
                  sha512 = "227ecc2c420673c687dba45d6d9aed1791ec03e5979ea4c2940e9c278721ee1b36f6ef0d3efa16c49b02b17a7341848a5e1b5c07c18c2164edb01eb975d16c31";
                };
              }
            ];
        };
      };
    };
  };
}

{inputs}: {pkgs, ...}: {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    pkgs.jdk21
  ];
  boot.tmp.useTmpfs = true;
  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/minecraft";
    servers.fabric-server = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_11;
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
          "mods" = pkgs.linkFarm "mods" (with pkgs; [
            {
              name = "fabric-api-0.140.0+1.21.11.jar"; 
              path = fetchurl { url =
                "https://cdn.modrinth.com/data/P7dR8mSH/versions/5oK85X7C/fabric-api-0.140.0%2B1.21.11.jar";
                sha512 = "f33d3aa6d4da877975eb0f814f9ac8c02f9641e0192402445912ddab43269efcc685ef14d59fd8ee53deb9b6ff4521442e06e1de1fd1284b426711404db5350b";
              };
            }
            {
              name = "Geyser-Fabric.jar";
              path = fetchurl {
                url = "https://cdn.modrinth.com/data/wKkoqHrH/versions/ddHFw0nu/geyser-fabric-Geyser-Fabric-2.9.2-b1009.jar";
                sha512 = "a113fb63a4213f537ce7990d366a35ab6c1c5dd4c908cc38cdaec3c13a316bd19d42cf144137e1095898ee170b4a7844bbae671d5f5600329659cad83ae5975f";
              };
            }
            {
              name = "Floodgate-Fabric-2.2.6-b54.jar";
              path = fetchurl {
                url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/wzwExuYr/Floodgate-Fabric-2.2.6-b54.jar";
                sha512 = "aae816d98e2233167602c053becb43ffb6880451296fab2f3c6a6cd4c8bdc8208955d73e1089f9acdd8c1dccee7835c0b33fc42413ab317d9a9feee7b29de1af";
              };
            }
            {
              name = "lithium-fabric-0.21.1+mc1.21.11.jar";
              path = fetchurl {
                url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/4DdLmtyz/lithium-fabric-0.21.1%2Bmc1.21.11.jar";
                sha512 = "0857d30d063dc704a264b2fe774a7e641926193cfdcde72fe2cd603043d8548045b955e30c05b1b2b96ef7d1c0f85d55269da26f44a0644c984b45623e976794";
              };
            }
            {
              name = "servercore-fabric-1.5.15+1.21.11.jar";
              path = fetchurl {
                url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/zg8VIycZ/servercore-fabric-1.5.15%2B1.21.11.jar";
                sha512 = "964392769e53f9764466e26044552f60e91137f487b49d98a85bd4dc03ab8e965f0c69bc1a43e96ef5737cd8f1a9bb75cc0a0c09dd30bab6786d8ab4bbea6e01";
              };
            }
          ]);
      };
    };
  };
}

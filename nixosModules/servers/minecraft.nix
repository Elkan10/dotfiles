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
        package = pkgs.fabricServers.fabric-1_21_8;
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
            simulation-distance=5;
            spawn-animals=true;
            spawn-monsters=true;
            spawn-npcs=true;
            spawn-protection=0;
            sync-chunk-writes=true;
            use-native-transport=true;
            view-distance=5;
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
                name = "fabric-api-0.113.14+1.21.9.jar"; 
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/CF23l2iP/fabric-api-0.133.4%2B1.21.8.jar";
                  sha512 = "e3cc9f8f60d655c916b2d31ca2a77fc15187e443e3bb8a5977dcff7a704401e8a39d633e12a649207a5923e540b6474e90f08c95655d07ae1c790d5c8aff41a5";
                  name = "fabric-api-0.113.14+1.21.9.jar";
                };
              }
              {
                name = "Geyser-Fabric.jar";
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/wKkoqHrH/versions/MdePNaSY/geyser-fabric-Geyser-Fabric-2.8.4-b944.jar";
                  sha512 = "70fa913a97ef9645bf7bf2797a2315f31399a458f30210b28233e1bb93fe9a502eb7fc65c54ddf8ebd4d0379a65dd75842217fe5904f37b11d5f600f0cdb8687";
                  name = "Geyser-Fabric.jar";
                };
              }
              {
                name = "Floodgate-Fabric-2.2.5-b45.jar";
                path = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/ps3IuRel/Floodgate-Fabric-2.2.5-b45.jar";
                  sha512 = "eebd599f805cb0b090c5a917e0618509cc9e41161581e0f2240596e3d6c841e66ad6b37bc8140a651ca15eef37db52489c1431e022f7efafd13523b64ec92045";  
                  name="Floodgate-Fabric-2.2.5-b45.jar";
                };
              }
              {
                name = "servercore-fabric-1.5.14+1.21.8.jar";
                path = pkgs.fetchurl { 
                  url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/CdJJdZ39/servercore-fabric-1.5.14%2B1.21.8.jar"; 
                  sha512 = "59607b7a078bc13a8c984938108f251456160ca1eaebce9fc20b69aacbf4a64ff8bfc9e30920311a3ad3988c172a59eee690df9d81d05c8e2128b0234b524a98";
                  name = "servercore-fabric-1.5.14+1.21.8.jar";
                };
              }
            
            ];
        };
      };
    };
  };
}

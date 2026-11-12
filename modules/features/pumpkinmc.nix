{self, inputs, ...}: {
    flake.nixosModules.pumpkinmc = {pkgs, config, lib, ...}: {
        # Remove auto start
        systemd.services.pumpkin = {
            wantedBy = lib.mkForce [];
            environment = {
                RUST_MIN_STACK = "33554432";
                RUST_BACKTRACE = "1";
            };
        };
        
        services.pumpkin = {
            enable = false;
            openFirewall = true;
        
            package = pkgs.pumpkin.overrideAttrs (old: rec {
                version = "0.2.0+26.3-26.51";
                src = pkgs.fetchFromGitHub {
                    owner = "Pumpkin-MC";
                    repo = "Pumpkin";
                    rev = "204a94ed895f041a845630d5a23c094705a0704e";
                    hash = "sha256-hV4xWPvdd/vdNEfR6fw0J6jk4JtHIfjC7XtyOLIy8d8=";
                };
                cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
                    inherit (old) pname;
                    inherit version src;
                    hash = "sha256-AgIPV5zexoA4OqTS4navDQM0U29Tg63JPnIjPrI4ssA=";
                };
                cargoBuildFlags = [
                    "--package"
                    "pumpkin"
                ];
                cargoBuildType = "release";
                doCheck = false;
            });

            settings = {
                seed = "1791616982141699905";
                default_difficulty = "Normal";
                op_permission_level = 4;
                allow_nether = true;
                allow_end = true;
                hardcore = false;
                tps = 20.0;
                default_gamemode = "Survival";
                force_gamemode = false;
                scrub_ips = true;
                use_favicon = true;
                default_level_name = "world";
                allow_chat_reports = false;
                white_list = false;
                enforce_whitelist = false;
                logging = {
                    enabled = true;
                    threads = true;
                    color = true;
                    timestamp = true;
                    file = "latest.log";
                };
                resource_pack = {
                    java = {
                        enabled = false;
                        url = "";
                        sha1 = "";
                        prompt_message = "";
                        force = false;
                    };
                    bedrock = {
                        enabled = false;
                        force = false;
                        packs = [  ];
                    };
                };
                world = {
                    lighting = "default";
                    autosave_ticks = 0;
                    chunk = {
                        type = "anvil";
                        write_in_place = false;
                        compression = {
                            algorithm = "LZ4";
                            level = 6;
                        };
                    };
                };
                networking = {
                    query = {
                        enabled = true;
                        address = "0.0.0.0:25565";
                    };
                    rcon = {
                        enabled = true;
                        address = "0.0.0.0:25575";
                        max_connections = 10;
                        logging = {
                            logged_successfully = true;
                            wrong_password = true;
                            commands = true;
                            quit = true;
                        };
                        passwordFile = config.age.secrets.pumpkin-mc.path;
                    };
                    proxy = {
                        enabled = false;
                        velocity = {
                            enabled = false;
                        };
                        bungeecord = {
                            enabled = false;
                        };
                    };
                    lan_broadcast = {
                        enabled = false;
                    };
                    java = {
                        enabled = true;
                        address = "0.0.0.0:25565";
                        encryption = true;
                        online_mode = true;
                        max_players = 1000;
                        view_distance = 16;
                        simulation_distance = 10;
                        motd = "A blazingly fast Pumpkin server!";
                        compression = {
                            enabled = true;
                            threshold = 256;
                            level = 4;
                        };
                        authentication = {
                            enabled = true;
                            connect_timeout = 5000;
                            read_timeout = 5000;
                            prevent_proxy_connections = false;
                            player_profile = {
                                allow_banned_players = false;
                                allowed_actions = [ "FORCED_NAME_CHANGE" "USING_BANNED_SKIN" ];
                            };
                            textures = {
                                enabled = true;
                                allowed_url_schemes = [ "http" "https" ];
                                allowed_url_domains = [ ".minecraft.net" ".mojang.com" ];
                                types = {
                                    skin = true;
                                    cape = true;
                                    elytra = true;
                                };
                            };
                        };
                    };
                    bedrock = {
                        enabled = true;
                        address = "0.0.0.0:19132";
                        encryption = true;
                        online_mode = true;
                        max_players = 1000;
                        view_distance = 16;
                        simulation_distance = 10;
                        motd = "A blazingly fast Pumpkin server!";
                        compression = {
                            enabled = true;
                            threshold = 256;
                            level = 4;
                        };
                        authentication = {
                            enabled = true;
                            connect_timeout = 5000;
                            read_timeout = 5000;
                        };
                    };
                };
                commands = {
                    use_console = true;
                    use_tty = true;
                    log_console = true;
                    broadcast_console_to_ops = true;
                    default_op_level = 0;
                };
                chat = {
                    format = "<{DISPLAYNAME}> {MESSAGE}";
                };
                pvp = {
                    enabled = true;
                    hurt_animation = true;
                    protect_creative = true;
                    knockback = true;
                    swing = true;
                };
                server_links = {
                    enabled = true;
                    bug_report = "https://github.com/Pumpkin-MC/Pumpkin/issues";
                    support = "";
                    status = "";
                    feedback = "";
                    community = "";
                    website = "";
                    forums = "";
                    news = "";
                    announcements = "";
                    custom = {

                    };
                };
                player_data = {
                    save_player_data = true;
                    save_player_cron_interval = 300;
                };
                fun = {
                    april_fools = true;
                };
                recipe = {
                    send_recipes = true;
                };
                plugins = {
                    blocked_permissions = [  ];
                };
                advancement = {
                    save_advancements = true;
                };
            };
        };
    };
}

{ self, inputs, lib, ... }:
{
    flake.lib = {
        genLuaMonitors = monitors:
            lib.concatMapStringsSep "\n" (m: (''
                hl.monitor({
                    output = "${m.output}",
                    mode = "${m.mode}",
                    position = "${m.position}",
                    scale = ${toString m.scale},
                })
                hl.workspace_rule({
                    workspace = "${toString (builtins.elemAt m.workspaces 0)}",
                    monitor = "${m.output}",
                    default = true,
                })
            '' + lib.concatMapStringsSep "\n" (w: ''
                    hl.workspace_rule({
                        workspace = "${toString w}",
                        monitor = "${m.output}",    
                    })
                '') (builtins.tail m.workspaces))
            ) monitors;

        mkHyprland = {pkgs, monitors}:
            (let 
                configDir = self.lib.template {
                    inherit pkgs;
                    name = "hypr";
                    path = ../../configs/hypr;
                    vars = {
                        monitors = self.lib.genLuaMonitors monitors; 
                    };
                }; 
            in inputs.wrappers.lib.wrapPackage {
                    inherit pkgs;
                    package = pkgs.hyprland;
                    flags = {
                        "--config" = "${configDir}/hypr/hyprland.lua";
                    };
                });
    };

    perSystem =
        { pkgs, ... }:
        {
            packages.myWaybar =
                (inputs.wrappers.wrapperModules.waybar.apply {
                    inherit pkgs;
                    configFile.path = "${../../configs/waybar/config.jsonc}";
                    "style.css".path = "${../../configs/waybar/style.css}";
                }).wrapper;
        };

    flake.nixosModules.hyprland =
        { pkgs, config, lib, ... }:
        {
            options.my-hyprland.monitors = lib.mkOption {
                default = [];
                type = lib.types.listOf (lib.types.submodule {
                    options = {
                        output = lib.mkOption {
                            type = lib.types.str;
                            description = "Hyprland monitor output name.";
                        };

                        mode = lib.mkOption {
                            type = lib.types.str;
                            description = "Monitor resolution and refresh rate.";
                            example = "2560x1440@144";
                        };

                        position = lib.mkOption {
                            type = lib.types.str;
                            description = "Monitor position.";
                            example = "0x0";
                        };

                        scale = lib.mkOption {
                            type = lib.types.float;
                            description = "Monitor scale factor.";
                        };

                        workspaces = lib.mkOption {
                            type = lib.types.listOf lib.types.int;
                            description = "Workspaces assigned to this monitor";
                        };
                    }; 
                });
            };

            config = {
               assertions = [
                    {
                        assertion = config.my-hyprland.monitors != [];
                        message = "Hyprland module is imported, but no monitor config has been set";
                    }
                ];

                programs.hyprland = {
                    enable = true;
                    package = self.lib.mkHyprland {
                        inherit pkgs;
                        monitors = config.my-hyprland.monitors;
                    };
                };

                environment.systemPackages = [
                    pkgs.rofi
                    pkgs.yazi
                    pkgs.mako
                    pkgs.libnotify
                    pkgs.hyprshot

                    pkgs.adwaita-icon-theme
                    self.packages.${pkgs.stdenv.hostPlatform.system}.myWaybar
                    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

                    (pkgs.writeShellScriptBin "start" ''
                        exec dbus-run-session start-hyprland
                    '')
                ];

                environment.sessionVariables = {
                    HYPRSHOT_DIR = "/home/elvis/screenshots";
                };
            };
        };
}

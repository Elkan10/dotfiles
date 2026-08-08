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

        mkHyprland = {pkgs, monitors, bar}:
            (let 
                configDir = self.lib.template {
                    inherit pkgs;
                    name = "hypr";
                    path = ../../configs/hypr;
                    vars = {
                        monitors = self.lib.genLuaMonitors monitors; 
                        bar = bar;
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


    flake.nixosModules.hyprland =
        { pkgs, config, lib, ... }:
        {
            options.my-hyprland.bar = lib.mkOption {
                default = "";
                description = "Bar to use for hyprland";
                type = lib.types.str;
            };

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
                    {
                        assertion = config.my-hyprland.bar != "";
                        message = "Hyprland module is imported, but no bar has been set";
                    }
                ];

                programs.hyprland = {
                    enable = true;
                    withUWSM = true;
                    package = self.lib.mkHyprland {
                        inherit pkgs;
                        monitors = config.my-hyprland.monitors;
                        bar = config.my-hyprland.bar;
                    };
                };

                environment.systemPackages = [
                    pkgs.rofi
                    pkgs.yazi
                    pkgs.mako
                    pkgs.libnotify
                    pkgs.hyprshot

                    pkgs.adwaita-icon-theme
                    pkgs.bibata-cursors
                ];

                environment.sessionVariables = {
                    HYPRSHOT_DIR = "/home/elvis/screenshots";
                };
            };
        };
}

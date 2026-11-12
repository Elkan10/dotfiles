{self, ...}: {
    perSystem = {pkgs, lib, ...}: 
        let 
            firefoxBase = pkgs.wrapFirefox pkgs.firefox-unwrapped {
                nativeMessagingHosts = [ pkgs.tridactyl-native ];
                extraPolicies = {
                    DisableTelemetry = true;
                    DontCheckDefaultBrowser = true;
                    Preferences = {
                        "toolkit.legacyUserProfileCustomizations.stylesheets" = {
                            Value = true; Status = "locked";
                        };
                        "browser.compactmode.show" = { Value = true; Status = "default"; };
                        "browser.newtabpage.enabled" = { Value = false; Status = "default"; };
                    };
                    ExtensionSettings = {
                        "tridactyl.vim@cmcaine.co.uk" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
                            installation_mode = "force_installed";
                        };
                        "uBlock0@raymondhill.net" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                            installation_mode = "force_installed";
                        };
                        "firefox@tampermonkey.net" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi";
                            installation_mode = "force_installed";
                        };
                        "{3c078156-979c-498b-8990-85f7987dd929}" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
                            installation_mode = "force_installed";
                        };                     
                    };
                };
            };
            chrome = pkgs.writeTextDir "chrome/userChrome.css" (builtins.readFile ../../configs/firefox/userChrome.css);
            tridactylrc = pkgs.writeText "tridactylrc" (builtins.readFile ../../configs/firefox/tridactylrc);
            catppuccin = pkgs.writeText "catpuccin.css" (builtins.readFile ../../configs/firefox/catppuccin.css);
            launcher = pkgs.writeShellApplication {
                name = "firefox";
                text = ''
                    profile="''${XDG_DATA_HOME:-$HOME/.local/share}/firefox-riced"
                    tri="''${XDG_CONFIG_HOME:-$HOME/.config}/tridactyl"
                    mkdir -p "$profile" "$tri/themes"
                    ln -sfn ${chrome}/chrome "$profile/chrome"
                    ln -sfn ${tridactylrc} "$tri/tridactylrc"
                    ln -sfn ${catppuccin} "$tri/themes/catppuccin.css"
                    exec ${lib.getExe firefoxBase} -profile "$profile" -no-remote "$@"
                '';
            };

            desktopItem = pkgs.makeDesktopItem {
                name = "firefox-riced";
                desktopName = "Firefox (riced)";
                genericName = "Web Browser";
                exec = "${lib.getExe launcher} %U";
                icon = "firefox";
                terminal = false;
                categories = [ "Network" "WebBrowser" ];
                mimeTypes = [
                    "text/html"
                    "x-scheme-handler/http"
                    "x-scheme-handler/https"
                ];
                startupNotify = true;
                startupWMClass = "firefox";
            };

            firefoxRiced = pkgs.symlinkJoin {
                name = "firefox-riced";
                paths = [ launcher desktopItem ];
                meta.mainProgram = "firefox";
            };
        in {
            packages.myFirefox = firefoxRiced;
        };

    flake.nixosModules.firefox = {pkgs, ...}: {
        environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.myFirefox ];           
    };
}

{...}: {
    flake.nixosModules.basic-settings = {pkgs, ...}: {
        nix.settings.experimental-features = ["nix-command" "flakes"];
        nixpkgs.config.allowUnfree = true;

        i18n.inputMethod = {
            type = "fcitx5";
            enable = true;
            fcitx5.addons = with pkgs; [
                fcitx5-m17n
                fcitx5-hangul
                fcitx5-mozc-ut
            ];
            fcitx5.waylandFrontend = true;
        };

        environment.systemPackages = [
            pkgs.firefox
        ];

        xdg.portal.enable = true;

        boot = {
            kernelPackages = pkgs.linuxKernel.packages.linux_zen;
            consoleLogLevel = 3;
            loader = {
                efi = {
                    canTouchEfiVariables = true;
                    efiSysMountPoint = "/boot";  
                };
                systemd-boot.enable = true;
                timeout = 10;
            };
        };

        networking.networkmanager.enable = true;

        time.timeZone = "Europe/Stockholm";

        i18n.defaultLocale = "en_US.UTF-8";

        i18n.extraLocaleSettings = {
            LC_ADDRESS = "sv_SE.UTF-8";
            LC_IDENTIFICATION = "sv_SE.UTF-8";
            LC_MEASUREMENT = "sv_SE.UTF-8";
            LC_MONETARY = "sv_SE.UTF-8";
            LC_NAME = "sv_SE.UTF-8";
            LC_NUMERIC = "sv_SE.UTF-8";
            LC_PAPER = "sv_SE.UTF-8";
            LC_TELEPHONE = "sv_SE.UTF-8";
            LC_TIME = "sv_SE.UTF-8";
        };

        services.xserver = {
            xkb.layout = "se";
            xkb.variant = "";
        };

        services.printing = {
            drivers = with pkgs; [cnijfilter2];
            enable = true;
        };

        services.avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
        };

        hardware.enableAllFirmware = true;
        security.rtkit.enable = true;

        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
            wireplumber.enable = true;
        };

        users.users.elvis = {
            isNormalUser = true;
            description = "Elvis";
            extraGroups = ["networkmanager" "wheel" "input" "uinput" "audio"];
            shell = pkgs.bash;
        };

        system.stateVersion = "23.11";
    };
}

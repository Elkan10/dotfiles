# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware/amd.nix
      ./nixosModules
    ];
  
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-m17n
      fcitx5-hangul
    ];
  };

  widgets = {
    enable = true;
    status_bar.enable = true;
  };

  playit.enable = false;
  steam.enable = true;
  heroicgl.enable = true;
  prismlauncher.enable = true;
  vesktop.enable = true;
  mcservers.enable = true;
  sddm-qt6-wl = {
    enable = true;
    theme-name = "sddm-astronaut-theme";
    theme = (import ./derivations/sddm-astronaut-mod.nix {
      inherit pkgs;
      bg = (import ./derivations/images.nix {inherit pkgs;}).purple-red;
    });
  };

  blender.enable = true;

  core = {
    enable = true;
    htop.enable = true;
    libnotify.enable = true;
    wl-clipboard.enable = true;
    usbutils.enable = true;
    coreutils.enable = true;
    neofetch.enable = true;
    git.enable = true;
  };

  lsp = {
    enable = true;
    rust.enable = true;
    nix.enable = true;
    lldb-18.enable = true;
    typescript.enable = true;
  };

  compat = {
    enable = true;
    wine.enable = true;
    protontricks.enable = true;
    mangohud.enable = true;
    bottles.enable = true;
  };

  openrgb.enable = true;

  stylix.enable = true;
  stylix.base16Scheme = {
    base00 = "2e3440";
    base01 = "383e4a";
    base02 = "3d494f";
    base03 = "485259";
    base04 = "cdd1d9";
    base05 = "d7dbe3";
    base06 = "ebf0f6";
    base07 = "ebf0f6";
    base08 = "be616b";
    base09 = "be7f6b";
    base0A = "bea177";
    base0B = "bed477";
    base0C = "5c81ad";
    base0D = "5c81c8";
    base0E = "7e81c8";
    base0F = "948168";
  };
  stylix.image = (import ./derivations/images.nix {inherit pkgs;}).purple-red;

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 10;
  };

  stylix.fonts = {
    sizes = {
      applications = 12;
      terminal = 15;
      desktop = 10;
      popups = 10;
    };
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrains Mono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };

  stylix.opacity = {
    terminal = 0.9;
  };
  
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/elvis/.config/sops/age/keys.txt";

  sops.secrets."playit_key" = {
    owner = lib.mkIf config.playit.enable "playit";
  };
 
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  nixpkgs.config.allowBroken = true;
  
  boot = {
    blacklistedKernelModules = [ "r8169" ];
    extraModulePackages = with config.boot.kernelPackages; [ r8125 ];
    kernelModules = [ "r8125" "i2c-dev" "i2c-piix4" ];
    kernelParams = [ ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  #Open port for minecraft and peacock/http
  networking.firewall.allowedTCPPorts = [25565 19132 80 53];
  networking.firewall.allowedUDPPorts = [25655 19132 80 53];

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
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

  services.displayManager.sddm.theme = "sddm-astronaut-theme";

  
  

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "";
  };

  systemd.sleep.extraConfig = /*lua*/ ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  # Configure console keymap
  console.keyMap = "sv-latin1";

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "elvis" = import ./home.nix;
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.enableAllFirmware = true;
  services.pulseaudio = {
    enable = false;
    support32Bit = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elvis = {
    isNormalUser = true;
    description = "Elvis";
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" "audio"];
      };

    

  # Install firefox.
  programs.firefox.enable = true;

  programs.hyprland.enable = true;
  
  
  environment.sessionVariables = rec {
    MOZ_ENABLE_WAYLAND = 0;
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      main = {
        config = ''
          (defsrc 
            caps)
          (deflayermap (default-layer)
            caps esc
          )
        '';    
      };
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}


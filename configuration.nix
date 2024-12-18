# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
let
sddm-astronaut-m = pkgs.sddm-astronaut.override {
  themeConfig = {
    Background = ''${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/landscapes/forrest.png";
        sha256 = "00qx3h60s92hmf09ik1s3984jym6li270201qqzs5x4yks7q6flc";
    }}'';
  };
};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/nvidia-conf.nix
      ./modules/games-conf.nix
      ./modules/minecraft.nix
      inputs.home-manager.nixosModules.default
      inputs.sops-nix.nixosModules.sops
    ];

  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = "${config.sops.secrets."playit_key".path}";
  };

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/elvis/.config/sops/age/keys.txt";

  sops.secrets."playit_key" = {
    owner = "playit";
  };
 
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  services = {
    desktopManager.plasma6 = {
      enable = false;
    };
    displayManager = {
      defaultSession = "hyprland";
      sddm = {
        package = pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";
	      enable = true;
	      wayland.enable = true;
        extraPackages = [ sddm-astronaut-m ];
      };
    };
  };

  

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
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elvis = {
    isNormalUser = true;
    description = "Elvis";
    extraGroups = [ "networkmanager" "wheel" "input" "uinput"];
    packages = with pkgs; [
      kate
    #  thunderbird
    ];
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    prismlauncher
    htop
    libnotify


    anki-bin
    mpv-unwrapped

    usbutils
    mangohud
    wl-clipboard

    protontricks
    wine

    appimage-run

    (import ./peacock/peacock.nix {pkgs = pkgs;})

    flightgear

    coreutils
    neofetch
    google-chrome

    nil
    rust-analyzer
    lldb_18
    typescript-language-server

    orca-slicer

    git

    sddm-astronaut-m
  ];



  services.hardware.openrgb.enable = true;

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
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


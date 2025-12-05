{pkgs, config, self, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  services.displayManager.ly.enable = true;
  
  programs.hyprland = {
    enable = true;
    package = self.packages.${pkgs.system}.hyprland-wrapped;
  };
  
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-m17n
      fcitx5-hangul
      fcitx5-mozc-ut
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    htop
    libnotify
    wl-clipboard
    usbutils
    coreutils
    neofetch
    yazi
    any-nix-shell

    steam
    prismlauncher
    vesktop

    rust-analyzer
    lldb_18
    nixd
  ] ++ (with self.packages.${pkgs.system}; [
    firefox-jailed
    helix-wrapped
    starship-wrapped
  ]);

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
        any-nix-shell fish --info-right | source
        starship init fish | source
        enable_transience
      '';
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.timeout = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    blacklistedKernelModules = [ "r8169" ];
    extraModulePackages = [ config.boot.kernelPackages.r8125 ];
    kernelModules = [ "r8125" "i2c-dev" "i2c-piix4" ];
    kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
      "fbcon=map:1"
    ];
  };

  networking.hostName = "desktop";
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

  console.keyMap = "sv-latin1";

  services.printing.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" "audio" ];
    shell = pkgs.fish;
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 0;
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
  };


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  

  # TODO: services.displayManager, hyprland

  system.stateVersion = "23.11";
}

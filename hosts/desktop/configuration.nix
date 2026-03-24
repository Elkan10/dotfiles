{pkgs, config, self, inputs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  
  programs.hyprland = {
    enable = true;
    package = self.packages.${pkgs.system}.hyprland-wrapped;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
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
    fbset
    git
    htop
    libnotify
    wl-clipboard
    usbutils
    coreutils
    neofetch
    yazi
    any-nix-shell

    rofi
    hyprshot
    mako

    steam
    firefox
    prismlauncher
    vesktop
    heroic

    rust-analyzer
    lldb_18
    nixd

    limo
    protonup-qt
    yad
    bottles

    adwaita-icon-theme

    inputs.awww.packages.${pkgs.system}.awww

    (pkgs.writeShellScriptBin "start" ''
      exec dbus-run-session start-hyprland
    '')
  ] ++ (with self.packages.${pkgs.system}; [
    helix-wrapped
    starship-wrapped
    alacritty-wrapped
    waybar-wrapped
  ]);

  programs.steam = {
    enable = true;
    protontricks = {
      enable = true;
    };
  };

  xdg.portal.enable = true;  

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
        any-nix-shell fish --info-right | source
        starship init fish | source
        enable_transience
      '';
  };

  programs.bash = {
    enable = true;
    interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  boot.consoleLogLevel = 3;

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    configurationLimit = 5;
  };
  boot.loader.timeout = 10;

  boot = {
    blacklistedKernelModules = [ "r8169" ];
    extraModulePackages = [ config.boot.kernelPackages.r8125 ];
    kernelModules = [ "r8125" "i2c-dev" "i2c-piix4" ];
    kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
      "video=card1-DP-1:2560x1440@240m"
      "video=card1-HDMI-A-1:1920x1080"
    ];
  };

  age.identityPaths = [ "/home/elvis/.ssh/id_ed25519" ];

  age.secrets.playit = {
    file = ../../secrets/playit.age;
  };
  
  services.playit = {
    enable = true;
    secretPath = config.age.secrets.playit.path;
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

  services.printing = {
    drivers = with pkgs; [ cnijfilter2 ];
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
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" "audio" ];
    shell = pkgs.bash;
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 0;
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    HYPRSHOT_DIR = "/home/elvis/screenshots";

    XDG_DATA_HOME="$HOME/.local/share";
    XDG_CONFIG_HOME="$HOME/.config";
    XDG_STATE_HOME="$HOME/.local/state";
    XDG_CACHE_HOME="$HOME/.cache";
  };


  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
  ];
  


  system.stateVersion = "23.11";
}

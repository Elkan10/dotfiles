{self, inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myAlacritty = (inputs.wrappers.wrapperModules.alacritty.apply {
      inherit pkgs;
      "alacritty.toml".path = "${../../configs/alacritty.toml}";
    }).wrapper;
    packages.myStarship = (inputs.wrappers.wrapperModules.starship.apply {
      inherit pkgs;
      configFile.path = "${../../configs/starship.toml}";
    }).wrapper;
  };

  flake.nixosModules.terminal = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myAlacritty
      self.packages.${pkgs.stdenv.hostPlatform.system}.myStarship
      pkgs.any-nix-shell

      pkgs.git
      pkgs.htop
      pkgs.usbutils
      pkgs.coreutils
      pkgs.fastfetch
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
    ];

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
  };
}

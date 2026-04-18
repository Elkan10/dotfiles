{self, inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myNeovim = (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = (inputs.import-tree ../../nvim).imports;
    }).neovim;
  };

  flake.nixosModules.neovim = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim
    ];
  };
}

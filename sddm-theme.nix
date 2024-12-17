{pkgs}:
let 
image = pkgs.fetchurl {
  url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/landscapes/Clearnight.jpg";
  sha256 = "1ycxdhkn01gdkmn8fy5jyrnlbhnz7l1cyqib6zw12xfm3ihfiixi";
};
in
pkgs.stdenv.mkDerivation {
    name = "sddm-theme";
    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-sugar-dark
      cp -R ./* $out/share/sddm/themes/sddm-sugar-dark/
      cp -r ${image} $out/share/sddm/themes/sddm-sugar-dark/Background.jpg
    '';
}

{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex";
      };

      sansSerif = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };

      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

  };
}

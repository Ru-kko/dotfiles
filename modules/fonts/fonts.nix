{ pkgs, ... }:
{
  fonts = {
    fontconfig.enable = true;

    packages = with pkgs; [
      nerd-fonts.victor-mono
      noto-fonts
    ];

    fontconfig.defaultFonts = {
      monospace = [ "VictorMono Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
    };
  };
}
{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = pkg.hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
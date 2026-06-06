{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland = {
      enable = true;
      hidpi = true;
    }
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
{ config, ... }:
{
  imports = [
    ./hyprland/hyprland.nix
    ./fonts/fonts.nix
    ./greetd/greetd.nix
  ];
}
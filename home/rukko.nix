{ pkgs, ... }:
{
  home.username = "rukko";
  home.homeDirectory = "/home/rukko";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
  ];

  programs.zsh.enable = true;
}
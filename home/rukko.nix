{ pkgs, ... }:
{
  home.username = "rukko";
  home.homeDirectory = "/home/rukko";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    git
    neovim
    zsh
  ];

  programs.zsh.enable = true;
}
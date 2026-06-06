{ config, pkgs, ... }:
{
  imports = [
    ../modules/system-modules.nix
  ];

  environment.systemPackages = with pkgs; [
    neovim
    git
    zsh
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.rukko = import ./rukko.nix;
}
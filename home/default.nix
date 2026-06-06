{ pkgs, ... }:
{
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.rukko = import ./rukko;
}
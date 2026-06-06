{ pkgs, ... }:
{
  users.users.rukko = {
    isNormalUser = true;
    description = "rukko";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
{ pkgs, ... }:
{
  system.stateVersion = "26.05";

  networking = {
    hostName = "rukko";
    networkmanager.enable = true;
  };

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "la-latin1";
}
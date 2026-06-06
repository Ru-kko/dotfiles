{ pkgs, ... }:
{
  system.stateVersion = "26.05";

  networking = {
    hostName = "rukko";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Bogota";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "la-latin1";

  # Hardware configuration
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };
}
{ pkgs, ... }:
{
  users.users.rukko = {
    isNormalUser = true;
    description = "rukko";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "audio"
    ];
    
    packages = with pkgs; [
    ];

    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
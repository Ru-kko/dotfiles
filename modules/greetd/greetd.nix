{ pkgs, ... }:
let
  hyprlandGreeterConfig = pkgs.writeText "hyprland-regreet.conf" ''
    exec-once = regreet; hyprctl dispatch exit
  '';
in {
{
  environment.etc."regreet/bg.png".source = ../../assets/bg-lock.png;

  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        cmd = "${pkgs.regreet}/bin/regreet --cmd Hyprland";
      in {
        command = cmd;
        user = "greeter";
      };
      background = {
        path = "/etc/regreet/bg.png";
        fit = "Cover";
      };
      font = {
        name = "Victor Mono Nerd Font";
        size = 16;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = "Catppuccin-Mocha-Dark-Cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
      };
    };
  };
}
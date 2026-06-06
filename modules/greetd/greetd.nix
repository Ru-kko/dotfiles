{ pkgs, config, ... }:
let
  hyprlandPackage = config.programs.hyprland.package;
  hyprlandGreeterConfig = pkgs.writeText "hyprland-regreet.conf" ''
    hl.on("hyprland.start", function()
	    hl.exec_cmd("regreet; hyprctl dispatch 'hl.dsp.exit()'")
    end)
    hl.config({
    	misc = {
		    disable_hyprland_logo = true,
		    disable_splash_rendering = true,
        disable_hyprland_guiutils_check = true,
	    },
    })
  '';
in {
  environment.etc."regreet/bg.png".source = ../../assets/bg-lock.png;

  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        cmd = "${pkgs.dbus}/bin/dbus-run-session ${hyprlandPackage}/bin/Hyprland -c ${hyprlandGreeterConfig}";
      in {
        command = cmd;
        user = "greeter";
      };
    };
  };

  programs.regreet = {
    enable = true;
    package = pkgs.greetd.regreet;

    font = {
      name = "Victor Mono Nerd Font";
      size = 16;
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    settings = {
      background = {
        path = "/etc/regreet/bg.png";
        fit = "Cover";
      };
    };
  };
}
{
  description = "Rukkus - A NixOS configuration for my personal use";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    hyprland.url = "github:hyprwm/hyprland";
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprland, home-manager, ... } @inputs:

  {
    nixosConfigurations.rukko = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      specialArgs = { inherit inputs; };

      modules = [
        ./host

        home-manager.nixosModules.home-manager

        ./home
      ];
    };
  };
}
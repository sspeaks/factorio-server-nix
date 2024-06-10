{
  description = "Simple factorio server with nice to have mods";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in
    {
      nixosModules = {
        factorio-server = import ./server.nix;
        default = self.nixosModules.factorio-server;
      };
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}

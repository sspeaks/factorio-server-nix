{ pkgs, lib, config, ... }:
let
  cfg = config.services.factorio-server;
  package = pkgs.factorio-headless-experimental.override {
    token = cfg.token;
    username = cfg.username;
    versionsJson = ./versions.json;
  };

  #myMods = lib.attrValues (import ./mods.nix { inherit (pkgs) stdenv; });
in
{
  options = {
    services.factorio-server = {
      enable = lib.mkEnableOption "factorio-server";
      token = lib.mkOption {
        type = lib.types.str;
      };
      username = lib.mkOption {
        type = lib.types.str;
      };

    };
  };
  config = lib.mkIf cfg.enable {
    services.factorio = {
      enable = true;
      admins = [ "bloodfox" "Zimmygee" ];
      openFirewall = true;
      loadLatestSave = true;
      game-name = "Engineering Nerds Factorio Server";
      description = "Factorio server for Losers";
      package = package;
    };
  };
}

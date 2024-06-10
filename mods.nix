{ stdenv, ... }:
let
  # Mods
  #factoryplanner_1.1.59.zip
  #flib_0.11.2.zip
  #MaxRateCalculator_3.4.48.zip
  #Nanobots_3.2.19.zip
  #stdlib_1.4.7.zip

  modFolder = ./factorio-mods;

  mkDer = f: stdenv.mkDerivation {
    name = with builtins; (elemAt (split "\\." (baseNameOf f)) 0);
    src = modFolder;
    buildPhase = ''
      mkdir -p $out
      cp ${builtins.baseNameOf f} $out
    '';
    dontInstall = true;
    deps = [ ];
    optionalDeps = [ ];
    recommendedDeps = [ ];
  };
in
rec {
  stdEnv = mkDer "stdlib_1.4.7.zip";
  flib = mkDer "flib_0.11.2.zip";
  fPlan = (mkDer "factoryplanner_1.1.59.zip").overrideAttrs (f: p: { deps = [ flib ]; });
  mRate = mkDer "MaxRateCalculator_3.4.48.zip";
  nano = (mkDer "Nanobots_3.2.19.zip").overrideAttrs (f: p: { deps = [ stdEnv ]; });
}

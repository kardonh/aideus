# nix/tui.nix — Aideus TUI (Ink/React) compiled with tsc and bundled
{ pkgs, aideusNpmLib, ... }:
let
  src = ../ui-tui;
  npmDeps = pkgs.fetchNpmDeps {
    inherit src;
    hash = "sha256-a/HGI9OgVcTnZrMXA7xFMGnFoVxyHe95fulVz+WNYB0=";
  };

  npm = aideusNpmLib.mkNpmPassthru { folder = "ui-tui"; attr = "tui"; pname = "aideus-tui"; };

  packageJson = builtins.fromJSON (builtins.readFile (src + "/package.json"));
  version = packageJson.version;
in
pkgs.buildNpmPackage (npm // {
  pname = "aideus-tui";
  inherit src npmDeps version;

  doCheck = false;
  npmFlags = [ "--legacy-peer-deps" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/aideus-tui

    cp -r dist $out/lib/aideus-tui/dist

    # runtime node_modules
    cp -r node_modules $out/lib/aideus-tui/node_modules

    # @aideus/ink is a file: dependency, we need to copy it in fr
    rm -f $out/lib/aideus-tui/node_modules/@aideus/ink
    cp -r packages/aideus-ink $out/lib/aideus-tui/node_modules/@aideus/ink

    # package.json needed for "type": "module" resolution
    cp package.json $out/lib/aideus-tui/

    runHook postInstall
  '';
})

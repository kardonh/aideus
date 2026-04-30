# nix/packages.nix — Aideus Agent package built with uv2nix
{ inputs, ... }:
{
  perSystem =
    { pkgs, inputs', ... }:
    let
      aideusAgent = pkgs.callPackage ./aideus-agent.nix {
        inherit (inputs) uv2nix pyproject-nix pyproject-build-systems;
        npm-lockfile-fix = inputs'.npm-lockfile-fix.packages.default;
        # Only embed clean revs — dirtyRev doesn't represent any upstream
        # commit, so comparing it would always claim "update available".
        rev = inputs.self.rev or null;
      };
    in
    {
      packages = {
        default = aideusAgent;
        tui = aideusAgent.aideusTui;
        web = aideusAgent.aideusWeb;

        fix-lockfiles = aideusAgent.aideusNpmLib.mkFixLockfiles {
          packages = [ aideusAgent.aideusTui aideusAgent.aideusWeb ];
        };
      };
    };
}

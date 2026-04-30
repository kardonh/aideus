# nix/devShell.nix — Dev shell that delegates setup to each package
#
# Each package in inputsFrom exposes passthru.devShellHook — a bash snippet
# with stamp-checked setup logic. This file collects and runs them all.
{ inputs, ... }: {
  perSystem = { pkgs, system, ... }:
    let
      aideus-agent = inputs.self.packages.${system}.default;
      aideus-tui = inputs.self.packages.${system}.tui;
      aideus-web = inputs.self.packages.${system}.web;
      packages = [ aideus-agent aideus-tui aideus-web ];
    in {
      devShells.default = pkgs.mkShell {
        inputsFrom = packages;
        packages = with pkgs; [
          python312 uv nodejs_22 ripgrep git openssh ffmpeg
        ];

        shellHook = let
          hooks = map (p: p.passthru.devShellHook or "") packages;
          combined = pkgs.lib.concatStringsSep "\n" (builtins.filter (h: h != "") hooks);
        in ''
          echo "Aideus Agent dev shell"
          ${combined}
          echo "Ready. Run 'aideus' to start."
        '';
      };
    };
}

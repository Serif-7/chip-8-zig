{
  description = "CHIP-8 emulator written in Zig";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "chip-8-zig";
          src = ./.;
          # nativeBuildInputs = with pkgs; [meson ninja pkg-config];
          buildInputs = with pkgs; [ 
            zig
            wayland-scanner
            libGL
            raylib
            

            ];
          # configurePhase = "meson setup builddir --prefix=$out";
          buildPhase = "zig build run";

        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            zig
            wayland-scanner
            libGL
            raylib
            ];
        };
      });
}

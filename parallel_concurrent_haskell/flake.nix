{
  description = "Reading flake for parallel and concurrent haskell";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    flake-utils,
    nixpkgs,
    self,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShell = with pkgs;
        pkgs.mkShell {
          buildInputs = [
            (haskellPackages.ghcWithPackages (pkgs: [pkgs.parallel]))
            haskellPackages.threadscope
          ];
          shellHook = ''
            alias ghc="ghc -no-keep-hi-files -no-keep-o-files -o out -O2 -rtsopts"
          '';
        };
    });
}

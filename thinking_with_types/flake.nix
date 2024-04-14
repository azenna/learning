{
  description = "Simple haskell nix flake";
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
      devShell = pkgs.mkShell {
        buildInputs = [
          (pkgs.haskellPackages.ghcWithPackages (pkgs:
            with pkgs; [
              vector
              first-class-families
              aeson
              aeson-pretty
              inspection-testing
              indexed
              do-notation
              singletons
              constraints
            ]))
        ];
      };
    });
}

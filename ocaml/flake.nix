{
  description = "ad hoc ocaml";
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
          pkgs.ocaml
          pkgs.ocamlPackages.ocaml-lsp
          pkgs.ocamlformat
          pkgs.dune_3
          pkgs.ocamlPackages.utop
          pkgs.ocamlPackages.core
        ];
      };
    });
}

{
  description = "Thinking with types flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = [ pkgs.haskellPackages.monadplus pkgs.ghc ];
      };
    };
}

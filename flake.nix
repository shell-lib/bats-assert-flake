{
  description = "Bats-assert helper library";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ...}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        bats-assert = pkgs.stdenv.mkDerivation {
          name = "bats-assert";
          src = pkgs.fetchgit {
            url = "https://github.com/bats-core/bats-assert.git";
            rev = "v2.0.0";
            sha256 = "sha256-whSbAj8Xmnqclf78dYcjf1oq099ePtn4XX9TUJ9AlyQ=";
          };
          installPhase = ''
            mkdir -p $out/bin
            cp ./load.bash $out/bin/
            cp -r ./src $out/bin/
          '';
        };
        packages = { default = bats-assert; };
      });
}

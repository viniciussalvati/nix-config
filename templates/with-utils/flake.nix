{
  description = "Enter description";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        defaultPackage = pkgs.hello;
        devShell = with pkgs; mkShell {
          buildInputs = [
            # enter shell inputs here
          ];
        };
        # Enter aditional packages here
        packages = {
          hello = pkgs.hello;
        };
      });
}

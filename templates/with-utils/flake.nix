{
  description = "Enter description";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            # enter shell inputs here
          ];
        };
        # defaultPackage = pkgs.hello;
        /*
        packages = {
          # Enter aditional packages here
          hello = pkgs.hello;
        };
        */
      });
}

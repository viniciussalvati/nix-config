{
  nixpkgs-unstable,
  flake-utils,
  nixvim,
  ...
}@inputs:
let
  mkNixvim =
    system: extraOptions:
    let
      pkgs = nixpkgs-unstable.legacyPackages.${system};
      nixvimPkgs = nixvim.legacyPackages.${system};
    in
    nixvimPkgs.makeNixvimWithModule {
      inherit pkgs;

      module = (import ./config { inherit pkgs inputs; }) // extraOptions;

      extraSpecialArgs = {
        inherit pkgs inputs;
      };
    };
  lib = {
    inherit mkNixvim;
  };
in
flake-utils.lib.eachDefaultSystem (
  system:
  let
    nixvimLib = nixvim.lib.${system};
    nvim = mkNixvim system { };
  in
  {
    # Run `nix flake check .` to verify that your
    # config is not broken.
    checks.nixim = nixvimLib.check.mkTestDerivationFromNvim {
      inherit nvim;

      name = "Vinicius' nixvim configuration";
    };
    packages = {
      nixvim = nvim;
    };
  }
)
// {
  inherit lib;
}

{ nixpkgs-unstable, flake-utils, nixvim, ... }@inputs:
flake-utils.lib.eachDefaultSystem
  (system:
  let
    pkgs = nixpkgs-unstable.legacyPackages.${system};
    nixvimLib = nixvim.lib.${system};
    nixvimPkgs = nixvim.legacyPackages.${system};
    mkNixvim = extraOptions: nixvimPkgs.makeNixvimWithModule {
      inherit pkgs;

      module = (import ./config { inherit pkgs inputs; }) // extraOptions;

      extraSpecialArgs = { inherit pkgs inputs; };
    };
    nvim = mkNixvim { };
  in
  {
    # Run `nix flake check .` to verify that your
    # config is not broken.
    checks.nixim = nixvimLib.check.mkTestDerivationFromNvim {
      inherit nvim;

      name = "Vinicius' nixvim configuration";
    };
    packages = {
      inherit mkNixvim;
      nixvim = nvim;
    };
  })

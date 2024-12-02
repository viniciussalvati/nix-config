{
  flake-utils,
  nixpkgs-unstable,
  git-fuzzy,
  ...
}:
flake-utils.lib.eachDefaultSystem (
  system:
  let
    pkgs = nixpkgs-unstable.legacyPackages.${system};
    binPath =
      with pkgs;
      lib.makeBinPath [
        fzf
        eza
        coreutils # uses dirname
        git
        gnused
        ncurses5
        bc
        gawk
        gnugrep
        unixtools.column
      ];
  in
  {
    packages = {
      git-fuzzy = pkgs.stdenv.mkDerivation {
        name = "git-fuzzy";
        system = builtins.currentSystem;
        src = git-fuzzy;
        inherit binPath;
        inherit (pkgs) bash;

        nativeBuildInputs = [ pkgs.makeWrapper ];

        installPhase = # bash
          ''
            runHook preInstall

            mkdir -p $out/bin
            cp -r $src/bin $out
            cp -r $src/lib $out

            wrapProgram $out/bin/git-fuzzy \
              --set PATH "$binPath:$out/bin"

            runHook postInstall
          '';
      };
    };
  }
)

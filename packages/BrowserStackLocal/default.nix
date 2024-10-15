{
  nixpkgs,
  flake-utils,
  ...
}:
flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ] (
  system: with nixpkgs.legacyPackages.${system}; {
    packages.BrowserStackLocal = stdenv.mkDerivation (self: {
      # Both of these options should be overrideable.
      # Useful in case the hash changes and the flake has not been updated
      srcUrl = "https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip";
      srcHash = "sha256-EloQ1oOT2FeFLMLlGsKv1SJrrNmvy4YNuTKJMgnI0y4=";

      name = "BrowserStackLocal";

      src = fetchurl {
        url = self.srcUrl;
        hash = self.srcHash;
      };

      buildInputs = [
        gcc-unwrapped
      ];

      nativeBuildInputs = [
        autoPatchelfHook
        unzip
      ];

      sourceRoot = ".";

      unpackPhase = ''
        unzip $src
      '';

      installPhase = ''
        runHook preInstall
        install -m755 -D BrowserStackLocal $out/bin/BrowserStackLocal
        runHook postInstall
      '';

      meta = {
        homepage = "https://www.browserstack.com/";
        description = "BrowserStack Local testing app";
        downloadPage = "https://www.browserstack.com/docs/live/local-testing/set-up-local-testing#Linux";
        # license = lib.licenses.unfreeRedistributable;
        platforms = [ system ];
      };
    });
  }
)

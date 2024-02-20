{ pkgs }:
let
  stop-service-str = serviceName: /* bash */ ''
    if service --status-all 2>&1 | rg "${serviceName}" > /dev/null; then
      if service "${serviceName}" status > /dev/null; then
        sudo service "${serviceName}" stop
        echo "Stopped ${serviceName}"
      fi
    fi
  '';
  stop-agents-script = pkgs.writeShellApplication {
    name = "stop-agents";

    runtimeInputs = with pkgs;[ keychain ];

    text = /* bash */ ''
      ${stop-service-str "docker"}

      keychain --stop all
    '';
  };
in
[ stop-agents-script ]

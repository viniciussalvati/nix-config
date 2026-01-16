{ pkgs }:
let
  stop-service-str =
    serviceName: # bash
    ''
      # Stops ${serviceName}
      if service --status-all 2>&1 | rg "${serviceName}" > /dev/null; then
        if service "${serviceName}" status > /dev/null; then
          sudo service "${serviceName}" stop
          echo "Stopped ${serviceName}"
        fi
      fi
    '';
  stop-agents-script = pkgs.writeShellApplication {
    name = "stop-agents";

    runtimeInputs = with pkgs; [ keychain ];

    text = # bash
      ''
        ${stop-service-str "docker"}

        ${stop-service-str "dbus"}
        pkill dbus-launch || true
        pkill dbus-daemon || true

        keychain --stop all || true

        # wl-copy can be kept running when started by nixvim
        pkill wl-copy || true

        # exits with success status code
        exit 0
      '';
  };
in
[ stop-agents-script ]

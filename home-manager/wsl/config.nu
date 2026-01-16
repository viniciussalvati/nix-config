if (pwd) == "/mnt/c/Windows/System32" {
  cd ~
}

let keychain_shell_command = (SHELL=bash keychain --eval --quiet |
  parse -r '(?<name>\w+)=(?<quote>"?)(?<value>.*)\k<quote>; export \k<name>' |
  select name value |
  transpose -ird)
if not ($keychain_shell_command|is-empty) {
  $keychain_shell_command | load-env
}

let is_using_systemd = (systemctl status | complete | get exit_code) == 0

# Starts dbus so I don't end up with a lot of instances for commands that use it
if (not $is_using_systemd and (service dbus status | complete | get exit_code) == 3) {
  sudo service dbus start | ignore
}

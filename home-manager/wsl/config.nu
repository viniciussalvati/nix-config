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
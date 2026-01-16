# Loads the PATH
let nixStateProfile = $"($env.HOME)/.local/state/nix/profile"
let nixLink = if $env.XDG_STATE_HOME? != null and ($env.XDG_STATE_HOME | path exists) {
  $"($env.XDG_STATE_HOME)/nix/profile"
} else if ($nixStateProfile | path exists) {
  $nixStateProfile
} else {
  $"($env.HOME)/.nix-profile"
}

# Prevents other shells started from this one from adding the path again
# This allows us to use nix flakes and start a shell from vscode without losing the injected packages
let nixBin = $"($nixLink)/bin"
if not ($nixBin in $env.PATH) {
  $env.PATH = $env.PATH | prepend $nixBin
}

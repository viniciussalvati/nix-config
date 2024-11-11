# Loads the PATH
let nixStateProfile = $"($env.HOME)/.local/state/nix/profile"
let nixLink = if $env.XDG_STATE_HOME? != null and ($env.XDG_STATE_HOME | path exists) {
  $"($env.XDG_STATE_HOME)/nix/profile"
} else if ($nixStateProfile | path exists) {
  $nixStateProfile
} else {
  $"($env.HOME)/.nix-profile"
}

$env.PATH = $"($nixLink)/bin:$($env.path)"
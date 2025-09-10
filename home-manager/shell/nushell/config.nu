# Sets the Ctrl+L to clear the screen, instead of just scrolling
$env.config.keybindings = ($env.config.keybindings | append
  { name: clear_screen
    modifier: control
    keycode: char_l
    mode: emacs
    event: { send: ClearScrollback }
  }
)

# Creates and enter the path specified
def --env mkcd [
  path: directory # The path to create and change to
]: nothing -> nothing { mkdir $path; cd $path }

# Imports environment variables
#
# The string should be lines in the format, quotes in value are optional
# `export NAME="VALUE"`
#
# That is the same format used by bash/zsh's env command
def --env import-env []: [
  string -> nothing
  list<string> -> nothing
] {
  let lines: list<string> = if ($in | describe) == "string" { $in | lines } else { $in }
  $lines |
    parse 'export {key}={value}' |
    update value {
      if ($in | str starts-with '"') and ($in | str ends-with '"') {
        parse '"{value}"' | get value.0
      } else { $in }
    } |
    transpose -r -d | load-env $in
}

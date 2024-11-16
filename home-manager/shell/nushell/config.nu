$env.config.show_banner = false # Not show the banner when opening nushell
# $env.config.shell_integration.osc9_9 = true # Allows duplicating the terminal in the same path
$env.config.use_kitty_protocol = true # Enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.

# Sets the Ctrl+L to clear the screen, instead of just scrolling
$env.config.keybindings = ($env.config.keybindings | append
  { name: clear_screen
    modifier: control
    keycode: char_l
    mode: emacs
    event: { send: ClearScrollback }
  }
)

def --env mkcd [path: directory] { mkdir $path; cd $path }

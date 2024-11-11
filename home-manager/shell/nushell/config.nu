$env.config.show_banner = false

# Sets the Ctrl+L to clear the screen, instead of just scrolling
$env.config.keybindings = ($env.config.keybindings | append
  { name: clear_screen
    modifier: control
    keycode: char_l
    mode: emacs
    event: { send: ClearScrollback }
  }
)

$env.config.show_banner = false # Not show the banner when opening nushell
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

def --env import-env [exports: string] {
  $exports | lines | parse 'export {key}="{value}"' | transpose -r -d | load-env $in
}

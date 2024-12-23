# Begin shortcut to reset the terminal
function clear-screen-and-scrollback() {
  builtin echoti civis >"$TTY"
  builtin print -rn -- $'\e[H\e[2J' >"$TTY"
  builtin zle .reset-prompt
  builtin zle -R
  builtin print -rn -- $'\e[3J' >"$TTY"
  builtin echoti cnorm >"$TTY"
}
zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback
# End shortcut to reset the terminal

# Function that runs every time the prompt will be rendered
precmd() {
  # Prints a special command to the terminal so it can duplicate the tab in the same path
  printf "\e]9;9;%s\e\\" $PWD
}

# Enables alias-finder
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

# Configure docker plugin
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Adds a new key binding to navi widget
# This is because Ctrl+G alone was being delayed by fzf-git
bindkey '^g^g' _navi_widget
bindkey '^n' _navi_widget # This one makes more sense as a navi shorcut

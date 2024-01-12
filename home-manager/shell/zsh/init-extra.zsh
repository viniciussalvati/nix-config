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

# Function that runs everytime the prompt will be rendered
precmd() {
  # Prints a special command to the terminal so it can duplicate the tab in the same path
  printf "\e]9;9;%s\e\\" $PWD
}


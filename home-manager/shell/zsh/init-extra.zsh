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

# Function to set the terminal title
function set_terminal_title() {
  local title=$(echo $@ | rg "^$HOME" --replace '~')
 
  if [ "$title" = "" ]; then
    title="$PWD"
  fi

  local title_len=${#title}
  if [ $title_len -gt 25 ]; then
    local str_end=($title_len - 22)
    title=${title[$str_end,$title_len]}
    title="...$title"
  fi
  echo -en "\e]2;$title\a"
}

# Function that runs every time the prompt will be rendered
precmd() {
  # Prints a special command to the terminal so it can duplicate the tab in the same path
  printf "\e]9;9;%s\e\\" $PWD
  set_terminal_title $PWD
}

# Enables alias-finder
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

# Configure docker plugin
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Sets Ctrl+arrow keys to move cursor across words
bindkey ';5C' forward-word
bindkey ';5D' backward-word
# Configures the HOME, END, and DELETE keys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# Adds a new key binding to navi widget
# This is because Ctrl+G alone was being delayed by fzf-git
bindkey '^g^g' _navi_widget

# Gets the current branch name
# Some aliases use this command
git_current_branch() {
  git rev-parse --abbrev-ref HEAD
}

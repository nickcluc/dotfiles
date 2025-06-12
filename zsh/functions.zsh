# ------------------------------------------------------------------------------
# Utility Functions
# ------------------------------------------------------------------------------

# Make a folder and cd into it
mkcd() {
  mkdir -p "$1"
  cd "$1"
}

# Changes directory and lists directories contents
cdd() {
  cd "$1"
  ls
}

# Show Current Python Environment
currentenv() {
  conda env list | grep \* | cut -d " " -f 1
}

# Compile C++ Program
compilecpp() {
  g++ "$1".cpp -o "$1" &&
  ./"$1"
}

# Kill Rails server
killrails() {
  kill -9 $(cat tmp/pids/server.pid)
}

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

# SSH key management
load_ssh_keys() {
  ssh-add ~/.ssh/gravy-ssh.pem >/dev/null 2>&1
}

# Cross-platform notification helper
notify() {
  local title="${1:-Command completed}"
  local message="${2:-Done!}"
  local exit_code="${3:-0}"

  if [[ "$(uname)" == "Darwin" ]]; then
    if command -v terminal-notifier &> /dev/null; then
      if [[ $exit_code -eq 0 ]]; then
        terminal-notifier -title "$title" -message "$message" -sound "Glass"
      else
        terminal-notifier -title "Error: $title" -message "$message" -sound "Basso"
      fi
    fi
  elif [[ "$(uname)" == "Linux" ]]; then
    if command -v notify-send &> /dev/null; then
      if [[ $exit_code -eq 0 ]]; then
        notify-send "$title" "$message"
      else
        notify-send -u critical "Error: $title" "$message"
      fi
    fi
  fi
}

# Notify on long running commands (usage: notifyafter <command>)
notifyafter() {
  local start_time=$(date +%s)
  "$@"
  local exit_code=$?
  local end_time=$(date +%s)
  local duration=$((end_time - start_time))

  if [[ $duration -gt 10 ]]; then
    notify "Command finished" "\"$1\" took ${duration}s to complete" "$exit_code"
  fi
}

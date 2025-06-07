# ------------------------------------------------------------------------------
# Spaceship Theme Configuration
# ------------------------------------------------------------------------------

# Spaceship prompt configuration
# https://spaceship-prompt.sh/config/intro/

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# User
SPACESHIP_USER_SHOW=true
SPACESHIP_USER_PREFIX="with "

# Host
SPACESHIP_HOST_SHOW=false

# Directory
SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_TRUNC_REPO=false

# Git
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX="on "
SPACESHIP_GIT_SUFFIX=" "
SPACESHIP_GIT_SYMBOL=" "

# Git branch
SPACESHIP_GIT_BRANCH_SHOW=true
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_BRANCH_SUFFIX=""
SPACESHIP_GIT_BRANCH_COLOR="magenta"

# Git status
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_STATUS_PREFIX=" ["
SPACESHIP_GIT_STATUS_SUFFIX="]"
SPACESHIP_GIT_STATUS_COLOR="red"
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_ADDED="+"
SPACESHIP_GIT_STATUS_MODIFIED="!"
SPACESHIP_GIT_STATUS_RENAMED="»"
SPACESHIP_GIT_STATUS_DELETED="✘"
SPACESHIP_GIT_STATUS_STASHED="$"
SPACESHIP_GIT_STATUS_UNMERGED="="
SPACESHIP_GIT_STATUS_AHEAD="⇡"
SPACESHIP_GIT_STATUS_BEHIND="⇣"
SPACESHIP_GIT_STATUS_DIVERGED="⇕"

# Node.js
SPACESHIP_NODE_SHOW=true
SPACESHIP_NODE_PREFIX="node "
SPACESHIP_NODE_SUFFIX=" "
SPACESHIP_NODE_SYMBOL="⬢ "
SPACESHIP_NODE_DEFAULT_VERSION=""
SPACESHIP_NODE_COLOR="green"

# Ruby
SPACESHIP_RUBY_SHOW=true
SPACESHIP_RUBY_PREFIX="ruby "
SPACESHIP_RUBY_SUFFIX=" "
SPACESHIP_RUBY_SYMBOL="💎 "
SPACESHIP_RUBY_COLOR="red"

# Python
SPACESHIP_PYTHON_SHOW=true
SPACESHIP_PYTHON_PREFIX="python "
SPACESHIP_PYTHON_SUFFIX=" "
SPACESHIP_PYTHON_SYMBOL="🐍 "
SPACESHIP_PYTHON_COLOR="yellow"

# Execution time
SPACESHIP_EXEC_TIME_SHOW=true
SPACESHIP_EXEC_TIME_PREFIX="took "
SPACESHIP_EXEC_TIME_SUFFIX=" "
SPACESHIP_EXEC_TIME_COLOR="yellow"
SPACESHIP_EXEC_TIME_ELAPSED=2

# Character
SPACESHIP_CHAR_PREFIX=""
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_SYMBOL="➜"
SPACESHIP_CHAR_SYMBOL_ROOT="# "
SPACESHIP_CHAR_SYMBOL_SECONDARY="❯ "
SPACESHIP_CHAR_COLOR_SUCCESS="green"
SPACESHIP_CHAR_COLOR_FAILURE="red"

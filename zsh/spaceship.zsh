# Spaceship Prompt Configuration

# Order of prompt sections (only including available ones)
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# Prompt settings
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true  # Show prefix before first line
SPACESHIP_PROMPT_ADD_NEWLINE=true        # Add a newline before each prompt
SPACESHIP_PROMPT_SEPARATE_LINE=true      # Make the prompt span across two lines
SPACESHIP_PROMPT_PREFIXES_SHOW=true      # Show prefixes before prompt sections
SPACESHIP_PROMPT_SUFFIXES_SHOW=true      # Show suffixes before prompt sections

# Git settings
SPACESHIP_GIT_SHOW=true                  # Show git status
SPACESHIP_GIT_PREFIX="on "               # Prefix before git section
SPACESHIP_GIT_SUFFIX=" "                 # Suffix after git section
SPACESHIP_GIT_BRANCH_SHOW=true           # Show git branch
SPACESHIP_GIT_STATUS_SHOW=true           # Show git status indicators
SPACESHIP_GIT_STATUS_PREFIX=" ["         # Prefix before git status
SPACESHIP_GIT_STATUS_SUFFIX="]"          # Suffix after git status

# Directory settings
SPACESHIP_DIR_SHOW=true                  # Show directory section
SPACESHIP_DIR_PREFIX="in "               # Prefix before current directory
SPACESHIP_DIR_SUFFIX=" "                 # Suffix after current directory
SPACESHIP_DIR_TRUNC=3                    # Number of folders of the current path to show

# Execution time settings
SPACESHIP_EXEC_TIME_SHOW=true            # Show execution time
SPACESHIP_EXEC_TIME_PREFIX="took "       # Prefix before execution time section
SPACESHIP_EXEC_TIME_SUFFIX=" "           # Suffix after execution time section
SPACESHIP_EXEC_TIME_ELAPSED=2            # Show execution time after this many seconds

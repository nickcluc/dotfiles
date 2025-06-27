# ------------------------------------------------------------------------------
# ZSH Configuration Aliases
# ------------------------------------------------------------------------------

# ZSH Configuration
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias src="source ~/.zshrc"

# Cursor IDE
alias cursor="cursor --no-sandbox"

# ------------------------------------------------------------------------------
# Files/Movement
# ------------------------------------------------------------------------------

# Quick clear of terminal
alias c="clear"

# Show hidden files
alias l.="ls -d .* --color=auto"

# Use ls with color and show hidden files
alias ls="ls -A --color=auto"

# Quick Home Directory
alias home="cd ~"

# A quick way to get out of current directory
alias ..="cd .."
alias ...="cd ../../../"
alias ....="cd ../../../../"
alias .....="cd ../../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../.."

# Colorize the grep command output for ease of use (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Search Through Terminal History
alias hs="history | grep"

# Make mount command output pretty / readable
alias mount="mount |column -t"

# Create a new set of commands
alias path="echo -e ${PATH//:/\\n}"
alias now="date +\"%T\""
alias nowtime=now
alias nowdate="date +\"%d-%m-%Y\""

# ------------------------------------------------------------------------------
# System Info
# ------------------------------------------------------------------------------

# Pass options to free
alias meminfo="free -m -l -t"

# Show top process eating MEMORY
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"

# Show top process eating CPU
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"

# ------------------------------------------------------------------------------
# Security
# ------------------------------------------------------------------------------

# Tune sudo and su
alias root="sudo -i"
alias su="sudo -i"

# Lockscreen shortcut
alias lockscreen="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# ------------------------------------------------------------------------------
# Ruby/Rails
# ------------------------------------------------------------------------------

# Rails Commands
alias rg="rails generate"
alias rc="rails console"
alias rs="rails server"
alias rgc="rails generate controller"
alias rgmd="rails generate model"
alias rgm="rails generate migration"
alias rgr="rails generate resource"
alias rgbt="rails g bootstrap:themed"

# Database Commands
alias rdbm="rake db:migrate"
alias rdbm0="rake db:migrate VERSION=0"
alias rdbmu="rake db:migrate:up"
alias rdbmd="rake db:migrate:down"
alias rdbr="rake db:rollback"
alias rdbc="rake db:create"
alias rdbp="rake db:drop"
alias rdbs="rake db:seed"
alias rdbhr="pgr && rake db:drop db:create db:migrate db:schema:dump db:setup" # db hard reset

# Routes
alias rr="rake routes"
alias rrg="rake routes | grep"

# Bundle Commands
alias be="bundle exec"
alias ber="bundle exec rspec"
alias bi="bundle install"
alias biwp="bundle install --without production"
alias bup="bundle update"
alias bui="bundle update && bundle install" # Bundle update and install

# Rails Setup Helpers
alias sud="rails generate devise:install && rails generate devise"
alias sudbs="rails generate bootstrap:install static && rails g devise:views:locale en && rails g devise:views:bootstrap_templates"

# RBENV
alias rbv="rbenv install" # Install a specific Ruby version
alias rbg="rbenv global" # Sets the global version of Ruby to be used in all shells
alias rbh="rbenv rehash" # Run this command after you install a new version of Ruby

# RVM
alias rvmlid="rvm use ruby --latest --install --default" # RVM latest stable ruby install as default
alias bs="gem install bundle && bundle install" # Bundle Setup, adds the bundle gem and updates
alias bsu="gem install bundle && bundle update && bundle install" # Bundle Setup, adds the bundle gem and updates

# MySQL
alias msr="sudo /etc/init.d/mysql stop && sudo /etc/init.d/mysql start" # Restart MySQL server

# Pry Rails Console
alias pryrailsc="pry -r ./config/environment"

# Testing
alias spex="bundle exec rails test"

# Rubocop
alias rr="bundle exec rubocop --force-exclusion \$(git diff --diff-filter=d --name-only main)"
alias rra="bundle exec rubocop --force-exclusion \$(git diff --diff-filter=d --name-only main) -A"

# ------------------------------------------------------------------------------
# Python
# ------------------------------------------------------------------------------

alias python="python3.12"
alias pip="pip3"
alias venv="source bin/activate"
alias dea="deactivate"

# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------

# Git shortcuts are mostly handled by oh-my-zsh git plugin
# Add any custom git aliases here
alias gco="git checkout"

# ------------------------------------------------------------------------------
# Fun
# ------------------------------------------------------------------------------

alias :fire:="🔥"

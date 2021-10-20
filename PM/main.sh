#! /usr/bin/zsh

# -------------------------------------------
#                  Setup
# -------------------------------------------
#Setting projects folder
PM_FOLDER="${PM_FOLDER="$HOME/.vars/PM"}"
if [[ ! -d $PM_FOLDER ]]; then
  mkdir $PM_FOLDER
fi

PM_PROJECTS_LOG="${PM_PROJECTS_LOG="$HOME/.vars/PM/initialization.log"}"
if [[ ! -f $PM_PROJECTS_LOG ]]; then
  touch $PM_PROJECTS_LOG
  PM::log "First created"
fi

# Setting projects file
PM_PROJECTS_FILE="${PM_PROJECTS_FILE="$HOME/.vars/PM/projects"}"
if [[ ! -f $PM_PROJECTS_FILE ]]; then
  touch $PM_PROJECTS_FILE
  PM::log "Add projects file"
fi

#Setting current project file
PM_CURRENT_PROJECT_FILE="${PM_CURRENT_PROJECT_FILE="$HOME/.vars/PM/current_projects"}"
if [[ ! -f $PM_CURRENT_PROJECT_FILE ]]; then
  touch $PM_CURRENT_PROJECT_FILE
  PM::log "Add current project file"
fi

source ~/zsh_aliases/PM/lib.sh
source ~/zsh_aliases/PM/functions.sh

PM::update "Cannot find current project in initialization"

# -------------------------------------------
#                  Alias
# -------------------------------------------

alias setpu="PM::push && PM::set"
alias pupro="PM::push"
alias sepro="PM::set"
alias rmpro="PM::remove"
alias prolis="PM::list"
alias go="PM::go"
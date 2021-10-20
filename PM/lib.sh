#! /usr/bin/zsh

function PM::log()
{
  echo "$(date +%c): $1" >> $PM_PROJECTS_LOG
}

# Update envariomental variables
function PM::update()
{
  PM_PROJECTS=(`cat $PM_PROJECTS_FILE`)
  CWP=`cat $PM_CURRENT_PROJECT_FILE`

  if [[ -z $CWP || ! -d $CWP ]]; then
    PM_NO_PROJECT="true"
    CWP=""
    [[ -n $1 ]] && PM::log $1
  else
    PM_NO_PROJECT="false"
  fi
}

function PM::get_from_id()
{
  local pro_id
  pro_id=$2
  if [[ $pro_id == 0 || -z $pro_id ]]; then
    eval "${1}=$PWD"
    return
  fi
  for ((id=1; id<=${#PM_PROJECTS[@]}; id++)); do
    if [[ $id == $pro_id ]]; then
      eval "${1}=${PM_PROJECTS[$id]}"
      return
    fi
  done
}
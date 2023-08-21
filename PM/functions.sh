#! /usr/bin/bash

function PM::set()
{
  local pro_id SWP exist_in_stack
  pro_id=$1
  PM::get_from_id SWP $pro_id
  exist_in_stack=`grep "^$SWP$" < $PM_PROJECTS_FILE`
  
  if [[ -z $exist_in_stack ]]; then
    echo "Push your project before setting as Current Working Project"
    return
  elif [[ $SWP = $CWP ]]; then
    echo "Current project is already $SWP"
    return
  elif [[ ! -d $exist_in_stack ]]; then
    echo "Project doesn't exist, but is pushed, delete it to have a better usage of Project Menager"
    return
  fi

  echo -n "Set $SWP as Current Working Project? [Y/n]" 
  read ANSWER
  case $ANSWER in
    y|Y)
      echo $SWP > $PM_CURRENT_PROJECT_FILE
      PM::update
      # echo $SWP > $projects_file
      # for i in ${projects[@]}; do
      #   if [[ $i != $SWP ]]; then
      #     echo $i >> $projects_file
      #   fi
      # done
    ;;
    *)
      echo "Current project still $CWP"
    ;;
  esac
}
function PM::push()
{
  local pro_id SWP exist_in_stack
  pro_id=$1
  PM::get_from_id SWP $pro_id
  exist_in_stack=`grep "^$SWP$" < $PM_PROJECTS_FILE`
  if [[ -n $exist_in_stack ]]; then
    echo "You already pushed this project"
    return
  elif [[ ! -d $SWP ]]; then
    echo "Project doesn't exist, create it to push"
    return
  fi
  echo -n "Push $SWP? [Y/n]" 
  read ANSWER
  case $ANSWER in
    y|Y)
        echo "$SWP" >> $PM_PROJECTS_FILE
        PM::update
    ;;
    *)
      echo "No project pushed"
    ;;
  esac
}

function PM::remove()
{
  local pro_id SWP exist_in_stack
  pro_id=$1
  PM::get_from_id SWP $pro_id
  exist_in_stack=`grep "^$SWP$" < $PM_PROJECTS_FILE`
  if [[ ! -d $SWP && -n $exist_in_stack ]]; then
    echo "Project directory doesn't exit, but is pushed"
    echo -n "Remove $SWP? [Y/n]"
  elif [[ ! -d $SWP && -z $exist_in_stack ]]; then
    echo "Project directory doesn't exist"
    return
  elif [[ -d $SWP && -z $exist_in_stack ]]; then
    echo "Project haven't been pushed, can't remove"
    return
  elif [[ -d $SWP && -n $exist_in_stack ]]; then
    echo -n "Remove $SWP? [Y/n]"
  fi

  read ANSWER
  case $ANSWER in
    y|Y)
      #Esvazia arquivo antes de colocar os projetos denovo
      : > $PM_PROJECTS_FILE
      for i in ${PM_PROJECTS[@]}; do
        if [[ $i != $SWP ]]; then
          echo $i >> $PM_PROJECTS_FILE
        fi
      done
      #Se o projeto para remover for igual ao CWP aciona a  flag PM_NO_PROJECT
      if [[ "$SWP" == "$CWP" ]]; then
        : > $PM_CURRENT_PROJECT_FILE
      fi
      PM::update
    ;;
    *);;
  esac
}

function PM::go()
{
  if [[ -n $1 ]]; then
    cd ${PM_PROJECTS[$1]}
  elif [[ $PM_NO_PROJECT == false ]]; then
    cd $CWP
  else
    echo "Ther is not a current project, set one to go"
  fi
}

function PM::list_set()
{
  local callback=PM::set
  PM::select_option "${PM_PROJECTS[@]}"
}

function PM::list_go()
{
  local callback=PM::go
  PM::select_option "${PM_PROJECTS[@]}"
  return
}

function PM::list_remove()
{
  local callback=PM::remove
  if [[ $1 == 0 || -z "$1" ]]; then
    PM::select_option "${PM_PROJECTS[@]}"
  else
    $callback $1
  fi
  
}
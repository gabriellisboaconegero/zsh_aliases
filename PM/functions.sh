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
  if [[ -z $exist_in_stack ]]; then
    echo "Project haven't been pushed, can't remove"
    return
  elif [[ ! -d $SWP ]]; then
    echo "Project doesn't exist, can't rmeove"
    return
  elif [[ ! -d $exist_in_stack ]]; then
    echo "Poject doesn't exist but is pushed"
  fi

  echo -n "Remove $SWP? [Y/n]" 
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
  if [[ $PM_NO_PROJECT == false ]]; then
    cd $CWP
  else
    echo "Ther is not a current project, set one to go"
  fi
}

function PM::list()
{
  local color end
  for i in `seq 1 ${#PM_PROJECTS[@]}`; do
    color=''
    end=''
    if [[ $CWP == ${PM_PROJECTS[$i]} ]];  then
      color='\e[1;4;32m'
      end='\e[21;24;39m'
    fi
    echo -e "${color}[$i]$end - ${PM_PROJECTS[$i]}"
  done
}
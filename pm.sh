#! /usr/bin/zsh

function usage(){
  cat <<EOF
Project Menager Options
$@

    Usage: project_menager <[options]>
    Options: 
      -s, --set=PROJECT
          Set PROJECT as current working project.
          If no PROJECT passed then current working  directory is set.
      -r, --remove=PROJECT
        Set PROJECT as current working project.
        If no PROJECT passed then current working  directory is set.
      -l, --list
          Show proect list

      -h, --help
          Show this message
      
      PROJECT
          Number of representing the index of the project on the project list.
          1 is for current working project.
EOF
  exit 1
}

function list(){
  for i in `seq 1 ${#projects[@]}`; do
    echo "[$i] - ${projects[$i]}"
  done
}

function getProjectById(){
  if [[ $pro_id = 0 ]]; then
    CWP=$PWD
    return
  fi
  for ((id=1; id<=${#projects[@]}; id++)); do
    if [[ $id = $1 ]]; then
      CWP=${projects[$id]}
      return
    fi
  done
  usage "Não tem nenhum programa com index $1"
}

function removeproject(){
  local pro_id=$1
  getProjectById $pro_id
  exist=`grep "^$CWP$" < $projects_file`
  if [[ -z $exist ]]; then
    echo "Projeto não foi adicionado portanto não pode ser retirado"
    return
  fi
  echo -n "Quer remover projeto $CWP? [Y/n]" 
  read ANSWER
  case $ANSWER in
    y|Y)
      if [[ ! -d $exist ]]; then
        echo "Diretório do projeto não exite mais, retirando $CWP"
      fi
      echo "" > $projects_file
      for i in ${projects[@]}; do
        if [[ $i != $CWP ]]; then
          echo $i >> $projects_file
        fi
      done
    ;;
    *);;
  esac
}

function setproject(){
  local pro_id=$1
  getProjectById $pro_id
  echo -n "Quer colocar como projeto principal $CWP? [Y/n]" 
  read ANSWER
  case $ANSWER in
    y|Y)
      exist=`grep "^$CWP$" < $projects_file`
      if [[ ! -d $exist ]]; then
        echo $CWP >> $projects_file
      fi
      echo $CWP > $current_project_file
      # echo $CWP > $projects_file
      # for i in ${projects[@]}; do
      #   if [[ $i != $CWP ]]; then
      #     echo $i >> $projects_file
      #   fi
      # done
    ;;
    *)
      echo "O projeto atual continua ${projects[1]}"
    ;;
  esac
}

projects_file=$HOME/.vars/projects
current_project_file=$HOME/.vars/current_project

# Verificar se existe o diretório ./vars e o arquivo current_project nele
if [ ! -d $HOME/.vars ];  then
  mkdir .vars
  echo "$HOME/.vars criado"
fi

if [ ! -f $projects_file ];  then
  touch $projects_file
  echo "$projects_file created"
fi

if [ ! -f $current_project_file ];  then
  touch $current_project_file
  echo "$current_project_file created"
  echo "Esse é o primeiro project adicionado"
  setproject 0
  exit 0
fi

SET_PROJECT="0"
projects=(`cat $projects_file`)

[[ $# = 0 ]] && usage "Nenhum parâmetro passado"

while getopts ":hsrl-:" OPT; do
  if [ "$OPT" = "-" ]; then   # long option: reformulate OPT and OPTARG
    OPT="${OPTARG%%=*}"       # extract long option name
    OPTARG="${OPTARG#$OPT}"   # extract long option argument (may be empty)
    OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
    offset=0
  else
    offset=1
  fi

  case $OPT in
    s | set)
      eval nextopt=\${$((OPTIND + $offset))}  #next arg after the OPT
      if [[ -n $nextopt && $nextopt != -* ]]; then  #If has arg
        OPTIND=$((OPTIND + 1)) #shift the OPTIND
        OPTARG=$nextopt
      elif [[ -z $OPTARG ]]; then
        OPTARG="0"
      fi
      project_id=$OPTARG
      ACTION="set"
    ;;
    r | remove)
      eval nextopt=\${$((OPTIND + $offset))}  #next arg after the OPT
      if [[ -n $nextopt && $nextopt != -* ]]; then  #If has arg
        OPTIND=$((OPTIND + 1)) #shift the OPTIND
        OPTARG=$nextopt
      elif [[ -z $OPTARG ]]; then
        OPTARG="0"
      fi
      project_id=$OPTARG
      ACTION="remove"
    ;;
    l | list) list;;
    h | help) usage;;
    *) 
      usage "Parâmetro inválido $OPT"
    ;;
  esac
done

case $ACTION in
  set) setproject $project_id;;
  remove) removeproject $project_id
esac
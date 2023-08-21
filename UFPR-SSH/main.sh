function UFPR-SSH::usage(){
  cat <<EOF
UFPR SSH manager and Connector
$@

    Usage: ufprssh <[Options]>
    Options: 
      -s, --ssh
          Connect to LOGIN@ssh.inf.ufpr.br
      -m, --macalan
          Connect to LOGIN@macalan.c3sl.ufpr.br
      -h, --help
          Show this message
      LOGIN
          Your ufpr Dinf login, name initials and freshman year (Ex: glc22)
EOF
}

function UFPR-SSH::connect(){
  local server flags cmd
  local login="glc22"
  cmd=( "ufprssh" $@ )
  flags=()
  if [[ "$#" == "0" ]] UFPR-SSH::usage $cmd && return 1
  while [[ $# != 0 ]]; do
  case "$1" in
    -m | --macalan )
      server="$login@macalan.c3sl.ufpr.br"
    ;;
    -cp1 )
        server="$login@cpu1.c3sl.ufpr.br"
    ;;
    -s | --ssh )
      server="$login@ssh.inf.ufpr.br"
      flags+=("-CY")
    ;;
    -h | --help )
       UFPR-SSH::usage $cmd
       return
    ;;
    * )
       UFPR-SSH::usage $cmd
       return 1
    ;;
  esac; shift; done
  ssh ${flags[@]} $server
}

function UFPR-SSH::secure-copy(){
    flags=()
    from=""
    if [[ "$#" -lt "2" ]]; then
        echo "ufprscp <from> <to>"
        return 1
    fi
    if [[ $1 == "-r" ]]; then
        flags+=$1
        shift
    fi
    for i in seq 2; do
        str_=$1
        case $1 in
            uf:* )
                str_="glc22@macalan.c3sl.ufpr.br:${1##uf:}"
            ;;
        esac
        if (( $i == 0 )); then
            from=$str_
        else
            to=$str_
        fi

        shift
    done

    scp ${flags[@]} $from $to
}

alias ufprssh="UFPR-SSH::connect"
alias ufprscp="UFPR-SSH::secure-copy"
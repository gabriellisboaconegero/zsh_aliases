function PM::list()
{
  local color end
  for i in `seq 1 ${#PM_PROJECTS[@]}`; do
    echo -e "`get_current_pro_colors $i` ➜ ${PM_PROJECTS[$i]}"
  done
}

function get_current_pro_colors(){
  local color=''
  local end=''
  if [[ $CWP == ${PM_PROJECTS[$1]} ]];  then
    color='\e[1;4;32m'
    end='\e[21;24;39m'
  fi
  echo -e "${color}[$1]${end}"
}

function PM::select_option(){
  key_input(){
    read -s -k 1 key
    if [[ $key = $'\033' ]]; then
      read -s -k 2 key
      if [[ $key = "[A" ]]; then
        echo up
      elif [[ $key = "[B" ]]; then
        echo down
      fi
    elif [[ $key = $'\x0a' ]]; then
      echo enter
    fi
  }

  get_cursor_row(){
    exec < /dev/tty
    oldstty=$(stty -g)
    stty raw -echo min 0
    # on my system, the following line can be replaced by the line below it
    tput u7 > /dev/tty    # when TERM=xterm (and relatives)
    read -r -d R pos
    stty $oldstty
    # change from one-based to zero based so they work with: tput cup $row $col
    pos=${pos##*"["}
    row=${pos%%";"*}    # strip off the esc-[
    col=${pos##*";"}
    echo $row
  }

  show_option(){
    echo "  `get_current_pro_colors $1` $2"
  }

  show_selected_option(){
    echo "➜ `get_current_pro_colors $1` $2"
  }

  # initially print empty new lines (scroll down if at bottom of screen)
  for opt; do printf "\n"; done
  # determine current screen position for overwriting the options
  local lastrow=`get_cursor_row` 
  local startrow=$(($lastrow - $# - 1))

  cle(){
    echo "hello"
    tput cnorm
  }

  # ensure cursor and input echoing back on upon a ctrl+c during read -s
  trap "cle" EXIT
  tput civis

  local selected=0
  while true; do
      # print options by overwriting the last lines
      local idx=0
      for opt; do
          tput cup $(($startrow + $idx)) 0
          if [[ $idx -eq $selected ]]; then
              show_selected_option $(($idx + 1)) $opt
          else
              show_option $(($idx + 1)) $opt
          fi
          ((idx++))
      done
      # user key control
      case `key_input` in
          enter) break;;
          up)    ((selected--));
                  if [[ $selected -lt 0 ]]; then selected=$(($# - 1)); fi;;
          down)  ((selected++));
                  if [[ $selected -ge $# ]]; then selected=0; fi;;
      esac
  done

  # cursor position back to normal
  tput cup $lastrow 0
  tput cnorm

  $callback $(($selected + 1))
}
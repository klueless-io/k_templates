# HELPERS

function kl_exit_error {
  echo "missing dependency: $1"
  exit -1
}

function kl_heading {
  kl_line
  echo $1
  kl_line
}

function kl_subheading {
  echo -e "[ \033[93m$1\033[0m ]"
}

function kl_line {
  echo '----------------------------------------------------------------------'
}

function kl_cmd {
  # -n = NO Line Feed
  # echo -n ": $1 : "
  echo -n "[ $1 ]"
}

function kl_cmd_end {
  # echo ":[ OK ]"
  echo " - OK"
}

function kl_cmd_done {
  echo "  $1"
}
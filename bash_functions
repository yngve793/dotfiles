
extend_dune_control_path(){
#  echo "$#"
#  echo "OLD DUNE_CONTROL_PATH=${DUNE_CONTROL_PATH}"
  path_to_add=${PWD}
  if [ "$#" -ge 1 ]; then
    if [[ "${1}" == "--help" || "${1}" == "-h" ]]; then
      echo "extend_dune_control_path PATH_TO_ADD PATH_TO_ADD"
      echo ""
      echo "If PATH_TO_ADD is not specified the current working directory is added"
      return 0
    else
  #    IFS=":"
  #    path_to_add="${*}"
      path_to_add=""
      for path in "$@"
      do
        if [[ "${path}" == /* ]]; then
          if [[ "${path_to_add}" == "" || "${DUNE_CONTROL_PATH}" == :*  ]]; then
            path_to_add="${path}"
          else
            path_to_add="${path}:${path_to_add}"
          fi
        else
          path_to_add="${PWD}/${path}:${path_to_add}"
        fi
      done
      echo "${path_to_add}"
    fi
  fi
  export DUNE_CONTROL_PATH="${path_to_add}""${DUNE_CONTROL_PATH}"

#  if [ -z "${DUNE_CONTROL_PATH}" ]; then
#    export DUNE_CONTROL_PATH="${path_to_add}"
#  else
#    export DUNE_CONTROL_PATH="${path_to_add}":"${DUNE_CONTROL_PATH}"
#  fi
  echo "NEW DUNE_CONTROL_PATH=${DUNE_CONTROL_PATH}"
  return 0
}

show_dune_control_path(){
  echo "DUNE_CONTROL_PATH=${DUNE_CONTROL_PATH}"
  return 0
}

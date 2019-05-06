#!bash
#
#	.bash_functions - useful function definitions...
#

# d1626a3
# 2018-12-15 13:11:41 -0700

# cpd - create backup of file(s) with date/time appended and our initials
#
function cpd () {
  local timestamp=$(date +"-%y%m%d-%H%M-fpp")

  for file in "$@"
  do
    if [ -f "${file}${timestamp}" ]; then
      echo "Warning:  ${file}${timestamp} already exists, overwriting." 1>&2
    fi
    cp "${file}"{,"${timestamp}"}
  done
}

function mcd () {
  mkdir "${1}" && cd "$_" || return
}

# mkreal - replace a symlink with a real file...
#
function mkreal () {
  for file in "$@"
  do
    if [ -L "${file}" ] && [ -f "${file}" ]; then
      echo "Replacing ${file}..."
      mv "${file}" "${file}"~
      cp "${file}"~ "${file}"
      chmod u+w "${file}"
    else
      echo "Warning:  ${file} is not a symlink to a file - skipping..."
    fi
  done
}

# Start a process/application in the background after changing
# directory to my home directory to avoid busying out a mount
# point in my wanderings.
#
function run () {
  local timestamp=$(date +"%y%m%d-%H%M-fpp")

  pushd "${HOME}"
  $1 "$@" >> ~/tmp/"${1}".log-"${timestamp}" 2>&1 &
  popd
}

# xrs - Resize screen...
#
function xrs () {
  eval "$(resize -u)"

  if [ "${LINES}" != "" ]; then
    stty rows "${LINES}" columns "${COLUMNS}"
  fi
}


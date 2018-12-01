#!bash
#
#	.bash_functions - useful function definitions...
#

# $Id$
# $Date$

# cpd - create backup of file(s) with date/time appended and our initials
#
cpd () {

  local timestamp=`date +"-%y%m%d-%H%M-fpp"`

  for file in $*
  do
    if [ -f ${file}${timestamp} ]; then
      echo "Warning:  ${file}${timestamp} already exists, overwriting." 1>&2
    fi
    cp ${file}{,${timestamp}}
  done
}

# cpdotfiles - copy Bash and project dot files to the current directory

cpdotfiles () {

  set -			~pascal/.bashrc				\
			~pascal/.bash_profile			\
	${PLATFORM:+	~pascal/.bash_${PLATFORM}}		\
	${HOST:+	~pascal/.bash_${HOST}}			\
			~pascal/.bash_aliases			\
			~pascal/.bash_functions			\
			~pascal/.projectrc			\
			~pascal/.projectrc-internet		\
	${HOST:+	~pascal/.projectrc-${HOST}}		\

  cp -p $* ~/
}

# e - edit selected files
#
e () {
  emacsclient $*							\
	|| emacs $*							\
	|| vi $*
}

# manat - look for man page at specific man path...
#
manat() {
  (MANPATH=$1; shift ;  man $*)
}

# mkreal - replace a symlink with a real file...
#
mkreal() {
  for file in $*
  do
    if [ -L $file -a -f $file ]; then
      echo "Replacing $file..."
      mv $file $file~
      cp $file~ $file
      chmod u+w $file
    else
      echo "Warning:  $file is not a symlink to a file - skipping..."
    fi
  done
}

# Login as "root" on a remote host...
#
root() {
  xrl -l root --bg yellow --fg red ${*:-"localhost"}
}

# Start a process/application in the background after changing
# directory to my home directory to avoid busying out a mount
# point in my wanderings.
#
run() {
  pushd $HOME
  $1 $* >> ~/tmp/run.log 2>&1 &
  popd
}

# wrprotd - write protect all files in a directory tree
#
wrprotd() {
  chmod -w `find $* -type f -print`
}

# xrs - Resize screen...
#
xrs() {
  eval `resize -u`

  if [ "$LINES" != "" ]; then 
    stty rows $LINES columns $COLUMNS
  fi
}

# Csh compatiblity...
#
setenv() {
  export $1=$2
}

unsetenv() {
  unset $1
}

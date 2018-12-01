#  ~/.bashrc - Bourne Again SHell init file.
#
#  This file is usually called by ~/.bash_profile, but can be ran
#  as standalone.
#

# echo output
#set -x

# Files you make look like rw-rw-r
#
umask 022

# Don't make useless coredump files.  If you want a coredump,
# say "ulimit -c unlimited" and then cause a segmentation fault.
#
#ulimit -c unlimited

##############################################################################
#
# Determine some needed info about our environment...
#
export     HOST=$(uname -n)             # hostname
export       OS=$(uname -s)             # OS
export   OS_REV=$(uname -r | sed -e 's#(.*)##') # OS Revision

export PLATFORM=${OS}-${OS_REV}-${HOSTTYPE} # platform identifier

if [ "$PS1" ]; then
  echo "Setting up for ${HOSTTYPE} host, running ${OS} ${OS_REV}..."
fi

# These two functions get used by everything...

##############################################################################
#
# mkpath - Walk through possible paths and return what exists...
#
function mkpath () {
  for arg; do
    echo "${arg}:" | \
      while read -d : dir; do
        if [ -d "${dir}" ]; then
          echo -n "${dir}:"
        fi
      done
  done
}

##############################################################################
#
# mkfilepath - return a path string consisting of existing directories
#          and/or files.
#
function mkfilepath () {
  local paths"=`echo $* | sed 's/:/ /g'`"
  local rval=""

  for i in $paths
  do
    if [ -d ${i} -o -f ${i} ]; then
      # The following line will only add a colon if $rval is non null..
      #
      [ "$rval" ] && rval=${rval}:${i} || rval=${i}
    fi
  done

  echo $rval
}

##############################################################################
#
# findpath - Walk through possible paths and return first valid path...
#
function findpath () {
  local paths"=`echo $* | sed 's/:/ /g'`"
  local rval=""

  for i in $paths
  do
    if [ -d $i ]; then
      rval=$i
      break
    fi
  done

  echo $rval
}

##############################################################################
#
# findfile - Walk through possible file paths and return first valid path...
#
function findfile () {
  local paths"=`echo $* | sed 's/:/ /g'`"
  local rval=""

  for i in $paths
  do
    if [ -f $i ]; then
      rval=$i
      break
    fi
  done

  echo $rval
}

# Host type specific BASH aliases and functions...
#
if [ -f ~/.bash_$PLATFORM ]; then
  source ~/.bash_$PLATFORM
fi

# Host specific BASH aliases and functions...
#
if [ -f ~/.bash_$HOST ]; then
  source ~/.bash_$HOST
fi

# Process project related stuff (if it exists)...
# 
if [ -f ~/.projectrc ]; then
  source ~/.projectrc
fi

##############################################################################
# P A T H S . . . 
##############################################################################

# X11 path...
#
X11="${X11}:                                        \
    /tools/X11R5/bin:                               \
    /tools/X11R6/bin:                               \
    /opt/gnome/bin:                                 \
    ${KDEDIR:+$KDEDIR/bin:}                         \
    /usr/openwin/bin:                               \
    /usr/X11R6/bin:                                 \
    /usr/X386/bin:                                  \
    /usr/bin/X11                                    \
    "

# Local path...
#
LOCAL="${LOCAL}:                                    \
    /usr/local/bin                                  \
    /usr/local/*/bin                                \
    "

# System path...
#
SYSTEM="${SYSTEM}:                                  \
    /sw/bin:                                        \
    /sw/sbin:                                       \
    /tools/sysad/bin:                               \
    /usr/local/sbin/:                               \
    /usr/sbin:                                      \
    /sbin:                                          \
    /usr/lib/nis:                                   \
    /etc:                                           \
    /usr/etc                                        \
    "

# Opt(ional) path... (this is primarly for Sol2.x)
#
OPT="${OPT}:                                        \
    /opt/SUNWspro/bin:                              \
    /opt/SUNWwabi/bin:                              \
    /opt/SUNWconn/bin                               \
    "

# Applications path...
#
APPS="${APPS}:                                      \
    /apps/JDK/bin:                                  \
    /apps/JWS/sparc-S2/bin:                         \
    /apps/netscape:                                 \
    /opt/netscape:                                  \
    /usr/local/Acrobat5/bin                         \
    /usr/local/firefox                              \
    /usr/local/mozilla:                             \
    /usr/local/netscape:                            \
    /usr/local/MozillaFirebird:                     \
    /tools/pbmplus/bin:                             \
    /tools/mirror-2.3:                              \
    /apps/transcript/bin:                           \
    /tools/tex/bin:                                 \
    /usr/unsupported/sybooks/sun5m/bin              \
    /usr/X11R6/enlightenment/bin                    \
    "

# Standard path...
#
STD="${STD}:                                        \
    /usr/ccs/bin:                                   \
    /bin:                                           \
    /usr/ucb:                                       \
    /usr/bin                                        \
    "

# My local path within my home directory...
#
MY_PATH="${MY_PATH}                                 \
    $HOME/bin/$PLATFORM:                            \
    $HOME/bin                                       \
    "

# Build $PATH...
#
export PATH=`mkpath                                 \
    $MY_PATH                                        \
    $PROJECT_PATH                                   \
    $HOST_PATH                                      \
    $PLATFORM_PATH                                  \
    $X11?                                           \
    $LOCAL                                          \
    $OPT                                            \
    ${ORACLE_HOME:+$ORACLE_HOME/bin}                \
    ${INFORMIXDIR:+$INFORMIXDIR/bin}                \
    ${SYBASE:+$SYBASE/bin}                          \
    ${PBHOME:+$PBHOME/bin}                          \
    $SYSTEM                                         \
    $APPS                                           \
    $STD                                            \
    .                                               \
`

unset MY_PATH X11 LOCAL OPT SYSTEM APPS STD

##############################################################################
# Shared library path...
#
if [ "$LD_LIBRARY_PATH" ]; then
  export LD_LIBRARY_PATH=`mkpath                    \
                ${LD_LIBRARY_PATH}                  \
                /tools/X11R5/lib                    \
                /tools/X11R6/lib                    \
                /usr/X11R6/lib                      \
                /usr/openwin/lib                    \
                ${MOTIFHOME:+$MOTIFHOME/lib}        \
                /opt/SUNWmotif/lib                  \
                /usr/local/lib                      \
                ${ORACLE_HOME:+$ORACLE_HOME/lib}    \
                ${INFORMIXDIR:+$INFORMIXDIR/lib}    \
                ${SYBASE:+$SYBASE/lib}              \
                ${PBHOME:+$PBHOME/bin}              \
                ${PBHOME:+$PBHOME/windu/lib.sol2}   \
                `
fi

##############################################################################
# Perl Support...
#
#if [ ! "$PERL5LIB" ]; then
#  export PERL5LIB=`mkpath  
#		${PERL5LIB}                         \
#		$HOME/lib/perl5                     \
#		/usr/local/lib/perl5                \
#		`
#fi

##############################################################################
# If we are running interactive...
##############################################################################

if [ "$PS1" ]; then

  # Make it so that failed `exec' commands don't flush this shell.
  #
  no_exit_on_failed_exec=

  shopt -s extglob cdspell cdable_vars 

  stty intr  erase  kill  echoe

  # Determine which port we're coming in on...
  #
  TTY=`tty | sed 's^/dev/^^'`
  if [ "$TTY" = "/dev/console" ]; then
    TTY="console"
  fi

  case "${TERM}" in
    xterm-color | *color) color_prompt=yes ;;
    *) unset color_prompt ;;
  esac

  # Build prompt string for any non-login shell invocations...
  #
  case "${EUID}" in
    0)	PS1="${color_prompt:+\e[0;31m}\u@\h # ${color_prompt:+\e[0m}"
        ;;
    *)  PS1="\u@\h ${MYPROJECT:+[${MYPROJECT}] }\$(__git_ps1 ' (%s) ')"
        PS1="${PS1}${color_prompt:+\\[\e[1;35m\\]}<\#> "
        PS1="${color_prompt:+\\[\e[1;33m\\]}${PS1}"
        PS1="${SSH_AGENT_PID:+${color_prompt:+\\[\e[1;32m\\]}* }${PS1}" 
        PS1="${color_prompt:+\\[\e[1;36m\\]}\w\n${PS1}" 
        PS1="${color_prompt:+\\[\e[0m\\]}${PS1}${color_prompt:+\\[\e[0m\\]}"
        ;;
  esac

  # Tailor some bash behavior...
  #
  rm -f $HISTFILE
  unset HISTFILE
  export HISTFILESIZE=${HISTFILESIZE:-256}
  export HISTCONTROL=ignoreboth
  unset MAILCHECK

  # Local printer...
  #
  if [ ! "$PRINTER" -a -f ~/.default_printer ]; then
    export PRINTER=`cat ~/.default_printer`
  fi

  # Tailor our working environment...
  #
  if [ "`type -path editclient`" \!= "" ]; then
    export EDITOR=`type -path editclient`
  else
    export EDITOR=vi
  fi
  export PAGER=less
#  export LESS=-Ms
  export LESS=MeFRX


  # Determine where to locate man pages...
  #
  export MANPATH=`mkpath                    \
		${MANPATH}                  \
                /usr/local/man              \
                /usr/local/lib/perl5/man    \
                /tools/X11R5/man            \
                /tools/X11R6/man            \
                /tools/sysad/man            \
                /usr/X11R6/man              \
                /usr/share/man              \
                /usr/man                    \
                `

  export INFOPATH=`mkpath                   \
		/sw/share/info              \
		/sw/info                    \
		/usr/share/info             \
		`

  # BASH aliases...
  # 
  if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
  fi

  # BASH functions...
  # 
  if [ -f ~/.bash_functions ]; then
    source ~/.bash_functions
  fi

  if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi

  # X application resource path...
  #
  export XAPPLRESDIR=`mkpath                                \
                        $HOME/lib/app-defaults              \
                        /tools/X11R5/lib/X11/app-defaults   \
                        /tools/X11R6/lib/X11/app-defaults   \
                        /usr/X11R6/lib/X11/app-defaults     \
                        /usr/unsupported/hotmetal           \
                        `

  # Force rehash of path...
  #
  hash -r

fi

# EOF:  .bashrc

export ALTERAOCLSDKROOT="/local/altera/16.0/hld"

export QSYS_ROOTDIR="/local/altera/16.0/quartus/sopc_builder/bin"

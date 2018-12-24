#  ~/.bashrc - Bourne Again SHell init file.
#
#  This file is usually called by ~/.bash_profile, but can be ran
#  as standalone.
#

# 68636e2
# 2018-12-01 17:06:29 -0700

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
else
  [ "$PS1" ] && echo Creating ~/.bash_${PLATFORM}...
  ln -s ~/.bash_${OS} ~/.bash_${PLATFORM}
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
    $HOME/bin/${PLATFORM}                           \
    $HOME/bin                                       \
    $HOME/.local/bin                                \
    $HOME/.scripts                                  \
    $HOME/.scripts/*                                \
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

  if [ "${DISPLAY}" ]; then
    TERM=xterm
  else
    TERM=vt220
  fi

  if [ "$(tput colors)" -gt 0 ]; then
    color_prompt=yes

#    GIT_PS1_HIDE_IF_PWD_IGNORED=yes
    GIT_PS1_DESCRIBE_STYLE=yes
    GIT_PS1_SHOWDIRTYSTATE=yes
    GIT_PS1_SHOWSTASHSTATE=yes
    GIT_PS1_SHOWUNTRACKEDFILES=yes
    GIT_PS1_SHOWUPSTREAM=yes
#    GIT_PS1_STATESEPARATOR
    GIT_PS1_SHOWCOLORHINTS=yes

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

  else
    unset color_prompt
  fi

  # Build prompt string for any non-login shell invocations...
  #
  case "${EUID}" in
    0)	PS1="${color_prompt:+\e[0;31m}\u@\h # ${color_prompt:+\e[0m}"
        ;;
    *)  ULOCK=$([[ "${LANG}" =~ 'UTF-8' ]] && echo $'\U1f512' || echo "*")
	UPROMPT=$([[ "${LANG}" =~ 'UTF-8' ]] && echo $'\U1F449' || echo ">")
	PS1="\u@\h ${MYPROJECT:+[${MYPROJECT}] }\$(__git_ps1 ' (%s) ')"
        PS1="${PS1}${color_prompt:+\\[\e[1;35m\\]}[\#] ${UPROMPT} "
        PS1="${color_prompt:+\\[\e[1;33m\\]}${PS1}"
        PS1="${SSH_AGENT_PID:+${color_prompt:+\\[\e[1;32m\\]}${ULOCK} }${PS1}"
        PS1="${color_prompt:+\\[\e[1;36m\\]}\w\n${PS1}"
        PS1="${color_prompt:+\\[\e[0m\\]}${PS1}${color_prompt:+\\[\e[0m\\]}"
	unset ULOCK UPROMPT
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
  export LESS=iMeFRX
  export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
  export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
  export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
  export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
  export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
  export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
  export LESS_TERMCAP_ue=$'\E[0m'        # reset underline


  # Determine where to locate man pages...
  #
  export MANPATH=`mkpath                    \
		${MANPATH}                  \
                /usr/local/man              \
                /usr/local/lib/perl5/man    \
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

  # Force rehash of path...
  #
  hash -r

fi

export ALTERAOCLSDKROOT="/local/altera/16.0/hld"
export QSYS_ROOTDIR="/local/altera/16.0/quartus/sopc_builder/bin"

# EOF:  .bashrc


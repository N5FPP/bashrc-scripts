# $File$

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'

alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [ "${PS1}" ] && [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Internet
alias yt="youtube-dl --add-metadata -ic" # Download video link
alias yta="yt -x -f bestaudio/best" # Download only audio
alias YT="youtube-viewer"

alias CPAN="perl -MCPAN -e shell"
alias f=finger
alias h=history
alias j=jobs
alias l=less
alias m=more

alias please='sudo $(fc -nl -1)'

alias khup="pkill -hup"
alias md=mkdir
alias pg="pgrep -lf"
alias pk="pkill"
alias rerc="source ~/.bashrc"
alias rerdb="xrdb -merge ~/.Xresources"
alias reshell='SHLVL=`expr $SHLVL - 1` ; exec $SHELL'
alias rexhost="xhost \`cat ~/.xhosts\`"
alias rd=rmdir
alias subs="grep Subject:"
alias tc="tar zcf"
alias tx="tar zxf"
alias tt="tar ztf"
alias tcv="tar zcvf"
alias txv="tar zxvf"
#alias xrs='eval \`resize -u\`'
alias xp="xprop WM_NAME WM_CLASS"
alias zc=zcat

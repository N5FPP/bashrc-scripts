# $File$

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'

alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [ "$PS1" -a -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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

alias md=mkdir
alias pg="pgrep -lf"
alias pk="pkill"
alias rerc="source ~/.bashrc"
alias reshell='SHLVL=`expr $SHLVL - 1` ; exec $SHELL'
alias retty="kill -HUP 1"
alias rexhost="xhost \`cat ~/.xhosts\`"
alias rd=rmdir
alias subs="grep Subject:"
alias tc="tar zcf"
alias tx="tar zxf"
alias tt="tar ztf"
alias tcv="tar zcvf"
alias txv="tar zxvf"
#alias xrs='eval \`resize -u\`'
alias zc=zcat

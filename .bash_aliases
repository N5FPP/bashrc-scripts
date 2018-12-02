# $File$

# enable color support of ls and also add handy aliases
if [ "$PS1" -a -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias	CPAN="perl -MCPAN -e shell"
alias	dirs="dirs -l -v"
alias	f=finger
alias	h=history
alias	j=jobs
alias	l=less
alias	lo="logout"
alias	k=kermit
alias	k9="kill -9"
alias	khup="kill -HUP"
alias	m=more
alias	md=mkdir
alias	pg="pgrep -lf"
alias	pk="pkill"
alias	rerc="source ~/.bashrc"
alias	reshell='SHLVL=`expr $SHLVL - 1` ; exec $SHELL'
alias	retty="kill -HUP 1"
alias	rexhost="xhost \`cat ~/.xhosts\`"
alias	rl=rlogin
alias	rd=rmdir
alias	sadd='ssh-add'
alias	sagent='exec ssh-agent $SHELL'
alias	subs="grep Subject:"
alias	tc="tar zcf"
alias	tx="tar zxf"
alias	tt="tar ztf"
alias	tcv="tar zcvf"
alias	txv="tar zxvf"
alias   xg="xlsclients -a | grep -v grep | egrep"
#alias	xrs='eval \`resize -u\`'
alias	xsu='xsudo su -'
alias	xsudo='xrl -e sudo'
alias	zc=zcat


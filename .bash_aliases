# $Header$

#  ~/.bash_aliases - non-hosttype specific BASH aliases...

alias	a=alias
alias	c=compress
alias	cls=clear
alias	clr=clear
#alias	cpdotfiles="cp ~pascal/.{bash{rc,_{profile,$PLATFORM,$HOST,aliases,functions}},projectrc{,internet}} ~"
alias	CPAN="perl -MCPAN -e shell"
#alias   dirs="dirs 2>&1 | perl -F'/\s/' -ane '\$i = - scalar @F; foreach (@F) { printf \"%2d - %s\n\", ++\$i, \$_ }'"
alias	dirs="dirs -l -v"
alias	f=finger
alias	H="history | sort +1 | uniq +7"
alias	h=history
alias	j=jobs
alias	l=less
alias	lf="ls -CF"				# just line SCO Xenix 2.3 :-)
alias	lls="ls -lasF"
alias	lo="logout"
alias	ls="ls -CF"
alias	k=kermit
#alias	kermit=kermit-190
alias	k9="kill -9"
alias	khup="kill -HUP"
alias	m=more
alias	md=mkdir
#alias	netscape="run netscape -install"
#alias	ns="(cd ~/transient; netscape &)"
#alias	nsi="(cd ~/transient; netscape -install &)"
alias	pg="pgrep -alfi"
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
alias	u=users
alias	uc=uncompress
alias	ud=uncompressdir
alias	ue=emacs
#alias	xarchie=xarchie-R5
alias   xg="xlsclients -a | grep -v grep | egrep"
#alias	xrs='eval \`resize -u\`'
alias	xsu='xsudo su -'
alias	xsudo='xrl -e sudo'
alias	zc=zcat

# $Header$	

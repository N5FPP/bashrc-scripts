# bashrc-scripts

My Bash startup scripts that handle multiple hosts and platforms

These dot-files are my bash shell startup scripts. They configure my environment
taking into account the hosting OS and the hostname of the system.

Typically these scripts will pickup 95% of my environment configuration simply by
dropping them into place and restarting my login session.

These scripts are executed in the following order:

	.bashrc
		.bash_{PLATFORM tuple}
		.bash_{HOST}
		.projectrc
			[.projectrc-{HOST}}
		.bash_aliases
		.bash_functions
		.bash_completion	


The PLATFORM tuple is defined as:

	export     HOST=$(uname -n)
	export       OS=$(uname -s)
	export   OS_REV=$(uname -r | sed -e 's#(.*)##')

	export PLATFORM=${OS}-${OS_REV}-${HOSTTYPE}


# WARNING!!! WARNING!!! WARNING!!!!

These scripts apply to my own personal environment. If 
you are dumb enough to use them without vetting them for
your own use and environment, you get what you deserve.

Do not come back to me if these scripts destroy your
computer, cause your dog to run away from home, your 
spouse to find a smarter partner, acne to break out
across your skin, cause your cows to stop giving milk,
etc. etc. etc.


# $CommitHashAbbreviated$ $CommitterDateISO8601$

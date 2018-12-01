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



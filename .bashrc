# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
# User specific aliases and functions

unalias rm >/dev/null 2>&1
unset -f rm
rm ()
{
	if [[ 0 -eq $# ]]
	then
		/usr/bin/rm
		Ret=$?
		return $Ret
	fi
	SRC=$(echo "$@" | sed "s/-f //;s/-rf //;s/-fr //;s/-r //;s/ -rf //g;s/ -fr //g;s/^\-rf //;s/^\-fr //;")
	echo "$SRC" | /usr/bin/grep "\/$" >/dev/null 2>&1
	Ret=$?
	if [ 0 -eq $Ret ]
	then
		SRC=$(echo -ne "$SRC" | /usr/bin/sed "s/\/$//;")
	fi
	if [[ -L "$SRC" ]]
	then
		echo "rm -i $SRC"
		/usr/bin/rm -i "$SRC"
	elif [[ -f "$SRC" ]]
	then
		echo "rm -i $SRC"
		/usr/bin/rm -i "$SRC"
	elif [[ -d "$SRC" ]]
	then
		echo "rm -ir $SRC"
		/usr/bin/rm -ir "$SRC"
	else
		# echo "Update rm function to handle:"
		echo "rm -ir $@"
		/usr/bin/rm -ir $@
	fi
	Ret=$?
	return $Ret
}
export PS1='[33m$LOGNAME@$IPv4 [32m$PWD [0m[ $? ]
$ '
IPv4=$(/usr/sbin/ip -f inet addr show dev em1 2>&1 |\
/usr/bin/awk '"inet" == $1 {
	printf( "%s", substr( $2, 1, index( $2, "/")-1 ) );
}')
alias c='echo -ne "[H[J"'
alias clear='echo -ne "[H[J"'
alias ls='/usr/bin/ls -ltr'
alias ll='/usr/bin/ls -ltr'
alias lla='/usr/bin/ls -latr'
echo "$PATH" | /usr/bin/grep -E "^\.:|:\.:|:\.$" >/dev/null 2>&1
Ret=$?
if [ 0 -ne $Ret ]
then
	export PATH="$PATH:."
fi
if [ "" = "$ORACLE_HOME" ]
then
	export ORACLE_HOME=/ora11gclnt/product/11.2.0/client_1
fi
echo "$PATH" | /usr/bin/grep -E "^\/ora11gclnt\/product\/11\.2\.0\/client_1\/bin:|:\/ora11gclnt\/product\/11\.2\.0\/client_1\/bin:|:\/ora11gclnt\/product\/11\.2\.0\/client_1\/bin$" >/dev/null 2>&1
Ret=$?
if [ 0 -ne $Ret ]
then
	export PATH="$ORACLE_HOME/bin:$PATH"
fi
if [[ "" = "$LD_LIBRARY_PATH" ]]
then
	export LD_LIBRARY_PATH=/ora11gclnt/product/11.2.0/client_1/lib
else
	echo "$LD_LIBRARY_PATH" |\
	/usr/bin/grep -E "^\/ora11gclnt\/product\/11\.2\.0\/client_1\/lib:|:\/ora11gclnt\/product\/11\.2\.0\/client_1\/lib:|:\/ora11gclnt\/product\/11\.2\.0\/client_1\/lib$" >/dev/null 2>&1
	Ret=$?
	if [[ 0 -ne $Ret ]]
	then
		export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/ora11gclnt/product/11.2.0/client_1/lib"
	fi
fi
alias sqlplus='$ORACLE_HOME/bin/sqlplus LYCABLUCHERTESTNEW3/lyca@RDDEVDB'
ulimit -c unlimited
unalias swap >/dev/null 2>&1
unset -f swap
swap ()
{
	if [[ 0 -eq $# ]]
	then
		echo -ne "[H[J[33m$LOGNAME@$IPv4 [32m$PWD [0m[ $? ]\n$ swap\n"
	else
		echo -ne "[H[J[33m$LOGNAME@$IPv4 [32m$PWD [0m[ $? ]\n$ swap $@\n"
	fi
	echo "/usr/bin/find . -type f -name \".*.s[a-z][a-z]\""
	/usr/bin/find . -type f -name ".*.s[a-z][a-z]" 2>/dev/null |\
	/usr/bin/grep -E -v "^$"
	Ret=$?
	/usr/bin/find . -type f -name delete*.txt 2>/dev/null |\
	/usr/bin/grep -E -v "^$"
	/usr/bin/find . -type f -name delete*.sh 2>/dev/null |\
	/usr/bin/grep -E -v "^$"
	/usr/bin/find . -type f -name core* 2>/dev/null |\
	/usr/bin/grep -E -v "^$|\/core\.c$|\.core\.cpp$|\.pc$"
	return $Ret
}
set -o vi
unset -f lcd
lcd ()
{
	if [ 0 -eq $# ]
	then
		echo "lcd cpp"
		echo "lcd python"
		Ret=$?
		return $Ret
	fi
	if [ "python" = "$1" ]
	then
		cd ~/.python
		Ret=$?
		return $Ret
	fi
	if [ "cpp" = "$1" ]
	then
		cd ~/SampleProgram
		Ret=$?
		return $Ret
	fi
	cd "$@"
	Ret=$?
	return $Ret
}

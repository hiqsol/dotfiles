#!/bin/csh

alias l     ls -loFG
alias ll	ls -loFG
alias la	ls -loFGA
alias tt	traceroute
alias tl	tail -f
alias scr	screen
alias .		cd ..
alias ..	cd ../..
alias ...	cd ../../..

# A righteous umask
umask 002

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/bin)

setenv	EDITOR		vim
setenv	PAGER		less
setenv	BLOCKSIZE	K

if ($?prompt) then
	# An interactive shell -- set some stuff up
	set filec
	set history = 100
	set savehist = 100
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif
endif

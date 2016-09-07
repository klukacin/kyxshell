# Listing
alias ls='ls -G'
alias l='ls -CF'
alias l.='ls -d .*'
alias la='ls -A'
alias ll='ls -al'
alias lssh='alias |grep ssh'

#file actions
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

#file setups
alias fixd='find . -type d -exec chmod 775 {} '\'';'\'''
alias fixf='find . -type f -exec chmod 664 {} '\'';'\'''
alias fixhta='sed -i -e s/FollowSymLinks/SymLinksIfOwnerMatch/g $(find . -name *htaccess)'
alias tx='tar xvzf '

#sessions
alias ta='tmux attach-session'
alias tk='tmux new -s kyxshellsession'
alias tak='tmux a -t kysshellsession'

#Various
alias which='/usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias howmuch='du -h --max-depth=1 |less'

#Zipping
#zip each file separately
alias zipall='for i in */; do zip -r "${i%/}.zip" "$i"; done'
alias zipcalc='find . -mindepth 1 -maxdepth 1 -exec zip -r {} {} \;'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git svn-fast-info)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Aliases
alias c='clear'
alias h='cd ~'
alias v='vim'
alias rb='ruby'
alias w='cd ~/www/'
alias x='exit'
alias vssh='vagrant ssh'
alias vup='vagrant up'
alias vstat='vagrant global-status'
alias host='sudo vim /etc/hosts'
alias n98='php n98-magerun/bin/n98-magerun'
alias pl='cd ~/www/PlayExplorers/src';
alias cms='cd /Users/Justin/www/QBlitz/CMS/src'
alias ctags="/usr/local/Cellar/ctags/5.8/bin/ctags -R ."
# bad pattern, use https://vaultproject.io/
alias creds="pbcopy < ~/www/PlayExplorers/assets/creds/creds.pub"
alias qcreds="pbcopy < ~/www/QBlitz/CMS/assets/creds/creds.pub"
alias wcreds="pbcopy < ~/www/WeldWheels/assets/creds/creds.pub"
alias rcreds="pbcopy < ~/www/Roadkill/assets/creds/creds.pub"
alias roadkill="cd ~/www/Roadkill/src/hgv_data/sites/php/wp-content/themes/road-kill"
alias offgrid="cd ~/www/OffGrid/htdocs/hgv_data/sites/hhvm"
alias ten="cd ~/www/enthusiast/src"
alias recoil="cd ~/www/RecoilWeb/src"

# Functions
ds () {
	echo "Disk Space Utilization for $HOSTNAME"
	df -h
}
# extract current compressed filed -> provide argument
extract () {
	    if [ -f $1 ] ; then
			        case $1 in
						*.tar.bz2)  tar xjf $1      ;;
						*.tar.gz)   tar xzf $1      ;;
						*.bz2)      bunzip2 $1      ;;
						*.rar)      rar x $1        ;;
						*.gz)       gunzip $1       ;;
						*.tar)      tar xf $1       ;;
						*.tbz2)     tar xjf $1      ;;
						*.tgz)      tar xzf $1      ;;
						*.zip)      unzip $1        ;;
						*.Z)        uncompress $1   ;;
						*)          echo "'$1' cannot be extracted via extract()" ;;
					esac
		else
			echo "'$1' is not a valid file"
		fi
}

#empy apt archive to free up disk space
freeSpace () {
	echo "Disc Space I can clean:"
	du -sh /var/cache/apt/archives
	read "reply?Would you like me to do some house-keeping? (y/n) -> "
	if [[ $reply =~ ^[Yy]$ ]] 
	then
		sudo apt-get clean
	fi	
}

updateBundle() {
	echo "Updating Pathogen Plugins:"
	cd ~/.vim/bundle/
	for i in `ls`; do
		cd "$i"
		git pull
		cd ..
	done
}

# make dirs for magento extension
magentoExt() {
	mkdir Block/ controllers/ etc/ Helper/ Model/ sql/
}

# update /etc/hosts file for vagrant use
updateHosts() {
	# Check to see if en0 is inactive
	state=$(ifconfig en0 | grep -ci 'status: inactive')
	if [[ $state == 1 ]]; then
		addresses=$(ifconfig en1 | egrep -o '([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}')
		addresses=( $=addresses )
	else
		addresses=$(ifconfig en0 | egrep -o '([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}')
		addresses=( $=addresses )
	fi
	#
	# get the /etc/hosts vm address
	vhost=$(sed '11q;d' /etc/hosts)
	vhost=( $=vhost )

	# search and replace values
	if [[ "${vhost[1]}" == "${addresses[1]}" ]]; then
		echo "Yeah they match, Vagrant up, bitch!"
		return
	fi

	sudo sed -i -e "s/${vhost[1]}/${addresses[1]}/g" /etc/hosts
	echo "Yeah Vagrant up, bitch!"
	return
}


# backup playworld
bckPlay() {
	cd ~/www/PlayExplorers/bckp/PlayExplorers/src/
	git pull origin master
	git fetch
	cd ../../
	tar -zcvf playexplorers-bckp-$(date +"%Y-%m-%d").tar.gz PlayExplorers/
}

# ruby, composer, docker
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export DOCKER_CERT_PATH=/Users/Justin/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376

eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

TERM=screen-256color
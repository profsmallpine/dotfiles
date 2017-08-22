# ------------------------------
# - Personal dotfiles goodness -
# ------------------------------

### Aliases

# Bash goodness
alias reload="source ~/.bash_profile"

# File goodness
alias wur="cd ~/Documents/development/bethel_music/worshipu-rails"
alias wup="cd ~/Documents/development/bethel_music/worshipu-pyramid"
alias farm="cd ~/Documents/development/tucker_family_farm/farm"
alias mor="cd ~/Documents/development/gray_olive/mortgagecrm"
alias list="cd ~/Documents/development/amz_list_builder/AMZ-LB-FE"

# Python goodness
alias pserve="pserve development.ini --reload"
alias pshell="pshell development.ini"

# Rails goodness
alias be="bundle exec"
alias ber="bundle exec rspec"
alias reset="bundle exec rake db:reset"
alias sunspot="bundle exec rake sunspot:solr:start"

# Random goodness
alias popcorn="open $TMPDIR/Popcorn-Time"

### Init

# Default editor
export EDITOR="atom -w"

# Language managers
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi;
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi;

### Utilities

# Python goodness
ptest() {
  underscore_word=$2
  spaces_word=${underscore_word//[_]/ }
  titlecase_word=$(echo $spaces_word | awk '{for(j=1;j<=NF;j++){ $j=toupper(substr($j,1,1)) substr($j,2) }}1' | awk '{ gsub (" ", "", $0); print}')
  BROWSER=phantomjs nosetests --tests worshipu.tests.$1.$2:$titlecase_word.$3
}

# Tab to complete git branches
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

### Misc

# Path updates
export PATH="$HOME/bin:$PATH";
export PATH="$PATH:/usr/local/opt/go/libexec/bin";
export GOPATH="$HOME/go";
export PATH="$PATH:$GOPATH/bin";

# Random vars
export NLS_LANG="AMERICAN_AMERICA.UTF8";

# ---------------------
# - Dotfiles goodness -
# ---------------------

# https://github.com/barryclark/bashstrap

### Aliases

# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias popcorn="open $TMPDIR/Popcorn-Time"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Colored up cat!
# You must install Pygments first - "sudo easy_install Pygments"
alias c='pygmentize -O style=monokai -f console256 -g'

# Git
# You must install Git first
alias gs='git status'
alias g.='git add .'
alias gm='git commit -m' # requires you to type a commit message
alias gp='git push'
alias grm='git rm $(git ls-files --deleted)'

### Prompt Colors
# Modified version of @gf3’s Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		MAGENTA=$(tput setaf 9)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
	else
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	BOLD=""
	RESET="\033[m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]]
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⚡ "

export PS1="\[${MAGENTA}\]\u \[$RESET\]in \[$GREEN\]\W\[\033[32m\]\[$RESET\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$RESET\] $symbol \[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"


### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

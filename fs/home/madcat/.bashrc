### Loading the git script, that allows the fetching of the current branch name
. /usr/share/git/completion/git-prompt.sh

### Setting the Comandline Design ###
FINAL_CHAR="$"
if [ $EUID -eq 0 ]; then
	FINAL_CHAR="#"
fi

# There are two ways to set it, either via PROMPT_COMMAND or PS1

# PROMPT_COMMAND Variant. This is slightly faster, according to __git_ps1 documentation
PROMPT_COMMAND='__git_ps1 "\[\e[31m\]\u\[\e[0m\]@\h \[\e[30;47m\][\w]\[\e[0m\]\[\e[31m\]" "\[\e[0m\]\n$FINAL_CHAR "'

# PS1 Variation
#PS1="\[\e[31m\]\u\[\e[0m\]@\h \[\e[30;47m\][\w]\[\e[0m\]\[\e[31m\]\$(__git_ps1)\[\e[0m\]\n$FINAL_CHAR "

### Adding ~/.local/bin to Path
export PATH="$HOME/.local/bin:$PATH"


### This is for enabling auto-completion for uv (the python package manager)
eval "$(uv generate-shell-completion bash)"

### This is for adding direnv to each cd call
eval "$(direnv hook bash)"


### Load Pywal Theme for this terminal
(cat ~/.cache/wal/sequences &)

### Aliasi ( NOTE: There are some in /etc/bash.bashrc as well)
alias man=batman
alias rg=batgrep

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

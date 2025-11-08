### Setting the Comandline Design ###
FINAL_CHAR="$"
if [ $EUID -eq 0 ]; then
	FINAL_CHAR="#"
fi

PS1="\[\e[31m\]\u\[\e[0m\]@\h \[\e[30;47m\][\w]\[\e[0m\]$FINAL_CHAR "

### Adding ~/.local/bin to Path
export PATH="$HOME/.local/bin:$PATH"


### Load Pywal Theme for this terminal
(cat ~/.cache/wal/sequences &)


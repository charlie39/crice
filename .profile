# Profile file. Runs on login. Environmental variables are set here(Though most of them are set in $XDG_CONFIG_HOME/ENV)
# Adds ~/.local/bin` to $PATH
export PATH="$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//'):$PATH"

#export XDG environment variables from '~/.config/ENV'
eval "$(sed 's/^[^#].*/export &/g;t;d' ~/.config/ENV)"
#
# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
"

[ ! -f "$XDG_CONFIG_HOME/shortcutrc" ] && ref >/dev/null 2>&1

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx $XINITRC

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys "$XDG_DATA_HOME"/larbs/ttymaps.kmap 2>/dev/null
#Add ssh key to ssh agent
# [ -v SSH_AUTH_SOCK ] && ssh-add ~/.ssh/git
# ssh-add ~/.ssh/git


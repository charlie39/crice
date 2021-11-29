# Profile file. Runs on login. Environmental variables are set here(Though most of them are set in $XDG_CONFIG_HOME/ENV)
# Adds ~/.local/bin` to $PATH
export PATH="$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//'):$PATH"
#X=X server; W=Wayland
export XW="W"
#export XDG environment variables from '~/.config/ENV'
eval "$(sed 's/^[^#].*/export &/g;t;d' ~/.config/ENV)"

#exort wayland specific configs
[[ $XW = "W" ]] && eval "$(sed 's/^[^#].*/export &/g;t;d' ~/.config/wayland/WAYLAND_ENV)"
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

# Start X server or Wayland compositor on tty1 if not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
   if ! ps -e | grep -qw Xorg ; then
       if [[ "$XW" = "X" ]]; then
            exec startx $XINITRC
        elif ! [ "$(pidof river)" ]; then
           # exec ssh-agent river
           # exec ssh-agent sway
           exec ssh-agent wayfire
           # exec dwl -s 'source ~/.config/startup'
       fi
   fi
fi
# Switch escape and caps if tty and no passwd required:
# sudo -n loadkeys "$XDG_DATA_HOME"/larbs/ttymaps.kmap 2>/dev/null
#Add ssh key to ssh agent
# [ -v SSH_AUTH_SOCK ] && ssh-add ~/.ssh/git

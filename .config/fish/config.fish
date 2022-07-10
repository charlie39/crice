# vim: filetype=sh
abbr h "cd ~/; and lsd"
abbr d "cd ~/Documents; and lsd"
abbr dp "cd ~/Documents/PDF; and lsd"
abbr dpJ "cd ~/Documents/PDF/Java; and lsd"
abbr dpP "cd ~/Documents/PDF/Python; and lsd"
abbr dpA "cd ~/Documents/PDF/Android; and lsd"
abbr dpJS "cd ~/Documents/PDF/JS; and lsd"
abbr dpPHP "cd ~/Documents/PDF/PHP; and lsd"
abbr dpDO "cd ~/Documents/PDF/DevOps; and lsd"
abbr dpSS "cd ~/Documents/PDF/ShellScripting; and lsd"
abbr D "cd ~/Downloads; and lsd"
abbr DS "cd ~/Downloads/Shared; and lsd"
abbr DL "cd ~/Downloads/Linux; and lsd"
abbr M "cd ~/Music; and lsd"
abbr Mv "cd ~/Music/videos; and lsd"
abbr pp "cd ~/Pictures; and lsd"
abbr ppP "cd ~/Pictures/Personal; and lsd"
abbr ppT "cd ~/Pictures/Trash; and lsd"
abbr ppw "cd ~/Pictures/Wallpapers; and lsd"
abbr ppwg "cd ~/Pictures/Wallpapers/gifs; and lsd"
abbr ppM "cd ~/Pictures/Memes; and lsd"
abbr vv "cd ~/Videos; and lsd"
abbr vvw "cd ~/Videos/WebSeries; and lsd"
abbr vvm "cd ~/Videos/Movies; and lsd"
abbr vvmb "cd ~/Videos/Movies/Bollywood; and lsd"
abbr vvmh "cd ~/Videos/Movies/Hollywood; and lsd"
abbr vvmk "cd ~/Videos/Movies/Korean; and lsd"
abbr vvmr "cd ~/Videos/Movies/Russian; and lsd"
abbr vvt "cd ~/Videos/Tutorials; and lsd"
abbr vvtm "cd ~/Videos/Tutorials/MyStudio; and lsd"
abbr pr "cd ~/packages/repos; and lsd"
abbr pra "cd ~/packages/repos/arm-aarch64; and lsd"
abbr prs "cd ~/packages/repos/st; and lsd"
abbr prv "cd ~/packages/repos/voidrice; and lsd"
abbr prc "cd ~/packages/repos/crice; and lsd"
abbr prr "cd ~/packages/repos/river; and lsd"
abbr prd "cd ~/packages/repos/dwm; and lsd"
abbr prl "cd ~/packages/repos/dwl; and lsd"
abbr prdb "cd ~/packages/repos/dwmblocks; and lsd"
abbr cac "cd ~/.cache; and lsd"
abbr cacp "cd ~/.cache/paru; and lsd"
abbr cacpc "cd ~/.cache/paru/clone; and lsd"
abbr P "cd ~/Downloads/Project; and lsd"
abbr pj "cd ~/Downloads/Project/Java; and lsd"
abbr pjg "cd ~/Downloads/Project/Java/games; and lsd"
abbr pjs "cd ~/projects/java/spring; and lsd"
abbr pje "cd ~/projects/java/javaee; and lsd"
abbr sd "cd ~/.local/share; and lsd"
abbr sds "cd ~/.local/share/scripts; and lsd"
abbr sb "cd ~/.local/bin; and lsd"
abbr sbs "cd ~/.local/bin/statusbar; and lsd"
abbr sbi3 "cd ~/.local/bin/i3cmds; and lsd"
abbr sbc "cd ~/.local/bin/cron; and lsd"
abbr sbl "cd ~/.local/bin/links; and lsd"
abbr sl "cd ~/.local/lib; and lsd"
abbr sdp "cd ~/.local/share/password-store; and lsd"
abbr cf "cd ~/.config; and lsd"
abbr Cb "cd ~/.config/bash; and lsd"
abbr Cr "cd ~/.config/river; and lsd"
abbr Cz "cd ~/.config/zsh; and lsd"
abbr Czc "cd ~/.config/zsh; and lsd"
abbr Ci "cd ~/.config/i3; and lsd"
abbr Cy "cd ~/.config/sway; and lsd"
abbr Czo "cd ~/.config/zsh/omz; and lsd"
abbr Czop "cd ~/.config/zsh/omz/plugins; and lsd"
abbr Czocp "cd ~/.config/zsh/omz/custom/plugins; and lsd"
abbr Cv "cd ~/.config/nvim; and lsd"
abbr Cvp "cd ~/.config/nvim/plugged; and lsd"
abbr mn "cd /mnt; and lsd"
abbr usi "cd /usr/share/icons; and lsd"
abbr bf "$EDITOR ~/.config/files"
abbr bd "$EDITOR ~/.config/directories"
abbr bw "$EDITOR ~/.config/bookmarks"
abbr cfa "$EDITOR ~/.config/aliasrc"
abbr cfaz "$EDITOR ~/.config/zsh/zsh_aliasrc"
abbr cfA "$EDITOR ~/.config/alacritty/alacritty.yml"
abbr cfb "$EDITOR ~/.config/bash/.bashrc"
abbr cff "$EDITOR ~/.config/fish/config.fish"
abbr cfF "$EDITOR ~/.config/foot/foot.ini"
abbr cfp "$EDITOR ~/.config/zsh/.zprofile"
abbr cfm "$EDITOR ~/.config/mutt/muttrc"
abbr cfm2 "$EDITOR ~/.config/mutt/accounts/2-secondary.muttrc"
abbr cfm3 "$EDITOR ~/.config/mutt/accounts/3-cock.muttrc"
abbr cfmb "$EDITOR ~/.config/isync/mbsyncrc"
abbr cfu "$EDITOR ~/.config/newsboat/urls"
abbr cfn "$EDITOR ~/.config/newsboat/config"
abbr bfmb "$EDITOR ~/.config/ncmpcpp/bindings"
abbr cfmc "$EDITOR ~/.config/ncmpcpp/config"
abbr cfk "$EDITOR ~/.config/sxhkd/sxhkdrc"
abbr cfkt "$EDITOR ~/.config/kitty/kitty.conf"
abbr cfi "$EDITOR ~/.config/i3/config"
abbr cfr "$EDITOR ~/.config/river/init"
abbr cfw "$EDITOR ~/.config/wayfire.ini"
abbr cfy "$EDITOR ~/.config/sway/config"
abbr cf3b "$EDITOR ~/.config/i3blocks/config"
abbr cfs "$EDITOR ~/.config/shortcutrc"
abbr cfS "$EDITOR ~/.local/bin/shortcuts"
abbr cft "$EDITOR ~/.config/tmux/tmux.conf"
abbr cfE "$EDITOR ~/.config/ENV"
abbr cfv "$EDITOR ~/.config/nvim/init.vim"
abbr cfl "$EDITOR ~/.config/nvim/init.lua"
abbr cfX "$EDITOR ~/.config/X11/Xresources"
abbr cfsf "$EDITOR ~/.config/shell_functions"
abbr cfip "$EDITOR ~/.config/inputrc"
abbr cfz "$EDITOR $ZDOTDIR/.zshrc"
abbr cfbp "$EDITOR ~/.config/bspwm/X11"
abbr cfbsp "$EDITOR $XDG_CONFIG_HOME/bspwm/bspwmrc"
abbr cfth "$EDITOR $ZDOTDIR/themes"
alias batt="cat /sys/class/power_supply/BAT?/capacity" 
alias bash="bash --rcfile $XDG_CONFIG_HOME/bash/.bashrc" 
alias cp="cpv -iv" 
alias mv="mv -iv" 
alias rm="rm -v" 
alias mbsync="mbsync -c $XDG_CONFIG_HOME/isync/mbsyncrc" 
alias yt="youtube-dl --add-metadata -i --convert-subs srt  --embed-subs --console-title --download-archive ~cac/youtube-dl/downloaded.txt --no-post-overwrites -ciw -o '%(title)s.%(ext)s'" 
alias yta="yt -x -f bestaudio/best -embed-thumbnail" 
alias YT="youtube-viewer" 
alias ffmpeg="ffmpeg -hide_banner" 
alias t3="ps aux"
alias ls="ls -hN --color=auto --group-directories-first --almost-all" 
alias lp="ls -hN --color=never -group-directories-first" 
alias ll="lsd -l" 
alias lla="lsd -la"
alias lt="lsd --tree"
alias llp="ls -la --color=never -roup-directories-first" 
alias grep="grep --color=auto" 
alias diff="diff --color=auto" 
alias cat="bat" 
alias ip="ip -c"
alias ka="killall" 
alias kX="killall Xorg" 
alias pkill="pkill --echo"
alias g="git" 
alias trem="transmission-remote" 
alias sdn="sudo shutdown -h now" 
alias rfba="sudo rfkill block all" 
alias vf="vifm" 
alias p="sudo pacman --color auto" 
alias e="$EDITOR" 
alias magit="nvim -c MagitOnly" 
alias ref="shortcuts>/dev/null;source $XDG_CONFIG_HOME/shortcutrc;source $XDG_CONFIG_HOME/shell_functions;source $XDG_CONFIG_HOME/aliasrc;source $ZDOTDIR/zsh_aliasrc" 
alias weath="less -Srf ${XDG_DATA_HOME:-HOME/share}/weatherreport" 
alias mvn="mvn -s $HOME/.local/repo/.m2/settings.xml"
alias f="ranger" 
alias irssi="irssi --home=$XDG_CONFIG_HOME/irssi -c localhost -p 8090 -w znc"
alias znc="znc --datadir ~/.config/znc"

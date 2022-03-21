# ------------------------------------------------------------------------------
# Description
# -----------
#
# p -Qii or sudoedit will be inserted before the command
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
# * Dongweiming <ciici123@gmail.com>
# * Subhaditya Nath <github.com/subnut>
# * Marc Cornellà <github.com/mcornella>
#
# ------------------------------------------------------------------------------


__qii-replace-buffer() {
    local old=$1 new=$2 space=${2:+ }
    if [[ ${#LBUFFER} -le ${#old} ]]; then
        RBUFFER="${space}${BUFFER#$old }"
        LBUFFER="${new}"
    else
        LBUFFER="${new}${space}${LBUFFER#$old }"
    fi
}

qii-command-line() {
    [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

    # Save beginning space
    local WHITESPACE=""
    if [[ ${LBUFFER:0:1} = " " ]]; then
        WHITESPACE=" "
        LBUFFER="${LBUFFER:1}"
    fi

    # Get the first part of the typed command and check if it's an alias to $EDITOR
    # If so, locally change $EDITOR to the alias so that it matches below
    if [[ -n "$EDITOR" ]]; then
        local cmd="${${(Az)BUFFER}[1]}"
        if [[ "${aliases[$cmd]} " = (\$EDITOR|$EDITOR)\ * ]]; then
            local EDITOR="$cmd"
        fi
    fi

    if [[ -n $EDITOR && $BUFFER = $EDITOR\ * ]]; then
        __qii-replace-buffer "$EDITOR" "sudoedit"
    elif [[ -n $EDITOR && $BUFFER = \$EDITOR\ * ]]; then
        __qii-replace-buffer "\$EDITOR" "sudoedit"
    elif [[ $BUFFER = sudoedit\ * ]]; then
        __qii-replace-buffer "sudoedit" "$EDITOR"
    elif [[ $BUFFER = p\ -Qii\ * ]]; then
        __qii-replace-buffer "p -Qii" ""
    else
       result=$(p -Qqo $LBUFFER 2>&1)
       if [[ $result =~ error* ]];then
           test=$(which $LBUFFER 2>&1)
           if [[ $test =~ .*not.found ]];then
               res=( $(command $LBUFFER 2>&1) )
               if [[ $res =~ .*command\ not\ found* ]];then
                   LBUFFER="$res"
                   return
               elif [[ $res =~ $LBUFFER.* ]];then
                   LBUFFER=${res[@]:8}
                   return
               fi
               LBUFFER="❌"
               return
           elif [[ $test =~ .*aliased.* ]];then
               LBUFFER=$(alias $LBUFFER)
               return
           fi
           LBUFFER=$test
           return
       else
           LBUFFER="p -Qii $result"
           return
       fi
       LBUFFER="$result"
    fi

    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"
}

zle -N qii-command-line

# Defined shortcut keys: [Esc] [Esc]
# bindkey -M emacs '\e\e' qii-command-line
# bindkey -M vicmd '\e\e' qii-command-line
bindkey -M viins '^[P' qii-command-line

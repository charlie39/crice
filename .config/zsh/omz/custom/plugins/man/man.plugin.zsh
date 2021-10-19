# ------------------------------------------------------------------------------
# Description
# -----------
#
# man or sudoedit will be inserted before the command
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

__man-replace-buffer() {
    local old=$1 new=$2 space=${2:+ }
    if [[ ${#LBUFFER} -le ${#old} ]]; then
        RBUFFER="${space}${BUFFER#$old }"
        LBUFFER="${new}"
    else
        LBUFFER="${new}${space}${LBUFFER#$old }"
    fi
}

man-command-line() {
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
        __man-replace-buffer "$EDITOR" "sudoedit"
    elif [[ -n $EDITOR && $BUFFER = \$EDITOR\ * ]]; then
        __man-replace-buffer "\$EDITOR" "sudoedit"
    elif [[ $BUFFER = sudoedit\ * ]]; then
        __man-replace-buffer "sudoedit" "$EDITOR"
    elif [[ $BUFFER = man\ * ]]; then
        __man-replace-buffer "man" ""
    else
        LBUFFER="man $LBUFFER"
    fi

    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"
}

zle -N man-command-line

# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\e\e' man-command-line
bindkey -M vicmd '\e\e' man-command-line
bindkey -M viins '^[m' man-command-line

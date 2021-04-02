
ZDOTDIR="$ZNOTDIR"

# source the users $HOME/.zsh{stuff}
[ -r "${ZDOTDIR:-$HOME}/.zshenv" ] && . "${ZDOTDIR:-$HOME}/.zshenv"
[ -r "${ZDOTDIR:-$HOME}/.zshrc" ]  && . "${ZDOTDIR:-$HOME}/.zshrc"

# clean environment for subshells
unset JARVIS

HISTFILE=~/.zsh.jarvis_history

# blinking beam cursor
printf '\x1b[\x35 q'

# window control ============================

JARVIS_IS_BIG=false
function zle_jarvisbig {
    if $JARVIS_IS_BIG; then
        printf '\x1B[8;1;100t'
        JARVIS_IS_BIG=false
    else
        printf '\x1B[8;32;100t'
        JARVIS_IS_BIG=true
    fi
}

zle -N zle_jarvisbig
bindkey '^[[23~' zle_jarvisbig # F11

function zle_jarvisgrowxpand {
    zle expand-or-complete || $JARVIS_IS_BIG || printf '\x1B[8;8;100t'
}

zle -N zle_jarvisgrowxpand
bindkey '\t' zle_jarvisgrowxpand

TRAPINT() {
    $JARVIS_IS_BIG || printf '\x1B[8;1;100t'
    return 1
}

if [ -z "$JARVIS_AUTOHIDES" ]; then
    xdotool behave $WINDOWID blur exec --sync sh -c \
        '[ "$(xdotool getwindowfocus)" -eq "$WINDOWID" ] || \
         xdotool windowunmap --sync "$WINDOWID" getactivewindow windowactivate >/dev/null  2>&1' >/dev/null  2>&1 &
    JARVIS_AUTOHIDE_PID=$!
    disown
    trap 'kill $JARVIS_AUTOHIDE_PID >/dev/null 2>&1; \
          unset JARVIS_AUTOHIDE_PID' TERM EXIT
fi
export JARVIS_AUTOHIDES=true

jarvis_resize() {
    JARVIS_IS_BIG=false
    printf "\x1B[8;${1:-1};${2:-100}t"
    clear
}

JARVIS_FG_DAY='#272727'
JARVIS_BG_DAY='#fafafa'
JARVIS_FG_NIGHT='#fafafa'
JARVIS_BG_NIGHT='#272727'
JARVIS_BACKDROP_DAY="/usr/share/jarvis/day.png;style=centered"
JARVIS_BACKDROP_NIGHT="/usr/share/jarvis/night.png;style=centered"


jarvis_daylight() {
    local IS_DAY=true

    case "$1" in
    day|light|bright)
        IS_DAY=true
    ;;
    night|dark)
        IS_DAY=false
    ;;
    *)
    if command -v redshift >/dev/null 2>&1; then
        IS_DAY=$(LC_ALL=C redshift -op 2>/dev/null | sed '/Color temperature/!d; s/Color temperature: \([0-9]*\)K/\1/')
        if  (( $IS_DAY > 5500 )); then
            IS_DAY=true
        else
            IS_DAY=false
        fi
    fi
    ;;
    esac

    if $IS_DAY; then
        printf "\033]10;$JARVIS_FG_DAY\007"
        printf "\033]11;$JARVIS_BG_DAY\007"
        printf "\033]39;$JARVIS_FG_DAY\007"
        printf "\033]49;$JARVIS_BG_DAY\007"
        printf "\033]708;$JARVIS_BG_DAY\007"
        printf "\033]20;$JARVIS_BACKDROP_DAY\007"
    else
        printf "\033]10;$JARVIS_FG_NIGHT\007"
        printf "\033]11;$JARVIS_BG_NIGHT\007"
        printf "\033]39;$JARVIS_FG_NIGHT\007"
        printf "\033]49;$JARVIS_BG_NIGHT\007"
        printf "\033]708;$JARVIS_BG_NIGHT\007"
        printf "\033]20;$JARVIS_BACKDROP_NIGHT\007"
    fi
}

if command -v redshift >/dev/null 2>&1; then
    TMOUT=3600
fi

TRAPALRM() {
    jarvis_daylight
}


if [ -d $HOME/.local/share/jarvis/funcs.d ] ; then
    for f in $HOME/.local/share/jarvis/funcs.d/* ; do
        [ -r "$f" ] && . "$f"
    done
    unset f
fi

if [ -d /usr/share/jarvis/funcs.d ] ; then
    for f in /usr/share/jarvis/funcs.d/* ; do
        [ -r "$f" ] && . "$f"
    done
    unset f
fi

[ -r $HOME/.config/jarvis ] && . $HOME/.config/jarvis

jarvis_daylight

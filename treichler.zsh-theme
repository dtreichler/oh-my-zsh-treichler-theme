function treichler_precmd {
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

    if [ $VIRTUAL_ENV ]; then
        PR_ENV="(`basename $VIRTUAL_ENV`)"
    else
        PR_ENV=""
    fi

    ZSH_THEME_GIT_PROMPT_PREFIX=" "
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    ZSH_THEME_GIT_PROMPT_ADDED="+"
    ZSH_THEME_GIT_PROMPT_MODIFIED="*"
    ZSH_THEME_GIT_PROMPT_DELETED="x"
    ZSH_THEME_GIT_PROMPT_RENAMED=" mv"
    ZSH_THEME_GIT_PROMPT_UNMERGED="% m"
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" ut"

    PR_GIT=`git_prompt_info``git_prompt_status`

    PR_PWDLEN=""

    local promptsize=${#${(%):---$PR_GIT$PR_ENV(%n@%m)}}
    local pwdsize=${#${(%):-%~}}
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
        ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_FILL}.)}"
    fi

    ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}*"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}x"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} mv"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} m"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%} ut"

}

setprompt () {

    setopt prompt_subst

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
        colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
        eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
        eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
        (( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}

    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"

    PR_HBAR=${altchar[q]:--}
    PR_FILL=" "
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}

    export PR_USERCOLOR=$PR_GREEN
    export PR_HOSTCOLOR=$PR_MAGENTA
    export PR_PATHCOLOR=$PR_CYAN
    export PR_ENVCOLOR=$PR_YELLOW

    PR_GIT=`git_prompt_info``git_prompt_status`

    PROMPT='$PR_WHITE$PR_SHIFT_IN$PR_ULCORNER$PR_HBAR$PR_SHIFT_OUT\
$PR_PATHCOLOR %$PR_PWDLEN<...<%~%<<`git_prompt_info``git_prompt_status`\
${(e)PR_FILLBAR}$PR_ENVCOLOR$PR_ENV\
$PR_GREY($PR_USERCOLOR%(!.%SROOT%s.%n)$PR_GREY@$PR_HOSTCOLOR%m\
$PR_GREY)\

$PR_WHITE$PR_SHIFT_IN$PR_LLCORNER$PR_HBAR$PR_SHIFT_OUT>$PR_NO_COLOUR '

    return_code="%(?..$PR_RED%? %{$reset_color%})"

    RPROMPT=' $return_code'

    PS2='%_'

}

setprompt

autoload -U add-zsh-hook
add-zsh-hook precmd treichler_precmd

export VIRTUAL_ENV_DISABLE_PROMPT="true"

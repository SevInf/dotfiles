source ~/.dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen bundle z
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle nvm
antigen bundle unixorn/autoupdate-antigen.zshplugin

antigen apply

export EDITOR='vim'
bindkey -v
export KEYTIMEOUT=1

autoload -U colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git 
zstyle ':vcs_info:git*' formats " %b"

# Prompt
if [[ -n $SSH_CLIENT ]]; then
    local host="%{$fg[blue]%}%n@%M%{$reset_color%}:"
fi

local dir="%{$fg_bold[white]%}%~%{$reset_color%}"
local last_status="%(?. .%{$fg[red]%}✘)%{$reset_color%}"
local top_prompt="${host}${dir}"

function cursor-shape {
    local seq="\033]50;CursorShape=$1\007"
    if [[ -n $TMUX ]] then
        seq="\033Ptmux;\033$seq\033\\"
    fi
    echo -n $seq
}

function zle-line-init zle-keymap-select {
    local vimode=''
    local bar_color
    if [[ $KEYMAP == 'vicmd' ]]; then
        vimode="%{$fg[black]%}NORMAL %{$reset_color%}%"
        bar_color='blue'
        cursor-shape 0
    else
        vimode="%{$fg[black]%}INSERT %{$reset_color%}%"
        bar_color='green'
        cursor-shape 1
    fi

    local bottom_prompt="%{$bg[$bar_color]%}${last_status}%{$bg[$bar_color]%} ${vimode} %{$fg[$bar_color]%}%{$reset_color%}"

    PROMPT=$'${top_prompt}\n${bottom_prompt} '
    zle reset-prompt
    zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select

precmd() {
    vcs_info
    RPROMPT='${vcs_info_msg_0_}'
}

# Bind history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Aliases
alias mvim='mvim --remote-tab-silent'
alias serve='python -m SimpleHTTPServer'

ulimit -n 8000

if [[ -r ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

export FZF_DEFAULT_COMMAND='ag -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

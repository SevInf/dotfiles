source ~/.dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen bundle github
antigen bundle brew
antigen bundle z
antigen bundle vi-mode
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle nvm
antigen bundle unixorn/autoupdate-antigen.zshplugin

antigen apply

export EDITOR='vim'

autoload -U colors

# Prompt

if [[ -n $SSH_CLIENT ]]; then
    local host="%{$fg[blue]%}%n@%M%{$reset_color%}:"
fi

local dir="%{$fg[white]%}%~%{$reset_color%}"
local last_status="%(?. .%{$fg[red]%}✘)%{$reset_color%}"
local top_prompt="${host}${dir}"

function zle-line-init zle-keymap-select {
    local vimode=''
    local bar_color
    if [[ $KEYMAP == 'vicmd' ]]; then
        vimode="%{$fg_bold[white]%}NORMAL %{$reset_color%}%"
        bar_color='blue'
        echo -n '\x1b]50;CursorShape=0\x7'
    else
        vimode="%{$fg_bold[white]%}INSERT %{$reset_color%}%"
        bar_color='green'
        echo -n '\x1b]50;CursorShape=1\x7'
    fi

    local bottom_prompt="%{$bg[$bar_color]%}${last_status}%{$bg[$bar_color]%} ${vimode} %{$fg[$bar_color]%}%{$reset_color%}"

    PROMPT=$'${top_prompt}\n${bottom_prompt} '
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Bind history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Aliases
alias mvim='mvim --remote-tab-silent'
alias bem='PATH="$(npm bin):$PATH" bem'
alias serve='python -m SimpleHTTPServer'
alias optimize='git diff --name-only --staged --diff-filter AM -z -- "*.png" | xargs -0 open -a ImageOptim'
alias gnvim='open -a Neovim'

ulimit -n 8000
 
if [[ -r ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

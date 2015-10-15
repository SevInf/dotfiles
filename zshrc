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
#antigen bundle powerline/powerline --loc=powerline/bindings/zsh/powerline.zsh

antigen apply

export EDITOR='vim'

if [[ -r ~/.zsrc.local ]]; then
    source ~/.zshrc.local
fi


#if [[ $HOST -ne $DEFAULT_HOSTNAME || $USERNAME -ne $DEFAULT_USERNAME ]]; then
local user_host="%{$fg[blue]%}%n@%{$fg[green]%}%M"
#fi

autoload -U colors
PROMPT="${user_host}%{$fg_bold[blue]%}[%~]%{$reset_color%}$ "

#PROMPT='%B%{%F{33}%}%n:%c$%b%F{244}$(vi_mode_prompt_info) '
#RPROMPT='%B${vcs_info_msg_0_}%{$reset_color%}'
#MODE_INDICATOR='[n]'


# Bind history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

zle -N zle-line-init

# Aliases
alias mvim='mvim --remote-tab-silent'
alias bem='PATH="$(npm bin):$PATH" bem'
alias serve='python -m SimpleHTTPServer'
alias optimize='git diff --name-only --staged --diff-filter AM -z -- "*.png" | xargs -0 open -a ImageOptim'
alias gnvim='open -a Neovim'

ulimit -n 8000
 

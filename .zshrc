if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

myExa() { exa -alh --icons $@ }

export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/bin:$PATH
source $ZSH/oh-my-zsh.sh

alias cat="bat"
alias vi="nvim"
alias ls="myExa"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

. $HOME/.asdf/asdf.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# script for zplug
source ~/.zplug/init.zsh

zplug "junegunn/fzf", use:"shell/*.zsh", defer:2
zplug "plugins/git", from:oh-my-zsh
zplug "zdharma/fast-syntax-highlighting"
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=23"

export PATH="/Users/nhn/.rd/bin:$PATH"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function finish {
  cd ~/.config
  git acp "dot files"  
}

trap finish EXIT

nohup git -C ~/.config pull 2>&1 &

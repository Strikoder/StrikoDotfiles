
# Path and history configuration
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"
# CUDA configuration
export PATH=/usr/local/cuda-12.3/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64:$LD_LIBRARY_PATH
# Additional PATH
export PATH="$PATH:/home/user/bin"

# --------------------------------------------------------------
# Oh-My-Zsh configuration
ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=80'
source "$ZDOTDIR/.oh-my-zsh/oh-my-zsh.sh"
# Starship prompt
eval "$(starship init zsh)"

# Conda configuration
__conda_setup="$('/home/strikoder/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/strikoder/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/strikoder/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/strikoder/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
source activate myenv

# history
HISTSIZE=3000
SAVEHIST=3000

# --------------------------------------------------------------
# Custom aliases
alias con_electro='ssh root@178.16.143.6'

alias hackurmum='cd ~/../../media/Github/bad-apple; python3 launcher.py'
alias github='cd ~/../../media/Github/'
alias aw='nvim ~/.config/awesome/rc.lua'
alias nv='nvim ~/.config/nvim/init.lua'
alias zs='nvim ~/.config/zsh/.zshrc'
alias tm='nvim ~/.config/tmux/tmux.conf'
alias v='nvim'

alias tkill='tmux kill-session -t'


# --------------------------------------------------------------
# TMUX startup
if [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi



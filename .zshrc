# zsh configs -----------------------------------

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::ubuntu
zinit snippet OMZP::archlinux
zinit snippet OMZP::postgres
zinit snippet OMZP::docker
zinit snippet OMZP::command-not-found



# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# keybindings
# bindkey -e
bindkey ';5C' forward-word
bindkey ';5D' backward-word

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# NVM and PNPM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="~/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
. "$HOME/.cargo/env"

# aliases
alias ls='eza --icons=always -a --group-directories-first'
alias c='clear'
alias nv='nvim'
alias zed='zeditor'
alias lzd='lazydocker'

# Ibus KDE
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus

# Ibus avro fix
# export OOO_FORCE_DESKTOP="gnome" libreoffice


# Shell integrations
# eval "$(fzf init zsh)"
source <(fzf --zsh)

export ZED_WINDOW_DECORATIONS=server # zed server decotration for kde
export PATH=$PATH:~/.local/bin

# Custom export paths to just to different locations
export Dev=/run/media/dev-ahad-ali/Work-Station/_Development/
export Coding=/run/media/dev-ahad-ali/Work-Station/_Development/Coding/
export Work=/run/media/dev-ahad-ali/Work-Station/_Development/Work/
export Space=/run/media/dev-ahad-ali/Work-Station/_Development/Space/

eval "$(oh-my-posh init zsh --config ~/user-files/custom_tokyonight_storm.omp.json)"

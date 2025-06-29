# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    archlinux
    sudo
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

alias c='clear'
alias nf='neofetch'
# alias pf='fastfetch --config hypr'
# alias ff='fastfetch --config hypr'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='nvim'
alias vim='nvim'
alias mkdir='mkdir -p'
alias nano='nvim'
alias fastfetch='fastfetch --config hypr'
alias tty-clock='tty-clock -c'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gu='git pull'
alias gp='git push'
alias gl='git log'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'
alias activate='source venv/bin/activate'

# fastfetch

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt share_history          # Share history between all sessions
setopt inc_append_history     # Append to history immediately
setopt extended_history       # Save timestamp and duration
setopt hist_expire_dups_first # Delete duplicates first
setopt hist_ignore_dups       # Don't store duplicates
setopt hist_find_no_dups      # Don't display duplicates during searches

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

bindkey -s ^f "tmux-sessionizer\n"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

. "$HOME/.local/bin/env"
export PATH="/home/harshal/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/harshal/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin:/home/linuxbrew/.linuxbrew/bin"
export AIPIPE_TOKEN="eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IjIzZjIwMDE2MjdAZHMuc3R1ZHkuaWl0bS5hYy5pbiJ9.s9Dg_CfWzxrZIH3As1HsgSkrU52A-nxrGcCY55o6sm8"
export OPENAI_API_KEY="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"
export PATH="$HOME/.cargo/bin:$PATH"

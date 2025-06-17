# ─────────────────────────────────────────────────────
# Start-Up
# ─────────────────────────────────────────────────────

# Only activate mise if not already shimmed (speed boost)
[[ ":$PATH:" != *"/mise/shims"* ]] && eval "$(mise activate zsh)"

# Show system info quickly
fastfetch --config arch

# Powerlevel10k instant prompt (keep at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ─────────────────────────────────────────────────────
#  Environment Variables
# ─────────────────────────────────────────────────────

export PATH="$HOME/bin:$HOME/go/bin:$HOME/.local/share/pnpm:$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH"
export PNPM_HOME="$HOME/.local/share/pnpm"
export OMP_DISABLE_TITLE=true
# export PAGER='less -S'
export FZF_DEFAULT_OPTS="\
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a --color=border:#313244,label:#cdd6f4"

# ─────────────────────────────────────────────────────
#  Plugin Manager (Zinit)
# ─────────────────────────────────────────────────────

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing Zinit…%f"
  mkdir -p "$HOME/.local/share/zinit" && chmod g-rwX "$HOME/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" \
    && print -P "%F{34}Installation successful.%f" \
    || print -P "%F{160}Clone failed.%f"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ─────────────────────────────────────────────────────
#  Plugins
# ─────────────────────────────────────────────────────

# Themes
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Syntax, completions, suggestions
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode
# zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# Snippets (Oh My Zsh)
snippets=(sudo archlinux command-not-found npm colored-man-pages)
for snip in "${snippets[@]}"; do
  zinit ice wait lucid
  zinit snippet "OMZP::$snip"
done

# ─────────────────────────────────────────────────────
#  Completion System
# ─────────────────────────────────────────────────────

autoload -Uz compinit
compinit -C

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ─────────────────────────────────────────────────────
#  History
# ─────────────────────────────────────────────────────

HISTSIZE=8000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
        hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ─────────────────────────────────────────────────────
#  Integrations
# ─────────────────────────────────────────────────────

# fzf shell integration
source <(fzf --zsh)

# auto-cpufreq CLI completion
eval "$(_AUTO_CPUFREQ_COMPLETE=zsh_source auto-cpufreq)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# tmuxifier
eval "$(tmuxifier init -)"

# ─────────────────────────────────────────────────────
#  Aliases & Functions
# ─────────────────────────────────────────────────────

# Neovim variants

function nvims() {
  local items=("default" "kickstart" "LazyVim")
  local config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && echo "Nothing selected" && return
  [[ $config == "default" ]] && config="neovim"
  NVIM_APPNAME=$config /bin/nvim "$@"
}

# function templater() {
#   local template_dir="$HOME/Templates/dirs"
#   local template_file="$HOME/Templates/files"
#
#   echo -e "File\nDir" | fzf --prompt="Templater  "
#
# }

# Tree listing with eza
function lt() {
  local level=2
  [[ $1 =~ ^-[0-9]+$ ]] && level=${1#-} && shift
  eza  --icons=auto --group-directories-first --show-symlinks --tree --level="$level" "$@"
}

# Highlight colors for vi mode
ZVM_VI_HIGHLIGHT_FOREGROUND=#cdd6f4   # Text color from Catppuccin Mocha
ZVM_VI_HIGHLIGHT_BACKGROUND=#585b70   # Background color from Catppuccin Mocha
ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold      # Extra style (e.g., bold)

# Cursor styles with blue accent
zvm_config() {
  # Retrieve default cursor styles
  local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
  local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)

  # Custom cursor colors
  ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;#89b4fa\a'  # Blue accent for insert mode
  ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#a6e3a1\a'  # Green for normal mode
}

# Clipboard yank with zsh-vi-mode
my_zvm_vi_yank() {
  zvm_vi_yank
  echo -en "${CUTBUFFER}" | wl-copy
}

my_zvm_vi_delete() {
  zvm_vi_delete
  echo -en "${CUTBUFFER}" | wl-copy
}

my_zvm_vi_change() {
  zvm_vi_change
  echo -en "${CUTBUFFER}" | wl-copy
}

my_zvm_vi_change_eol() {
  zvm_vi_change_eol
  echo -en "${CUTBUFFER}" | wl-copy
}

my_zvm_vi_put_after() {
  CUTBUFFER=$(wl-paste)
  zvm_vi_put_after
  zvm_highlight clear # zvm_vi_put_after introduces weird highlighting for me
}

my_zvm_vi_put_before() {
  CUTBUFFER=$(wl-paste)
  zvm_vi_put_before
  zvm_highlight clear # zvm_vi_put_before introduces weird highlighting for me
}

zvm_after_lazy_keybindings() {
  zvm_define_widget my_zvm_vi_yank
  zvm_define_widget my_zvm_vi_delete
  zvm_define_widget my_zvm_vi_change
  zvm_define_widget my_zvm_vi_change_eol
  zvm_define_widget my_zvm_vi_put_after
  zvm_define_widget my_zvm_vi_put_before

  zvm_bindkey visual 'y' my_zvm_vi_yank
  zvm_bindkey visual 'd' my_zvm_vi_delete
  zvm_bindkey visual 'x' my_zvm_vi_delete
  zvm_bindkey vicmd  'C' my_zvm_vi_change_eol
  zvm_bindkey visual 'c' my_zvm_vi_change
  zvm_bindkey vicmd  'p' my_zvm_vi_put_after
  zvm_bindkey vicmd  'P' my_zvm_vi_put_before
}

# Keybindings
bindkey -s '^G' "tmux attach-session -t main\n"
bindkey -s '^N' "nvim\n"
bindkey -s '^E' "yazi\n"

# General aliases
# alias ls='ls --color=always'
alias vim='nvim'
alias neo='neo --defaultbg --color=gray'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='eza --icons=auto'
alias ll='eza -l --show-symlinks --icons=auto'
alias lll='eza -la --icons=auto'
alias c='clear'
alias lzn='lazynpm'
alias lzg='lazygit'
alias lzd='lazydocker'
alias psql='PSQLRC=~/.zenpsqlrc psql'
alias fman='compgen -c | fzf | xargs man'
alias pacQ="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias pacQe="pacman -Qqe | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias rmnvim='rm -rf ~/.config/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.cache/nvim'
# alias dots='/usr/bin/git --git-dir=$HOME/Repositories/MyRepos/dotfiles --work-tree=$HOME'
# alias lazydots='lazygit --git-dir=$HOME/Repositories/MyRepos/dotfiles --work-tree=$HOME'
# alias challenges='/usr/bin/git --git-dir=$HOME/Repositories/MyRepos/Challenges --work-tree=$HOME/Projects/01-personal/challenges'

# ─────────────────────────────────────────────────────
#  Autostart Main Tmux Session (if not already)
# ─────────────────────────────────────────────────────

if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
  tmux has-session -t main 2>/dev/null || tmux new-session -d -s main
fi

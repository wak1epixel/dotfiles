# ── History ──────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # history shared across open terminals
setopt HIST_IGNORE_ALL_DUPS   # don't store duplicate commands
setopt HIST_REDUCE_BLANKS

# ── Directory navigation ─────────────────────────────
setopt AUTO_CD                # type a folder name to cd into it

# ── Completion ───────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' menu select                          # arrow-key menu

# ── Fish-like features ───────────────────────────────
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ── Aliases ──────────────────────────────────────────
alias ll='ls -lah'
alias ..='cd ..'

# ── Prompt ───────────────────────────────────────────
eval "$(starship init zsh)"

# ── Syntax highlighting (MUST be last) ───────────────
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

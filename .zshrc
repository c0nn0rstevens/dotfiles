
echo "Starting .zshrc"

# history setup
echo "Setting up history"
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
echo "Configuring keybindings"
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

## Add Homebrew to PATH.
export PATH=/opt/homebrew/bin:$PATH
#
# zsh extras
echo "Sourcing zsh plugins"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Eza (better ls) -----
echo "Setting up aliases"
alias ls="eza --icons=always"
alias cd="z"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

eval "$(starship init zsh)"
source /opt/homebrew/opt/zinit/zinit.zsh

# ---- Jenv ----
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# ---- GPG ----
export GPG_TTY=$(tty)

# The next line updates PATH for the Google Cloud SDK.
echo "Checking Google Cloud SDK"
if [ -f '/Users/connor.stevens/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/connor.stevens/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/connor.stevens/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/connor.stevens/google-cloud-sdk/completion.zsh.inc'; fi

echo ".zshrc completed"


export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git sudo z)

source $ZSH/oh-my-zsh.sh

source ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

export TERMINAL=wezterm

alias python='python3'

alias bat='batcat'

alias capsy='setxkbmap -layout br -variant abnt2 -option "ctrl:swapcaps"'
alias capsn='setxkbmap -layout br -variant abnt2 -option'

alias oi='cd ~/obsidian; git add .; git commit -m "oi";git rebase --continue; git push; cd ~/backup; git pull; cp -r nvim ~/.config;'
alias tchau='cd ~/obsidian;git add .; git commit -m "tchau"; git push; cd ~/.config; cp -r nvim ~/backup; cd ~/backup; git add .; git commit -m "tchau"; git push; shutdown -h now;'

alias "c=xclip"
alias "v=xclip -o"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -s "/home/roger/.bun/_bun" ] && source "/home/roger/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=/home/roger/.bun/bin:/home/roger/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/roger/.dotnet/tools:/path/to/go/bin

# go
export PATH="$PATH:$(go env GOPATH)/bin"


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Auto-start/attach tmux (pick first session with NO clients; else create next number)
[[ -o interactive ]] || return
[[ -n "$TMUX" ]] && return
command -v tmux >/dev/null 2>&1 || return

# Find first unattached session; if none, create 1/2/3...
s="$(tmux list-sessions -F '#S #{session_attached}' 2>/dev/null | awk '$2==0{print $1; exit}')"

if [[ -n "$s" ]]; then
  tmux attach -t "$s" 2>/dev/null || true
else
  n=1
  while tmux has-session -t "$n" 2>/dev/null; do ((n++)); done
  tmux new -s "$n" 2>/dev/null || true
fi


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

alias camaro='cd /home/rodrigo/shared/zoe-games-src/programs/camaro'
alias zoe='cd /home/rodrigo/shared/zoe-games-src'

alias bat='batcat'

alias capsy='setxkbmap -layout br -variant abnt2 -option "ctrl:swapcaps"'
alias capsn='setxkbmap -layout br -variant abnt2 -option'
alias usy='setxkbmap -layout us -option "ctrl:swapcaps"'
alias usn='setxkbmap -layout us'

alias vm='sudo rmmod kvm_intel kvm'

alias oifpg='cd ~/obsidian; git pull; git add .; git commit -m "oi";git rebase --continue; git push'
alias tchaufpg='cd ~/obsidian;git add .; git commit -m "tchau"; git push; shutdown -h now'

alias oi='cd ~/obsidian; git pull; git add .; git commit -m "oi";git rebase --continue; git push'
alias tchau='cd ~/obsidian; git add .; git commit -m "tchau";git rebase --continue; git push; shutdown -h now'

alias "c=xclip"
alias "v=xclip -o"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

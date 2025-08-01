# Created 1 Augst 2025, 20:32 UTC+8 (C) Copyright 2025 <adharudin14@gmail.com> under MIT license
# This hook for pet
alias molly-come='pet exec'
alias molly-speak='pet search | tee /dev/tty | xargs -r echo | termux-tts-speak'
alias molly-jump='eval "$(pet search --query 📁)"'
alias molly-stay='pet list'
alias molly-paw='pet edit'
alias molly-heel='pet sync'
alias molly-settle='pet new'
alias molly-talk="pet list | grep 'Description:' | sed 's/^Description: *[^|]*|//' | grep -v '^$' | fzf | tee /dev/tty | xargs -r echo | termux-tts-speak"
alias molly-bloop='__molly_back'
function pet_select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}
bind -x '"\C-x\C-r": pet_select'
function __molly_back() {
  PREV=$(echo `history | tail -n2 | head -n1` | sed 's/[0-9]* //')
  sh -c "pet new -m `printf %q "$PREV"`"
}
molly() {
  eval "$( \
    compgen -a | grep 'molly' | xargs -n 1 basename | fzf --no-input --header '🐾 Commands for Molly the Dog' --layout=reverse --color=fg:white,fg+:green,query:blue --with-nth=2 --delimiter='-' --nth=1 --info=inline -q "${1}" -1 )"
}
eval "$(pet completion bash)"

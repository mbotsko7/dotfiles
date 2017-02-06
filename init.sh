#!/usr/bin/fish

alias gpo "git push origin"
funcsave gpo
alias gpoh "git push origin HEAD"
funcsave gpoh
alias gp "git pull"
funcsave gp
alias gf "git fetch"
funcsave gf
alias gc "git commit"
funcsave gc
alias gca "git add .; and git commit"
funcsave gca
alias dongrok "cd ~/Projects; and ./ngrok start jnode jangular jionic"
funcsave dongrok
alias cpu "watch grep \"cpu MHz\" /proc/cpuinfo"
funcsave cpu
alias gs "git status"
funcsave gs
alias ga "git add"
funcsave ga
alias gaa "git add ."
funcsave gaa
alias gcb "git checkout -b"
funcsave gcb
alias pbcopy='xsel --clipboard --input'
funcsave pbcopy
alias pbpaste='xsel --clipboard --output'
funcsave pbpaste
alias kernel='uname -r'
funcsave kernel
alias cpu='watch -n 0.4 grep \"cpu MHz\" /proc/cpuinfo'
funcsave cpu
alias governor='cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
funcsave governor

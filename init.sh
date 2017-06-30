# Git specific
alias gpo "git push origin"
funcsave gpo
alias gpoh "git push origin HEAD"
funcsave gpoh
alias gp "git pull origin HEAD"
funcsave gp
alias gf "git fetch --all"
funcsave gf
function setupstream
    git branch --set-upstream-to=origin/(git rev-parse --abbrev-ref HEAD) (git rev-parse --abbrev-ref HEAD)
end
funcsave setupstream
alias gc "git commit"
funcsave gc
alias gca "git add .; and git commit"
funcsave gca
alias gs "git status"
funcsave gs
alias ga "git add"
funcsave ga
alias gaa "git add ."
funcsave gaa
alias gcb "git checkout"
funcsave gcb

# Copy paste tools
alias pbcopy='xsel --clipboard --input'
funcsave pbcopy
alias pbpaste='xsel --clipboard --output'
funcsave pbpaste

# Linux specific monitoring
alias kernel='uname -r'
funcsave kernel
alias cpu='watch -n 0.4 grep \"cpu MHz\" /proc/cpuinfo'
funcsave cpu
alias governor='cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
funcsave governor

# Linux specific debugging
alias governor-set="sudo cpufreq-set -c 0 -g"
funcsave governor-set
alias wifi="sudo service network-manager restart"
funcsave wifi

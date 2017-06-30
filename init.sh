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

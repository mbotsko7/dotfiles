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
alias gl "git log"
funcsave gl
alias gd "git diff"
funcsave gd

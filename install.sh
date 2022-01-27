source ./zsh/zshrc.zsh
git config --local merge.conflictStyle zdiff3
git config --local alias.s status
git config --local alias.co checkout
git config --local alias.lol "log --graph --oneline --decorate"
git config --local alias.ll "log --pretty=format:\"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn] %Cgreen%cr\" --decorate --numstat"

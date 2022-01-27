#!/bin/env zsh

source ./zsh/zshrc.zsh
git config --global merge.conflictStyle zdiff3
git config --global alias.s status
git config --global alias.co checkout
git config --global alias.lol "log --graph --oneline --decorate"
git config --global alias.ll "log --pretty=format:\"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn] %Cgreen%cr\" --decorate --numstat"

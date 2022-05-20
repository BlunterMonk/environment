# /bin/bash

# copy VS Code
cp -R ~/Library/Application\ Support/Code/User/keybindings.json ./vscode/keybindings.json
cp -R ~/Library/Application\ Support/Code/User/settings.json ./vscode/settings.json
cp -R ~/Library/Application\ Support/Code/User/syncLocalSettings.json ./vscode/ssyncLocalSettings.jsonn
# copy vim
cp -R ~/.vim/colors/ ./.vim/colors
cp ~/.vimrc ./.vimrc
# copy tmux
cp ~/.tmux.conf ./.tmux.conf


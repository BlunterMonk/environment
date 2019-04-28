# environment
My environment configurations

Clone Vundle:

- git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Make sure .vimrc is configured for the right environment

- Ubuntu:
```
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype plugin indent on
```

Copy .vimrc

- cp .vimrc ~/.vimrc

Copy Color Schemes
- cp colors ~/.vim/colors



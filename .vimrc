" -----------------------------------------------------------------------------------------
"                               VUNDLE PLUGIN MANAGER
"
" reference: https://github.com/gmarik/Vundle.vim
" https://www.digitalocean.com/community/tutorials/how-to-use-vundle-to-manage-vim-plugins-on-a-linux-vps
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" -----------------------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

"colorscheme codedark

" set the runtime path to include Vundle
set rtp+=~/.vim/bundle/vundle/
" Start Vundle
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
call vundle#begin()

" This is the Vundle package, which can be found on GitHub.
Plugin 'gmarik/vundle.git' " let Vundle manage Vundle, required

Plugin 'tomasiser/vim-code-dark'
Bundle 'vexxor/phpdoc.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree.git'
Plugin 'easymotion/vim-easymotion.git'
Plugin 'mustache/vim-mode.git' "syntax coloring for templates
"Plugin 'elzr/vim-json' "Json syntax coloring and folding
Plugin 'tpope/vim-fugitive.git' "Git wrapper
"Plugin 'bling/vim-airline.git'
"Plugin 'edkolev/promptline.vim.git'
"Plugin 'powerline/powerline.git'
Plugin 'wesQ3/vim-windowswap'
Plugin 'mattn/emmet-vim'

" To get plugins from vim-scripts.org, you can reference the plugin by name
Plugin 'nginx.vim' "syntax highliging for nginx.conf files
Plugin 'Buffergator'
Plugin 'ctrlp.vim'
"Plugin 'JavaScript-syntax' "wierd colors & heavy folding
"Plugin 'pangloss/vim-javascript' "nice plain colors & helps /w folding (! began giving me errors May 2016)
"Plugin 'Enhanced-Javascript-syntax' "nice colorful & folding
Plugin 'fatih/vim-go' "Golang
Plugin 'majutsushi/tagbar'

" Plugin for xDebug
Plugin 'joonty/vdebug.git'
" Easy commenting
Plugin 'scrooloose/nerdcommenter'
Plugin 'mileszs/ack.vim'
" Lets you hit tab for autocomplete instead of <C-x><C-o>
Plugin 'ervandew/supertab'
" Autocomplete for java
Plugin 'artur-shaik/vim-javacomplete2'
" Syntax Highlighting
Plugin 'vim-syntastic/syntastic'
" Snippets
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" -----------------------------------------------------------------------------------------

" -----------------------------------------------------------------------------------------
"								 DEFAULTS
" Leader
let mapleader = ";"

" -----------------------------------------------------------------------------------------
"								 ULTISNIPS
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Set default snippets dirs
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" -----------------------------------------------------------------------------------------
"								 JAVA COMPLETE
" Plugin 'artur-shaik/vim-javacomplete2'
" NOTE: you might have to run JCserverStart. Requires vim 8 & java 8

autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Add all missing imports
nmap <Leader>i <Plug>(JavaComplete-Imports-AddMissing)
imap <Leader>i <Plug>(JavaComplete-Imports-AddMissing)
" Remove all missing imports
nmap <Leader>ir <Plug>(JavaComplete-Imports-RemoveUnused)
imap <Leader>ir <Plug>(JavaComplete-Imports-RemoveUnused)


" -----------------------------------------------------------------------------------------
"								 AG (for Ack)
" AG is a dependency of mileszs/ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" -----------------------------------------------------------------------------------------
"								 SUPERTAB
" Tab will trigger the file completion autocomplete method by default
let g:SuperTabDefaultCompletionType = "context"


" -----------------------------------------------------------------------------------------
"								 GOLANG

au BufRead,BufNewFile *.go set filetype=go
"au BufWritePost *.go silent !unset DYLD_INSERT_LIBRARIES && goimports -w %
"au BufWritePost *.go silent !unset DYLD_INSERT_LIBRARIES && gofmt -w %
"au BufWritePost *.go :e
au BufWritePost *.go syntax on
"au BufWritePost *.go SyntasticCheck govet
"autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_go_checkers = ['govet']

" -----------------------------------------------------------------------------------------
"								 vim-go
" Open definition
"https://github.com/fatih/vim-go#example-mappings
au FileType go nmap <leader>ds <Plug>(go-def-split)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)
au FileType go nmap <leader>dt <Plug>(go-def-tab)

let g:go_fmt_autosave = 1 "run GoFmt on save
"let g:go_fmt_command = "goimports" "run GoImports on save
"let g:go_auto_type_info = 1 "Run :GoInfo automatically based on updatetime

" Additional syntax-highlighting (can cause go file to run slow)
let g:go_highlight_functions = 0
let g:go_highlight_methods = 1
let g:go_highlight_structs = 0
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"Go build on \b "causing problems with .php files
"au Filetype go set makeprg=go\ build
"nmap <Leader>b :make<CR>:copen<CR>
"nmap ;t :GoTest<CR>

"function! s:GoTest()
    "cexpr system("go test --silent")
    "copen
"endfunction
"command! GoTest :call s:GoTest()

" -----------------------------------------------------------------------------------------
"								 TAGBAR
" USAGE: tb
"Plugin 'majutsushi/tagbar'

nnoremap ;tb :Tagbar<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" TAGBAR (var & func names on right)
nnoremap tb :TagbarToggle<CR>
nnoremap ;gi :GoImports<CR>
nnoremap ;gf :GoInfo<CR>
nnoremap ;gt :GoTest<CR>

" -----------------------------------------------------------------------------------------
"								 VDEBUG & XDEBUG
" SHORTCUTS
let g:vdebug_keymap = {
\    "run" : "<F5>",
\    "run_to_cursor" : "<C-i>",
\    "step_over" : "<C-k>",
\    "step_into" : "<C-l>",
\    "step_out" : "<C-j>",
\    "close" : "<F6>",
\    "detach" : "<F7>",
\    "set_breakpoint" : ";b",
\    "get_context" : "<F11>",
\    "eval_under_cursor" : "<F12>",
\    "eval_visual" : "<Leader>e",
\}

" OPTIONS
let g:vdebug_options= {
\    "port" : 9000,
\    "server" : '',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 1,
\    "ide_key" : '',
\    "path_maps" : { "/var/www/blim/current": '/Users/erick/clients/televisa/repos/payments-api' },
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'expanded',
\    "marker_default" : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾',
\    "continuous_mode" : 1
\}

" -----------------------------------------------------------------------------------------
"								 AUTO COMPLETE

"<C-x><C-o> = file completion
"<C-x><C-k> = dictionary completion
"<C-x><C-u> = user completion
"<C-x><C-p> = local completion (bottom to top)
"<C-x><C-n> = multi completion (top to bottom)

" Autocomplete depending on FileType ex: from insert mode <hold-ctrl>x <hold-ctrl>o
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
set omnifunc=syntaxcomplete#Complete

" Set custom dictionary ex: from insert mode <hold-ctrl>x <hold-ctrl>k
set dictionary+=./.vim/dictionaries/words

" Autocomplete <C-n> should pull from multiple sources
set complete+=k "Pull from Dictionaires "this way we dont have to hit <hold-ctrl>x <hold-ctrl>k every time
set complete+=t "Pull from Tag Files

" -----------------------------------------------------------------------------------------
"								 EASYMOTION
"Plugin 'easymotion/vim-easymotion.git'

" EasyMotion
let g:EasyMotion_leader_key = '<Space>'
map <Space>l <Plug>(easymotion-lineforward)
map <Space>k <Plug>(easymotion-j)
map <Space>i <Plug>(easymotion-k)
map <Space>j <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

" Bi-directional find motion
nmap <Space>a <Plug>(easymotion-s)
nmap <Space>s <Plug>(easymotion-s2)

autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

"Auto Save & Auto Load Folds
if !has('nvim')
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview 
endif

au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=4
  autocmd FileType json set softtabstop=4 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

" -----------------------------------------------------------------------------------------
"									CTRL-P
" Plugin 'ctrlp.vim'

set runtimepath^=~/.vim/bundle/ctrlp.vim

nnoremap ,t :CtrlP<CR>
nnoremap ,g :CtrlPTag<CR>
nnoremap ,l :CtrlPLine<CR>
nnoremap ,m :CtrlPMixed<CR>
nnoremap ,b :CtrlPBuffer<CR>
"nnoremap <Space> :CtrlPBuffer<CR>
nnoremap ,cl :CtrlP <F5><CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|vendor|node_modules$'

" -----------------------------------------------------------------------------------------
"								 CUSTOM DEFAULTS

" To ignore plugin indent changes, instead use:
"filetype plugin on
filetype plugin indent on    " required

" Change dir to file just opened
"set autochdir

" Backspace (allow you to backspace normally cause vim tries to help by preventing you)
set backspace=indent,eol,start

" Update frequency for things like vim-go's go_auto_type_info
"set updatetime=1000

" Put swp files in tmp dir
set swapfile
set dir=/tmp

"Color
set t_Co=256 "enable 256 colors
syntax on "enable syntax coloring
color codedark "color scheme"

" Show line numbers
set number

" Enable bling/vim-airline.git plugin
"let g:airline#extensions#tabline#enabled = 1

" Always show statusline
set laststatus=2

" Command Mode AutoComplete ex: Hit <shfit>:, start typing, hit tab
set wildmenu
set wildmode=list:longest,full

"                               -- TABS vs SPACES --
" When I hit tab, enter spaces instead
set expandtab

" Number of spaces to expand an actual tab to
set tabstop=4
set softtabstop=4

" Number of spaces to shift when doing a shift > or shift <
set shiftwidth=4

set nowrap

" Tabs Whitespace End of Line
"set list lcs=tab:»·,eol:¬,trail:·
set list lcs=tab:▸\ ,eol:¬

" Auto source vimrc on save
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

"SHORTCUTS
nnoremap go :cd ~/vm/app/precise/go/src/github.com/<CR>
nnoremap <C-t> :tabnew %<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprevious<CR>
nnoremap <C-b>p :tabprevious<CR>
nnoremap <C-b>n :tabnext<CR>
nnoremap <C-b>x :bdelete<CR>
nnoremap ;fmt :! go fmt %<CR>
nnoremap ;p :set paste<CR>
nnoremap ;np :set nopaste<CR>

map <cr-n> :NERDTreeToggle<cr>

vnoremap e= :EasyAlign=<CR>

nnoremap ,f :set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab<CR>
nnoremap ,f2 :set tabstop=4 softtabstop=4 shiftwidth=4 expandtab<CR>
nnoremap <C-B>k <C-W><Down>
nnoremap <C-B>i <C-W><Up>
nnoremap <C-B>j <C-W><Left>
nnoremap <C-B>l <C-W><Right>
nnoremap <C-B><C-K> <C-W><Down>
nnoremap <C-B><C-I> <C-W><Up>
nnoremap <C-B><C-J> <C-W><Left>
nnoremap <C-B><C-L> <C-W><Right>

map ff  mzgg=G`z<CR>
vnoremap f =

inoremap jk <Esc>l
nnoremap ;; :w<CR>
nnoremap ;w :w<CR>
nnoremap ;sp :split<CR>
nnoremap ;vsp :vsplit<CR>
nnoremap ;;q :bdelete<CR>
nnoremap ;q :q<CR>
nnoremap ;rf :call g:GitRestoreVimTabs()<CR>
map i <Up>
map j <Left>
map k <Down>
noremap h i
" Zoom in
nnoremap <silent> <C-w>f :ZoomWin<CR>

" PHP doc
noremap <leader>pd :call PhpDoc()<CR>

" GREP
" opens search results in a window w/ links and highlight the matches
command! -nargs=+ Grep execute 'silent grep! -I -r -n --exclude *.{json,pyc} . -e <args>' | copen | execute 'silent /<args>'
" shift-control-* Greps for the word under the cursor
:nmap <leader>g :Grep <c-r>=expand("<cword>")<cr><cr>

"Folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=10         "whatever you want

"Search is case insensitive
set ic

"ENABLE RESIZE WITH MOUSE
"Send more characters for redraws
if !has('nvim')
    set ttyfast
endif

" Enable mouse use in all modes
set mouse=a

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
if !has('nvim')
set ttymouse=xterm2
endif

"Windowswap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" -----------------------------------------------------------------------------------------
"								 NERDTREE
"Plugin 'scrooloose/nerdtree.git'
map <C-n> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------------------
"								 FUNCTIONS

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

function! SyncIST()
    Shell cd ~/Clients/magic-leap/serverless/src && node test.js
endfun
function! SyncISTC()
    Shell cd ~/Clients/ericksonjoseph/repos/go-design-patterns/spawn/src && go run main.go
endfun
function! TestReset()
    :GoRun
endfun

nnoremap ;t :call SyncIST()<CR>
nnoremap ;s :call SyncISTC()<CR>
nnoremap ;r :call TestReset()<CR>

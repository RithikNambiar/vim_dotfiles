"""""""""""""""""""""""""""""""""""""""""""""""""""user defined functions""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set relativenumber
set number

"set guifont=Courier_New:h11
"set autoindent
set undofile                  " Save undos after file closes
set undodir=/home/rithik/.vim/undo_files " where to save undo histories
set undolevels=1000           " How many undos
set undoreload=10000          " number of lines to save for undo
set shiftwidth=2              " press '>' to indent by the number set in 'shiftwidth'
"set smartindent
"set tabstop=4
"""""""""""""""""""""""""""""""""""""""""""""""""""""""'vundle config""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle {{{1

" needed to run vundle (but i want this anyways)
set nocompatible

" vundle needs filtype plugins off
" i turn it on later
filetype plugin indent off
syntax off

" set the runtime path for vundle
set rtp+=~/.vim/bundle/Vundle.vim

" start vundle environment
call vundle#begin()

" list of plugins {{{2
" let Vundle manage Vundle (this is required)
"old: Plugin 'gmarik/Vundle.vim'
Plugin 'VundleVim/Vundle.vim'

""""""""""""""""""""""""""""""""""""""""""""YouCompleteMe""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'valloric/youcompleteme' 
"./install.py --clang-completer
"for youcompleteme ------USE THIS TO ENABLE SUPPORT FOR C/C++/CUDA/C#  - the C family of languages 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin 'scrooloose/syntastic'
"Plugin 'jaxbot/semantic-highlight.vim'   works for C/C++, not for verilog
Plugin 'dense-analysis/ale'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'luochen1990/rainbow'
Plugin 'joshdick/onedark.vim' "  place 'colo onedark'   after the vundle config for it to work
Plugin 'townk/vim-autoclose'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-vividchalk'
Plugin 'junegunn/fzf'
Plugin 'yggdroot/indentline'
"Plugin 'AutoComplPop'        " autocomplete
"Plugin 'suoto/hdlcc' verilog plugin
" to install a plugin add it here and run :PluginInstall.
" to update the plugins run :PluginInstall! or :PluginUpdate
" to delete a plugin remove it here and run :PluginClean
"

" YOUR LIST OF PLUGINS GOES HERE LIKE THIS:
Plugin 'bling/vim-airline'

" add plugins before this
call vundle#end()

" now (after vundle finished) it is save to turn filetype plugins on
syntax on

"""""""""""""""""""""""""""""""""""""""ctrl c - copy, ctrl v -paste, ctrl x -cut""""""""""""""""""""""""""""""""""""""""""""""
"vmap <C-c> "+yi
"vmap <C-x> "+c
"vmap <C-v> c<ESC>"+p
"imap <C-v> <C-r><C-o>+
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""clangd config for YouCompleteMe"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd") 
"let g:loaded_youcompleteme = 1        "when set to 1, ycm is disabled'
set completeopt-=preview "this is to disable preview window opening up whenever ycm is used
let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']  "use <Tab> to use tab to autocomplete instead of enter

"the options below sets the popup menu color
"highlight Pmenu ctermbg=white guibg=white
"highlight PmenuSel ctermbg=black guibg=black

""""""""""""""""""""""""""""""""""""""""popup menu color settings end"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
colo onedark
let g:AutoClosePreserveDotReg = 0      "this remove pumvisible() call being randomly inserted in text
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""ale linter settings""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on

"let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['ERR: %d', 'WARN: %d', 'ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" don't run lint on huge files
if (getfsize(expand(@%)) > 50000)
   let g:ale_lint_on_save = 1
   let g:ale_lint_on_text_changed = 0
   let g:ale_lint_on_enter = 0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""NERDTree settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let NERDTreeMinimalUI = 1  "disable press? to get help at the top of nerdtree buffer when value = 1
"let NERDTreeDirArrows = 0
"au VimEnter * NERDTreeToggle /home/rithik/projects "alternate implementation is on the next line
autocmd vimenter * NERDTree /home/rithik/projects
nmap <F2> :NERDTreeToggle<CR>













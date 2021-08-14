"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""       NOTES:   This is the newer version that supports general windows keybinds like Ctrl-x,Ctrl-C, Ctrl-V, Ctrl-Z, Ctrl-S, etc       ""
""                It also has transparency effect for gvim-windows                                                                       ""
""                It has better colorschemes & improved aesthetics in general                                                            ""
""                It is quite messy, will be cleaned up soon                                                                             ""
""                A few plugin modifications/features have been commented out/disabled due to some bugs                                  ""
""                These issues are being wored on, but do check them out                                                                 ""
""                                                                                                                                       ""
""                                                                                                                                       ""
""                                                                                                                                       ""
""         !!!!!!!!         Edit path names wherever they appear in this file as it was configured for my setup         !!!!!!!!         ""
""                                                                                                                                       ""
""                                                                                                                                       ""
""                                                                                                                                       ""
""                                                                                                                                       ""
""                                                                                                                                       ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
source $VIMRUNTIME/mswin.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""user defined functions""""""""""""""""""""""""""""""""""""""""""""""""""""""
set relativenumber
set number

"set guifont=Courier_New:h11
set guifont=Lucida_Console:h10

"set autoindent
set undofile                  " Save undos after file closes
set undodir=F:\Vim\.vim_undo_files " where to save undo histories
set undolevels=1000           " How many undos
set undoreload=10000          " number of lines to save for undo
set backupdir=F:\Vim\backup_files_dir
set directory=F:\Vim\swap_files_dir
set shiftwidth=2              " press '>' to indent by the number set in 'shiftwidth'
"set smartindent
set tabstop=4
set expandtab
"hi Normal guibg=NONE ctermbg=NONE        "transparent mode
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
"Plugin 'valloric/youcompleteme' 
"./install.py --clang-completer
"for youcompleteme ------USE THIS TO ENABLE SUPPORT FOR C/C++/CUDA/C#  - the C family of languages 

"""""""""""""""""""""""""""""""""""""""""""""Vundle Plugins Installation""""""""""""""""""""""""""""""""""""""
"Plugin 'scrooloose/syntastic'
"Plugin 'jaxbot/semantic-highlight.vim'   works for C/C++, not for verilog
Plugin 'dense-analysis/ale'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'luochen1990/rainbow'
Plugin 'joshdick/onedark.vim' "  place 'colo onedark'   after the vundle config for it to work
Plugin 'townk/vim-autoclose'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-vividchalk'
Plugin 'vhda/verilog_systemverilog.vim'           "support for cadence & symopsys error formats
"Plugin 'junegunn/fzf'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'yggdroot/indentline'
Plugin 'AutoComplPop'        " autocomplete
Plugin 'ap/vim-buftabline'
Plugin 'sirver/ultisnips'
"Plugin 'severin-lemaignan/vim-minimap'   "minimap
"Plugin 'wfxr/minimap.vim'
Plugin 'morhetz/gruvbox'  "colorscheme
"Plugin 'godlygeek/csapprox' "colorscheme
"Plugin 'NLKNguyen/papercolor-theme'  "colorscheme
"Plugin 'zefei/cake16'   "colorscheme
"Plugin 'altercation/vim-colors-solarized'   "colorscheme
"Plugin 'chriskempson/base16-vim'   "colorscheme
"Plugin 'wimproved.vim'
"Plugin 'neoclide/coc.nvim'   " autocomplete
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""  Fugitive & Git-gutter config"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_git_executable = 'F:\Git\bin\git.exe'
nmap <F3> :GitGutterToggle<CR>
"nmap <S-F3> :GitGutterLineNrHighlightsToggle<CR>
nnoremap <S-F3> :GitGutterLineNrHighlightsToggle<cr>
nmap <F4> :GitGutterLineHighlightsToggle<CR>

""""""""""""""""""""""""""""""""""clangd config for YouCompleteMe"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Let clangd fully control code completion
"let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
"let g:ycm_clangd_binary_path = exepath("clangd") 
"let g:loaded_youcompleteme = 1        "when set to 1, ycm is disabled'
"set completeopt-=preview "this is to disable preview window opening up whenever ycm is used
"let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']  "use <Tab> to use tab to autocomplete instead of enter

"the options below sets the popup menu color
"highlight Pmenu ctermbg=white guibg=white
"highlight PmenuSel ctermbg=black guibg=black

""""""""""""""""""""""""""""""""""""""""popup menu color settings end"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
"colo onedark
"colo slate
"colo vividchalk
"colo blue
"colo darkblue
"colo gruvbox

"use tab to use highlighted selection in autocomplpop to complete
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

let g:AutoClosePreserveDotReg = 0      "this remove pumvisible() call being randomly inserted in text
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""ale linter settings""""""""""""""""""""""""""""""""""""""""""""""""""""""
"keep the sign gutter open
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" show errors or warnings in my statusline
let g:airline#extensions#ale#enabled = 1


" echo message
" %s is the error message itself
" %linter% is the linter name
" %severity is the severity type
 let g:ale_echo_msg_error_str = 'E'
 let g:ale_echo_msg_warning_str = 'W'
 let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" use quickfix list instead of the loclist
let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1

" only enable these linters
let g:ale_linters = {
\    'verilog': ['vlog'],
"\    'verilog': ['iverilog']
\}

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-J> <Plug>(ale_next_wrap)

let g:ale_lint_on_enter = 1 " 0 means dont run and 1 means run on opening the file
let g:ale_lint_on_save = 1  " lint on saving the file if value of this variable is '1' 
let g:ale_verilog_vlog_options = '-nologo -lint -hazards -work F:\Vim\ale_linters\modelsim_lint\work'
"let g:verilog_iverilog_options = 'iverilog -t null -Wall'
let g:ale_list_window_size = 10

let g:ale_set_highlights = 1
let g:ale_set_balloons = 1
let g:ale_hover_to_preview = 1

highlight link ALEErrorLine error "highlight line containing error in red
"highlight link ALEInfoLine 

""""""""""""""""""""""""""""""""""""""""""""""""""""NERDTree settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let NERDTreeMinimalUI = 1  "disable press? to get help at the top of nerdtree buffer when value = 1
"let NERDTreeDirArrows = 0
"au VimEnter * NERDTreeToggle /home/rithik/projects "alternate implementation is on the next line
autocmd vimenter * NERDTree H:\projects\ray_tracing
nmap <F2> :NERDTreeToggle<CR>
nmap <S-F2> :NERDTreeFocus<cr>r<c-w><c-p> " press shift + f2 to refresh nerdtree
"autocmd vimenter * NERDTreeToggle "toggle nerdtree to off on startup

""""""""""""""""""""""""""""""""""""""""""""""""""gruvbox config""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_transparent_bg = '1'
set bg=dark
colorscheme gruvbox
set cursorline
hi CursorLine term=bold cterm=bold cterm=underline guibg=Black"Grey20 "guifg='White'
hi CursorIM       guifg=#87CEEB "#FFFFFF "#87CEEB "#F8F8F8           "guibg=#002947
hi Cursor         guifg=#87CEEB "#FFFFFF "#87CEEB "#F8F8F8           "guibg=#A7A7A7

""""""""""""""""""""""""""""""""""""""""""""""""""papercolor config""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256   " This is may or may not needed.

"set background=dark
"colorscheme PaperColor
"colorscheme cake16

""""""""""""""""""""""""""""""""""""""""""""""""""solarized colorscheme config"""""""""""""""""""""""""""""""""""""""""""""""

"syntax enable
"set background=light
"colorscheme solarized


""""""""""""""""""""""""""""""""""""""""""""""""""window transparency config"""""""""""""""""""""""""""""""""""""""""""""""

"Plugin 'mattn/vimtweak'
"Plugin 'mattn/transparency-windows-vim'
Plugin 'wimproved.vim'
"Plugin 'tsuyoshicho/transparency.vim'

autocmd GUIEnter * silent! WToggleClean

"autocmd GUIEnter * silent! WToggleFullscreen
nmap <F11> :WToggleFullscreen<CR>

"let g:transparency_config = {
"      \  'active'   : 90,
"      \  'inactive' : 70
"      \ }

"let g:transparency_startup_enable = 1 "it is 1 by default
"nmap <F3> <Plug>(TransparencyToggle)


""""""""""""""""""""""""""""""""""""""""""""""""""shortcut to change font size"""""""""""""""""""""""""""""""""""""""""""""""


nnoremap <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""TODO & FIXME comment highlightin"""""""""""""""""""""""""""""""""""""""""""""

syn match   myTodo   contained   "\<\(TODO\|FIXME\):"
"syn match   myTodo   contained   "\<\(TODO\|FIXME\|ERROR|BROKEN):"
"highlight def link myTodo Todo

syn match   TODOs   contained   "\<\(TODO\|FIXME\):"
"syntax match TODOs ".*TODO.*\|.*BUG.*\|.*HACK.*"
syntax match TODOs ".*TODO.*\|.*BUG.*\|.*BROKEN.*\|.*ERROR.*\|.*INCOMPLETE.*\|.*ISSUES.*\|.*FIXME.*\|.*REFERENCE.*\|.
                      \*REFER.*\|.*COMPLETEME.*\|.*WARNING.*\|.*NOTE.*\|.*NOTES.*\|.*INFO.*"
"highlight TODOs ctermbg=red ctermfg=yellow term=bold,italic

highlight TODOs guibg='Purple' guifg='White' "ctermbg=purple ctermfg=white term=bold cterm=bold
nnoremap <F6> :source $MYVIMRC<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""Buffers as Tabs""""""""""""""""""""""""""""""""""""""""""""""""""

"Plugin 'ap/vim-buftabline'

set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>


"hi Normal guibg=NONE

au GUIEnter * simalt ~x       " maximised window on startup

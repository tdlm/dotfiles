syntax enable

" Turn both relative number and number on.
set relativenumber
set number

" Enable mouse usage and scrolling.
set mouse=a
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

" No wrapping, please.
set nowrap

" Turn on modeline (settings per file).
set modeline
set modelines=1

" Change leader to comma.
let mapleader = ","

" Status Line
" set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
set statusline=\PATH:\ %r%F\ \ \ \ \LINE:\ %l/%L/%P\ TIME:\ %{strftime('%c')}

" Always display status line
set laststatus=2

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Netrw basic configuration.
let g:netrw_banner=0
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
autocmd FileType netrw set nolist
noremap <Leader><Tab> :call VexToggle(getcwd())<CR>
noremap <Leader>` :call VexToggle("")<CR
" tree listing by default
let g:netrw_liststyle=3
" open files in right window by default
let g:netrw_chgwin=1
" remap shift-enter to fire up the sidebar
nnoremap <silent> <S-CR> :rightbelow 20vs<CR>:e .<CR>
" the same remap as above - may be necessary in some distros
nnoremap <silent> <C-M> :rightbelow 20vs<CR>:e .<CR>

" Automatically open the file explorer
" autocmd VimEnter * :rightbelow 20vs
" autocmd VimEnter * :e .
" autocmd VimEnter * wincmd w 

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" surround.vim
Plug 'tpope/vim-surround'

" list buffers in status plugin.
Plug 'bling/vim-bufferline'

" bufexplorer.
Plug 'jlanzarotta/bufexplorer'

call plug#end()

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor.
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nnoremap \ :Ag<SPACE>

" Allow for per-project vim configuration files.
set exrc

" Secure only though.
set secure

" Enable most vim settings
set nocompatible

" Disable arrow keys (force to use hjkl)
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"noremap! <Up> <Nop>
"noremap! <Down> <Nop>
"noremap! <Left> <Nop>
"noremap! <Right> <Nop>

" Force bash as shell (fish/vundle not compatible)
set shell=/bin/bash

" Vundle Setup
filetype off

call plug#begin()

" Status bar
Plug 'itchyny/lightline.vim'

" Color Scheme
Plug 'morhetz/gruvbox'

" Coc for autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-styled-components', {'do': 'yarn install --frozen-lockfile'}

" File Tree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Editor Config
Plug 'editorconfig/editorconfig-vim'

" Syntax Checking and Highlighting
Plug 'sheerun/vim-polyglot'

" Fuzzy finding
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Inline Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-rhubarb'

" Global find and replace
Plug 'brooth/far.vim'

" Comment blocks
Plug 'preservim/nerdcommenter'

" Multiline Editing
Plug 'mg979/vim-visual-multi'

call plug#end()

filetype plugin indent on

" ----- General Vim Settings -----
set foldmethod=syntax         
set foldlevelstart=99
set backspace=indent,eol,start
set ruler
set number
set relativenumber
set showcmd
set incsearch
set hlsearch
set ignorecase " Case-insensitive search
set smartcase  " Smart case-insensitive search (requires ignorecase)
" Always show gutter (dont move left to right)
set signcolumn=yes
" Update git and syntax more quickly
set updatetime=250
syntax on

" ----- Theme (gruvbox) -----

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark

" ----- Lightline -----
" -- INSERT -- no longer needed
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
		  \              [ 'percent' ],
		  \              [ 'filetype' ] ]
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" ----- jistr/vim-nerdtree-tabs -----

" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let NERDTreeShowHidden=1
autocmd VimEnter * call NERDTreeAddKeyMap({ 'key': '<2-LeftMouse>', 'scope': "FileNode", 'callback': "OpenInTab", 'override':1 })
    function! OpenInTab(node)

      call a:node.activate({'reuse': 'all', 'where': 't'})
    endfunction

" Clear gutter bg color
hi clear SignColumn

" ----- Telescope settings -----
nmap <c-p> :Telescope git_files<cr>
nmap <c-f> :Telescope live_grep<cr>

lua << EOF
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["<CR>"] = 'select_tab',
      },
      i = {
        ["<CR>"] = 'select_tab',
      },
    },
  },
}
EOF

" ----- CoC settings -----
" Tab completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Intellisesnse
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation (\h)
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Rename (\rn)
nmap <leader>rn <Plug>(coc-rename)

" ----- Far settings -----

" Open far in new tab to not overwrite current buffer
let g:far#window_layout = 'tab'

" Bottom preview height
let g:far#preview_window_height = 20

" Setup rg as search for speed and gitignore support
let g:far#source = 'rgnvim'
let g:far#glob_mode = 'rg'
let g:far#default_file_mask = '*'

" Displaying results on right breaks syntax highlighting of results
"let g:far#preview_window_layout = 'right'

hi FarFilePath ctermfg=Blue

" ----- Mouse -----

" let g:VM_mouse_mappings = 1
" Doing this manually because CTRL Left click is an osx thing
" So biunding to both left and right mouse
nmap <C-LeftMouse> <LeftMouse>g<Space>
nmap <C-RightMouse> <LeftMouse>g<Space>
imap <C-LeftMouse> <esc><LeftMouse>g<Space>
imap <C-RightMouse> <esc><LeftMouse>g<Space>

" ----- Other Settings ----

" Enable vim mouse compat
" http://vim.wikia.com/wiki/Make_mouse_drag_not_select_text_or_go_into_visual_mode
set mouse=a
" Fix mouse selection on long lines
" https://stackoverflow.com/questions/7000960/in-vim-why-doesnt-my-mouse-work-past-the-220th-column
if !has('nvim')
  set ttymouse=sgr
endif

" Fix Copy Paste
" https://stackoverflow.com/questions/17561706/vim-yank-does-not-seem-to-work
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Stop auto comment insertion
" https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Ctrl q to quit
nmap <c-q> :q<cr>
imap <c-q> <esc>:q<cr>a

" Crtl s to save
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>a

" Ctrl v to paste like a normal person (with auto fixing indentation)
" http://vim.wikia.com/wiki/Format_pasted_text_automatically
"nmap p p=`]
"nmap <c-v> p

" Reselect visual paste after shifting block
" https://vi.stackexchange.com/questions/598/faster-way-to-move-a-block-of-text
xnoremap > >gv
xnoremap < <gv

" Tabs to spaces, and indentation
:set tabstop=2
:set shiftwidth=2
:set expandtab

" Disable swap files for git
set noswapfile

" Change cursor for normal vs insert mode
" https://stackoverflow.com/questions/15217354/how-to-make-cursor-change-in-different-modes-in-vim
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" Change Vim Cursor Depending on mode:
" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>[4 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" Enable most vim settings
set nocompatible

" Confirm when quitting without having written
set confirm

" Force bash as shell (fish/vundle not compatible)
set shell=/bin/bash

" Vundle Setup
filetype off

" Change this to enable linting
let g:enable_ale = 1

" Use coc.vim for LSP (perf)
let g:ale_disable_lsp = 1

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
Plug 'tpope/vim-rhubarb'

Plug 'tpope/vim-surround'

" Global find and replace
Plug 'windwp/nvim-spectre'

" Comment blocks
Plug 'preservim/nerdcommenter'

" Multiline Editing
Plug 'mg979/vim-visual-multi'

" Previewer for files - used only for it's vim window implementation
Plug 'rmagatti/goto-preview'

" Linting
if g:enable_ale
  Plug 'dense-analysis/ale'
endif

call plug#end()

filetype plugin indent on

" ----- General Vim Settings -----
set foldmethod=syntax         
set foldlevelstart=99
set backspace=indent,eol,start
set ruler
set number
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
colorscheme blackboard
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

" ----- ALE -----
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'

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

" ----- Goto Preview -----
" Note: This plugin really isn't used for it's LSP - only used for it's stacking floating windown implementation

lua << EOF
  require"goto-preview".setup { }
EOF

" ----- CoC settings -----
" Tab completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Intellisesnse
nmap <silent> gd :PreviewDefinition<CR>
nmap <silent> gy :PreviewTypeDefinition<CR>
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

" Inline previews (similar to VSCode)
function! OpenPreviewInline(...)
    let fname = a:1
    let call = ''
    if a:0 == 2
        let fname = a:2
        let call = a:1
    endif
    lua require('goto-preview.lib').open_floating_win(fname, { 1, 0 })
    " goto-preview does not actually open the correct file lol
    execute 'e ' . fname

    "" Execute the cursor movement command
    exe call
endfunction
command! -nargs=+ CocOpenPreviewInline :call OpenPreviewInline(<f-args>)

command! -nargs=0 PreviewDefinition :call CocActionAsync('jumpDefinition', 'CocOpenPreviewInline')
command! -nargs=0 PreviewTypeDefinition :call CocActionAsync('jumpTypeDefinition', 'CocOpenPreviewInline')

" BG for inline previews
"hi Pmenu ctermbg=233 guibg=#1d2021

" ----- Spectre -----

" Global search
nnoremap <leader>S :lua require('spectre').open()<CR>

" Search current word
nnoremap <leader>sw :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>s :lua require('spectre').open_visual()<CR>
" Search in current file
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>

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

"Custom Boushi configs
nmap <S-q> :q<cr>
nnoremap w b

"Temporarily disabled settings

" Ctrl q to quit
" nmap <c-q> :q<cr>
" imap <c-q> <esc>:q<cr>a

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
" ----- Move lines vertically -----

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


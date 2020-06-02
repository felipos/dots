call plug#begin()
  Plug 'rafi/awesome-vim-colorschemes'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'vimwiki/vimwiki'
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'Xuyuanp/nerdtree-git-plugin'       " might slow your vim
  Plug 'ryanoasis/vim-devicons'            " might slow your vim
  Plug 'jiangmiao/auto-pairs'
  Plug 'vim-airline/vim-airline'
  Plug 'mhinz/vim-startify'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'airblade/vim-gitgutter'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-rhubarb'                 " Enable github features on Fugitive
  Plug 'tpope/vim-fugitive'
  Plug 'jparise/vim-graphql'
  Plug 'sotte/presenting.vim'
  Plug 'junegunn/goyo.vim'
call plug#end()

"""""""""""" core """""""""""""
syntax on
set number relativenumber
set hidden "disable vim questions about not saved files
set clipboard=unnamedplus "clipboard
set incsearch
set ignorecase
set encoding=utf-8
set mouse=a
set inccommand=split
let mapleader=","
set nowrap
set termguicolors
set nohlsearch
set backupcopy=yes
set autoread
set cursorline
set ruler
set autowrite
set wildmenu  "put a little menu in : commands bar

"""""""""""" Tab settings """""""""""""""""""""""""""
set tabstop=2        " The width of a TAB is set to 2.
set shiftwidth=2     " Indents will have a width of 4
set softtabstop=2    " Sets the number of columns for a TAB
set expandtab        " Expand TABs to spaces

"""""""""""" Remove trailing on save """""""""""""""
autocmd BufWritePre * %s/\s\+$//e

"""""""""""" Dont use clipboard for the following """
nnoremap x "_x
nnoremap c "_c

au FocusGained,BufEnter * :checktime

"""""""""""" shortcuts """""""""""""
nnoremap <leader>b <C-^>
nnoremap <leader>sr :source ~/.config/nvim/init.vim<CR>

nnoremap <F11> :bprevious<CR>
nnoremap <F12> :bnext<CR>

" swiching between windows
nnoremap <silent> <C-w> <C-w><C-w>
inoremap <silent> <C-w> <Esc><C-w><C-w>
vnoremap <silent> <C-w> <Esc><C-w><C-w>


"""""""""""" snippets """""""""""""
nnoremap ,l :-1read $HOME/.snippets/consolelog.js<CR>


"""""""""""" colorscheme """""""""""""
"colorscheme OceanicNext
"colorscheme abstract
"colorscheme alduin
"colorscheme angr
"colorscheme anderson
"colorscheme atom
"colorscheme challenger_deep
"colorscheme carbonized-dark
"colorscheme deep-space
"colorscheme default
"colorscheme desert
"colorscheme deus
"colorscheme flattened_light
"colorscheme koehler
"colorscheme lucius
colorscheme materialbox
"colorscheme nord
"colorscheme onedark
"colorscheme rakr
"colorscheme snow
"colorscheme stellarized
"colorscheme two-firewatch
"colorscheme afterglow
"colorscheme papercolor
"colorscheme scheakur
"colorscheme gruvbox
"colorscheme solarized8
"set background=light
"set background=dark

"""""""""""" fzf """""""""""""
nnoremap <leader><leader> :Buffer<CR>
nnoremap <leader>e :Files<CR>

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'


"""""""""""" NERDTree """""""""""""
nmap<F3> :NERDTreeToggle<CR> " toggle on F3
"autocmd vimenter * NERDTree  " automatic start
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" make sure vim does not open files and other buffers on NerdTree window
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let g:plug_window = 'noautocmd vertical topleft new'

let NERDTreeShowHidden=1


""""""""""""" NERD Commenter """""""""""
nnoremap <C-_> :call NERDComment(0,"toggle")<C-m>
vnoremap <C-_> :call NERDComment(0,"toggle")<C-m>
inoremap <C-_> <C-o>:call NERDComment(0,"toggle")<C-m>


""""""""""" Vim Airline """""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'


""""""""""" Startify """""""""""
nnoremap <leader>y :Startify<CR>


""""""""""" Git Plugins """""""""""
set updatetime=100 " gitgutter time

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

nmap <leader>d <Plug>GitGutterPreviewHunk


"""""""""" Resize Window """""""""""
nnoremap <F7> :exe "20winc >"<CR>
nnoremap <F10> :exe "20winc <"<CR>
noremap <silent> <F8> :resize -3<CR>
noremap <silent> <F9> :resize +3<CR>


"""""""""" Move Window """""""""""
nnoremap <silent> <C-L> <c-w>l
nnoremap <silent> <C-H> <c-w>h
nnoremap <silent> <C-K> <c-w>k
nnoremap <silent> <C-J> <c-w>j


""""""""""" Saving Files """""""""""
noremap <silent> W :w! <CR>
command BD bp | sp | bn | bd
noremap <silent> E :BD <CR>
noremap <silent> <C-E> :qa! <CR>


""""""""" COC Things """""""""
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"""" COC Prettier """"
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>p :Prettier<CR>


""""""""""" Vimwiki """""""""""
set nocompatible
filetype plugin on
let g:vimwiki_list = [ {'path': '~/Documents/notes', 'syntax': 'markdown', 'ext': '.md'} ]


""""""""""" Multiple Cursor Bind """""""""""
"let g:multi_cursor_start_word_key      = '<F10>'

"""""""""" Others """""""""""
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Setting python on OSX
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'



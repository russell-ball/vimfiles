﻿" neovim compatibility
"let g:python_host_prog = '/usr/bin/python'

if has('nvim')
  set termguicolors
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

" avoiding annoying CSApprox warning message
let g:CSApprox_verbose_level = 0

" necessary on some Linux distros
filetype on
filetype off

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Load all bundles
runtime vim-plug.vim

" Reprocess this file if it's saved
if has("autocmd")
  autocmd! bufwritepost vimrc source $MYVIMRC | AirlineRefresh | AirlineToggle | AirlineToggle
endif
if has("autocmd")
  autocmd! bufwritepost vim-plug.vim source ~/.vim/vim-plug.vim | PlugInstall
endif

" Disable backup and swap files - more trouble than they're worth
set nobackup
set noswapfile

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set ignorecase  "case-insensitive searching ...
set smartcase   "unless an uppercase is provided
set gdefault    "default replace to global (rather than first instance)
set showbreak=...
set nowrap linebreak nolist
set lazyredraw  " don't redraw during complex operations

" use vim's 'hybrid line number' method
set relativenumber
set number
" let mapleader = ","
let mapleader = "\<Space>"
let g:maplocalleader = '\'

" show whitespace with a hotkey
set listchars=tab:>-,trail:·,eol:$

" set the leader timeout to a short interval (defaults to 1 sec)
set timeout timeoutlen=500 ttimeoutlen=100

" get out of insert mode w/ shift-enter, or jk
inoremap jk <Esc>`^
inoremap JK <Esc>`^

" same deal for neovim terminal mode
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap jk <C-\><C-n>
end

" adjust tab positions
nnoremap “ :tabmove -1<CR>
nnoremap ‘ :tabmove +1<CR>

" close other buffers
nnoremap <leader>co :BufOnly!<CR>

" use H to go to begin of line and L to go to end of line
noremap H ^
noremap L g_

" add some line space for easy reading
set linespace=4

" disable visual bell
set visualbell t_vb=

" try to make possible to navigate within lines of wrapped lines
nmap <Down> gj
nmap <Up> gk
set fo=l

set laststatus=2

" turn off needless toolbar on gvim/mvim
set guioptions-=T
" turn off needless vertical scrollbars"
set guioptions-=r
set guioptions-=l

" indent settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set autoindent

" folding settings
set foldmethod=manual   " manual folding for performance
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " dont fold by default

set wildmode=list:longest                               " make cmdline tab completion similar to bash
set wildmenu                                            " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,**/compiled/**,**/vendor/** " stuff to ignore when tab completing

set formatoptions-=o " dont continue comments when pushing o/O

" vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" load ftplugins and indent files
filetype plugin on
filetype indent on

" turn on syntax highlighting
syntax on

" some stuff to get the mouse going in term
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif

" hide buffers when not displayed
set hidden

" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'
" Ignore netrw for Ctrl-^
let g:netrw_altfile = 1

" peekaboo
let g:peekaboo_window = 'vertical botright 100new'

nnoremap <C-p> :GitFiles --exclude-standard -co<CR>
" alt-b
nnoremap ∫ :Buffers<CR>
" alt-|
nnoremap « :BTags<CR>
" alt-l
nnoremap ¬ :BLines<CR>
" alt-L
nnoremap Ò :Lines<CR>

nnoremap <leader>ht :Helptags<CR>
nnoremap <space>f :Filetypes<CR>

command! -bang -nargs=* Fag call fzf#vim#ag(<q-args>, g:fzf#vim#layout(<bang>0))
nnoremap <C-f> :Fag<CR>

" Disable ctrl-p
let g:loaded_ctrlp = 1
let g:ctrlp_map = ''

" NERDTree
nnoremap gnt :NERDTreeToggle<CR>
nnoremap gnf :NERDTreeFind<CR>

" Disable default Ctrl-j and Ctrl-k mappings for these
" commands since they're used for window switching
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpPrevSibling = ''

" TagBar configuration
map gtb :TagbarToggle<CR>
let g:tagbar_type_coffee = {
    \ 'ctagstype' : 'coffee',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'm:methods',
        \ 'f:functions',
        \ 'v:variables',
        \ 'f:fields',
        \ 'f:static fields',
    \ ]
\ }

" sweet statusline indicators
let g:airline_powerline_fonts                      = 1
let g:airline#extensions#tabline#enabled           = 1
let g:airline#extensions#tabline#tab_min_count     = 2
let g:airline#extensions#tabline#tab_nr_type       = 1 " tab number
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_buffers      = 0
let g:airline_theme                                = 'hybridline'

" set t_Co=256 " tell the term has 256 colors
set enc=utf-8

if has('nvim')
  colorscheme Papercolor
  set background=dark
else
  colorscheme molokai
endif

if has("gui_running")
  if has("gui_gnome")
    set term=gnome-256color
    set guifont=Monospace\ Bold\ 10
  endif

  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
  endif
else
  " dont load csapprox if there is no gui support - silences an annoying warning
  let g:CSApprox_loaded = 1

  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  endif

  " Switch cursor shape correctly in tmux > iterm2 > osx
  if $TMUX != ''
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif
endif

" map Q to something useful
nnoremap Q @@
vnoremap Q :normal @@<CR>

" bindings for ragtag
inoremap <M-o> <Esc>o
inoremap <C-j> <Down>
let g:ragtag_global_maps = 1

" == Syntastic configuration
let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': ['ruby', 'coffee', 'javascript', 'json'],
                            \ 'passive_filetypes': ['puppet', 'html', 'handlebars'] }

let g:syntastic_always_populate_loc_list = 1

" When set to 2 the cursor will jump to the first issue detected, but only if
" this issue is an error. >
let g:syntastic_auto_jump = 2

" key mapping for Gundo
nnoremap <F5> :GundoToggle<CR>

" visual search mappings - find selection
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>zz
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>zz

" search and replace using Over
nnoremap g/r :<c-u>OverCommandLine<cr>%s/
xnoremap g/r :<c-u>OverCommandLine<cr>%s/\%V

" jump to last cursor position when opening a file
" dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction

" define :HighlightLongLines command to highlight the offending parts of
" lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
  let targetWidth = a:width != '' ? a:width : 79
  if targetWidth > 0
    exec 'match Todo /\%>' . (targetWidth) . 'v/'
  else
    echomsg "Usage: HighlightLongLines [natural number]"
  endif
endfunction

"  Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s = @/
  let l  = line(".")
  let c  = col(".")

  " Do the business:
  %s/\s\+$//e

  " Clean up: restore previous search history, and cursor position
  let @/ = _s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" neovim is a dick about this thanks to libterm or whatever
if has('nvim')
  nmap <BS> <C-w>h

  " map window navigation in terminal mode
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

" easy window quit
nnoremap <Leader>q :q<CR>

" buffkill configuration
let g:BufKillFunctionSelectingValidBuffersToDisplay = 'auto'

" easy buffer wipe
nnoremap <C-x> :BW!<cr>

" close all open buffers
nnoremap <Leader>bwa ::BW!<CR>:bufdo BW!<CR>

" easy window focus (closes all others)
nnoremap <Leader>F <C-W>o

" easy splits
nnoremap <bar> :vsplit<CR><C-W><C-L>
nnoremap _ :split<CR><C-W><C-J>

" tabs
nnoremap C-t :tabnew<CR>
nnoremap g1 1gt
nnoremap g2 2gt
nnoremap g3 3gt
nnoremap g4 4gt
nnoremap g5 5gt

" nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>

" Go to last active tab
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <Tab> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <Tab> :exe "tabn ".g:lasttab<cr>

" key mapping for saving file
noremap <leader>s :w<CR>
noremap ß :w<CR> " alt-s

let ScreenShot = {'Icon':0, 'Credits':0, 'force_background':'#FFFFFF'}

" == DbExt configuration ==
let g:rails_no_dbext = 1

" -- profiles
let g:dbext_default_type                     = 'PGSQL'
let g:dbext_default_profile_Local_N360       = 'type=PGSQL:host=localhost:dbname=network360_development'
let g:dbext_default_profile_Staging_N360     = 'type=PGSQL:host=stagingdb01:dbname=network360:user=jshafton:passwd=xxx'
let g:dbext_default_profile_Production_N360  = 'type=PGSQL:host=proddb02.arsalon:dbname=network360:user=jshafton:passwd=xxx'

let g:dbext_default_profile_Local_Nexus_core      = 'type=PGSQL:host=localhost:port=15432:dbname=provider_nexus_core:user=developer:passwd=xxx'
let g:dbext_default_profile_Local_Nexus_search    = 'type=PGSQL:host=localhost:port=25432:dbname=provider_nexus_search:user=developer:passwd=xxx'
let g:dbext_default_profile_Local_Nexus_Test      = 'type=PGSQL:host=localhost:port=15432:dbname=provider_nexus_test:user=developer:passwd=xxx'

let g:dbext_default_profile_LoadTest_Nexus_Core   = 'type=PGSQL:host=10.1.10.58:dbname=provider_nexus_core:user=jshafton:passwd=xxx'
let g:dbext_default_profile_LoadTest_Nexus_Search = 'type=PGSQL:host=10.1.10.161:dbname=provider_nexus_search:user=jshafton:passwd=xxx'

let g:dbext_default_profile_Staging_Nexus_search = 'type=PGSQL:host=10.1.10.89:dbname=provider_nexus_search:user=jshafton:passwd=xxx'

let g:dbext_default_profile_Production_Nexus_core   = 'type=PGSQL:host=10.0.10.225:dbname=provider_nexus_core:user=jshafton:passwd=xxx'
let g:dbext_default_profile_Production_Nexus_search = 'type=PGSQL:host=10.0.10.93:dbname=provider_nexus_search:user=jshafton:passwd=xxx'

let g:dbext_default_profile_Triscuit_sqsh    = 'type=SQLSRV:user=jshafton:passwd=@askg:host=triscuit:SQLSRV_bin=sqsh:SQLSRV_cmd_options=:extra=-Striscuit -D Network360 -w 9999999'
let g:dbext_default_profile_Strenuus5_sqsh   = 'type=SQLSRV:user=jshafton:passwd=@askg:host=strenuus5:SQLSRV_bin=sqsh:SQLSRV_cmd_options=:extra=-Sstrenuus5 -D Network360 -w 9999999'
let g:dbext_default_profile                  = 'Local_Nexus'

" -- results buffer
let g:dbext_default_buffer_lines          = 20
let g:dbext_default_use_sep_result_buffer = 1
let g:dbext_display_command_line          = 1

" -- misc config
let g:dbext_default_always_prompt_for_variables = -1 " never prompt for variables

" set up autocompletion for SQL
autocmd FileType sql set omnifunc=sqlcomplete#Complete
autocmd FileType pgsql set omnifunc=sqlcomplete#Complete

" set file type for Postgres for SQL files
au BufNewFile,BufRead *.sql set ft=pgsql

" set file type for sneaky Handlebars files
au BufNewFile,BufRead *.hbs.html set ft=handlebars

" set file type for sneaky Slim files
au BufNewFile,BufRead *.html.slim set ft=slim

" Paste intelligently by default
nnoremap p pv`]=`]
nnoremap P Pv`]=`]

" yank to end of line
nmap Y y$

" in visual mode Y selects to clipboard
xnoremap Y "*y

" Option p/P to paste raw
nnoremap π p
nnoremap ∏ P

" duplicate selected text
vnoremap ∂ y`>p " alt-d

" use CTRL-v to paste in insert mode
set pastetoggle=<F10>
inoremap <C-v> <F10><C-r>*<F10>

" transpose words configuration
nmap gs <Plug>Transposewords

" visually select the text that was last edited/pasted
nmap gV `[v`]

" textmate-like indentation
nnoremap ≤ <<
nnoremap ≥ >>
vmap ≤ <gv
vmap ≥ >gv

" shortcut for selecting the last selection
nnoremap <Leader>v gv

" expand %% to full directory path in command line
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" copy current file path to the system clipboard
nmap <leader>cfp :let @* = expand("%")<CR>

" == YankRing
let g:yankring_max_history = 1000
let g:yankring_replace_n_pkey = '¯'
let g:yankring_replace_n_nkey = '˘'

" nnoremap gyr :YRShow<CR>
" nnoremap gy/ :YRSearch<space>

" == Highlight current line for graphical VIM <-- THIS SLOWED THINGS DOWN!
" set cul
"hi CursorLine term=none cterm=none ctermbg=3

" Cursorline highlighting
let g:conoline_auto_enable = 0

" edit this file!
nnoremap <leader>ev :tabnew ~/.vim/vimrc<cr>
" edit bundles
nnoremap <leader>eV :tabnew ~/.vim/vim-plug.vim<cr>

" command for saving when you don't have permission
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" create directories for new files on write
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" always focus search terms
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap g; g;zz

" open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Sneak configuration
let g:sneak#use_ic_scs = 1
let g:sneak#streak = 1
let g:sneak#f_reset = 1
let g:sneak#t_reset = 1

" --------------------------------------------------------------------------------
" EasyMotion configuration
" --------------------------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" let g:EasyMotion_leader_key = '<space>'
" map <space> <Plug>(easymotion-prefix)

" Bi-directional find motion
nmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1
" END - EasyMotion configuration
" --------------------------------------------------------------------------------

" Enable caamel case movement motions
"call camelcasemotion#CreateMotionMappings('<leader>')

" Replace current word in file
nmap <leader>R :%s/<C-R><C-W>/<C-R><C-W><C-F>vb

" turn off diff formatting
noremap <leader>do :set nodiff fdc=0 \| norm zR<CR><C-W>h:bwipeout<CR>

" find current word in project using Ag
nnoremap gu :Ag '\b<C-R><C-W>\b'<cr>

" find in files
nnoremap gfir :Ag -G '\.rb' -i<SPACE>

" Fugitive short-cuts
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :! git push<CR>
nnoremap <leader>grb :! git pull --rebase<CR>
nnoremap <leader>ga :! git add .<CR> " adds everything to the index
nnoremap <leader>grh :! git reset .<CR> " git reset head -- unstages everything

" GitV configuration
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>

" DelimitMate config
let delimitMate_expand_cr = 1

" use . to repeat last command over a visual range
vnoremap . :normal .<CR>

" use the @q macro over a visual range
vnoremap @q :normal @q<CR>

" enable matching
runtime macros/matchit.vim

" format json
nnoremap <leader>jpp :%!python -m json.tool<CR>

" tag matching for HTML/templates
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'handlebars' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \}

if has("gui_macvim")
  " Disable MacVim's default mac-like cmd key bindings
  let g:macvim_skip_cmd_opt_movement = 1

  " Comment lines with cmd+/
  vmap <D-/> :TComment<cr>gv

  " == Bubble text (requires unimpaired plugin) ==
  " -- Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " -- Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv

  " duplicate selected text
  vnoremap <D-d> y`>p

  " Mac-like save
  map <D-s> :w<CR>
  " save all unsaved buffers
  map <D-S> :wa<CR>

  " find in files
  nnoremap <D-F> :Ag! -i<SPACE>
endif

" Comment to the right
nmap gcr :TCommentRight<CR>

" Inline comment selection
vmap gci :TCommentInline<CR>

" Persistent undo
set undofile
set undodir=~/.vim/.undo

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)

" Align selection based on last instance of word
vmap <Leader>aw :EasyAlign -// {'ig': []}<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Put ; to good use! <-- have to wait for vim sneak to get updated
" https://github.com/justinmk/vim-sneak/issues/41
" https://github.com/justinmk/vim-sneak/issues/52
" nnoremap ; :

" Gist configuration
let g:gist_detect_filetype         = 1
let g:gist_show_privates           = 1
let g:gist_post_private            = 1
let g:gist_update_on_write         = 2 " Only :w! updates a gist.
let g:gist_open_browser_after_post = 1

" investigate.vim
let g:investigate_use_dash=1

" toggle quickfix/location list
let g:toggle_list_no_mappings=1
nnoremap tqf :call ToggleQuickfixList()<CR>
nnoremap tll :call ToggleLocationList()<CR>

" notes configuration
let g:notes_directories = ['~/Dropbox/Notes']
let g:notes_title_sync = 'rename_file'
let g:notes_suffix = '.md'

" vimwiki configuration
let wiki = {}
let wiki.path = '~/Dropbox/VimWiki/'
let wiki.nested_syntaxes = {'python': 'python', 'sh': 'sh', 'ruby': 'ruby', 'scala': 'scala', 'pg': 'pgsql'}
let g:vimwiki_list = [wiki]

" conque-shell configuration
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_InsertOnEnter = 0
let g:ConqueTerm_CWInsert = 1

" include coffeescript in vim-node
let g:node#includeCoffee = 1

" surround with handlebars {{ }}
let g:surround_104 = "{{ \r }}"

" turn on rainbow parens for lisps
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

" Disable vim-polyglot markdown in favor of better one
let g:polyglot_disabled = ['markdown']

" vim-maximizer settings
" szw/vim-maximizer

let g:maximizer_set_default_mapping = 0
nnoremap <silent><leader>f :MaximizerToggle<CR>
vnoremap <silent><leader>f :MaximizerToggle<CR>gv

" Incompatible (but I like)
" TODO

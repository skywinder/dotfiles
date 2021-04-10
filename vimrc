"------------------------------------------------------------
" Vundle {{{1
"
set nocompatible              " be iMproved, required
filetype off                  " required


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plugins:

" Surround text in bracets
Plug 'tpope/vim-surround'
"Support global clipboard in OS X
Plug 'kana/vim-fakeclip'
"Fast comment lines
Plug 'scrooloose/nerdcommenter'
" https://github.com/dbeniamine/cheat.sh-vim
Plug 'dbeniamine/cheat.sh-vim'

Plug 'tpope/vim-sensible'

" Color schemes:
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'vim-ruby/vim-ruby'
Plug 'tomlion/vim-solidity'
Plug 'vim-airline/vim-airline'

"Quick search:
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'alok/notational-fzf-vim'

" Initialize plugin system
call plug#end()

"------------------------------------------------------------
" Features {{{1
"

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

"------------------------------------------------------------
" My personal sets:

"Enble OS X clipboard support:
set clipboard=unnamed

"Increment search:
:set incsearch

"highllight matching braces:
"https://vim.fandom.com/wiki/Moving_to_matching_braces
:set showmatch
:set matchtime=3

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Fast quit and save from insert mode
:map <C-X> <ESC>:x<CR>
:imap <C-X> <ESC>:x<CR>

"https://github.com/mutewinter/dot_vim/blob/master/mappings.vim
" Scroll larger amounts with gj / gk
nnoremap gj 15gjzz
nnoremap gk 15gkzz
vnoremap gj 15gjzz
vnoremap gk 15gkzz

" ---------------
" Insert Mode Mappings
" ---------------

" Let's make escape better, together.
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>


" Insert newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

"To clear the last used search pattern:
nnoremap <F3> :let @/ = ""<CR>

" for sudo save https://stackoverflow.com/questions/14948441/vim-cant-save-file-e212
cmap w!! %!sudo tee %

"------------------------------------------------------------
"Colorscheme:
"colorscheme badwolf
"colorscheme molokai
colorscheme gruvbox
set background=dark    " Setting dark mode

" https://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim
" set shortcut for paste mode to F4
set pastetoggle=<F4>

"Forcing vimdiff to wrap lines
"https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
au VimEnter * if &diff | execute 'windo set wrap' | endif

let g:nv_search_paths = ['~/wiki', '~/repo', '~/Desktop']

"Show matching brackets
set showmatch

"Shows what you are typing as a command
set showcmd

"Set line number
set number

"how backspace works at start of line
set bs=indent,eol,start

colorscheme elflord
"colorscheme mayansmoke
"colorscheme blueshift
"colorscheme louver

"Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

"Enable mouse usage
"set mouse=a
set ignorecase
set smartcase
set incsearch

"Set split screen to open a new page
set winheight=999
set wmh=0

set colorcolumn=80

"Spaces are better than a tab character
set expandtab
set smarttab

"Who wants an 8 character tab?  yay, not me!
set shiftwidth=4
set softtabstop=4

"Highlight things that we find with the search
set hlsearch

"Set C-Style indenting
set cindent

"Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

"When I close a tab, remove the buffer
set nohidden

"Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

if has ("syntax")
        syntax on
endif

set tags=./tags;/

" map the tab next, previous and new
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>

if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate
    set csprg=/usr/bin/cscope
    " Search cscope db first before searching ctags db
    set csto=0

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cst

    " Reset cscope verbose before adding the db
    set nocsverb

    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    "else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set csverb

    "map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
    "map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
endif

if exists('loaded_multiplesearch')
    finish
endif
let loaded_multiplesearch = 1

" Vim versions prior to 7.0 don't support the autoload mechanism, so go ahead
" and load the 'autoload' segment of the code and map the commands using the
" non-autoload format.
if v:version < 700
    runtime .vim/plugin/MultipleSearch.vim

    if !(exists(":SearchBuffers") == 2)
        command -nargs=* SearchBuffers :silent call MultipleSearch(1, <q-args>)
    endif

    if !(exists(":Search") == 2)
        command -nargs=* Search :silent call MultipleSearch(0, <q-args>)
    endif

    " Following Manuel's idea, adapt the former 'Super Star' tip from vim.org to work with
    " :Search on a visual selection.
    "vnoremap <silent> <Leader>* y:execute ':Search \V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR>'<CR>
    vnoremap <silent> <Leader>* y:call MultipleSearch(0,'\V'.substitute(escape(@@,"\\/\"'"),"\n",'\\n','ge'))<CR>
else
    " Only autoload the Search commands, since we shouldn't need to use
    " :SearchReset and :SearchReinit until after the first :Search.
    if !(exists(":SearchBuffers") == 2)
        command -nargs=* SearchBuffers :silent call MultipleSearch#MultipleSearch(1, <q-args>)
    endif

    if !(exists(":Search") == 2)
        command -nargs=* Search :silent call MultipleSearch#MultipleSearch(0, <q-args>)
    endif

    " Following Manuel's idea, adapt the former 'Super Star' tip from vim.org to work with
    " :Search on a visual selection.
    vnoremap <silent> <Leader>* y:call MultipleSearch#MultipleSearch(0,'\V'.substitute(escape(@@,"\\/\"'"),"\n",'\\n','ge'))<CR>
endif

" Thanks to Manuel Picaza for the following mapping to :Search the word under
" the cursor.
nnoremap <silent> <Leader>* :execute ':Search \<' . expand('<cword>') . '\>'<cr>

let g:mapleader = ","
map <Leader>/ :Msearch add
map <Leader>L :Msearch list<CR>
map <Leader>NN :Msearch next
map <Leader>P :Msearch previous

"svn-blame shortcut
vmap bl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

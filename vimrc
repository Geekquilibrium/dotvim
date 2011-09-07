" http://github.com/mitechie/pyvim
" ==================================================
" Dependencies
" ==================================================
" Pep8 : http://pypi.python.org/pypi/pep8
" pylint script
" curl - Gist plugin
" python-rope - for ropevim plugin

" ==================================================
" Shortcuts Documented
" ==================================================
" jj - esc
" ,b - bufferlist
" ,v - load .vimrc
" ,V - reload .vimrc
" ,m - run make
" ,M - alt make for filetype (pep8 for python, etc)
" ,y - yank to clipboard
" ,Y - yank current line to clipboard
" ,p - paste from clipboard
" ,q - reformat text paragraph
" ,s - toggle spellcheck
" ,S - remove end of line spaces
" ,c  - open the quickfix window
" ,cc - close the quickfix window
" ,a - toggle nerdtree
" ,r - view registers
" ,t - collapse/fold html tag
"
" Y  - yank to the end of the line
"
" <CR> - create newline with enter key
" C-n  - clear search
" C-l  - Omnicompletion
" C-p  - ctags completion
"
" gc        - comment the highlighted text
" gcc       - comment out the current line
"
" cs"(      - replace the " with (
" ysiw"     - wrap current text object with "
" yss"      - wrap current line with "
" S         - in visual mode surroud with something
" ds(       - remove wrapping ( from text
"
" ,,   - complete snippet
" ,,   - tab to next section of snippet
" ,n   - list available snippets for this filetype
"
" ,pw  - search for keyword in pydocs
" ,pW  - search any pydoc for this keyword
"
" F11  - toggle :set paste on/off
"
" Windows
" alt-jklm - swap to that split without the ctrl-w
" +/-       - shrink the current split horizontal
" alt-,/.   - move the split vertically
" F2        - close current split
"
" :Gist
" :Gist -p (private)
" :Gist XXXX (fetch Gist XXXX and load)
"
" :PG XXXX php - vimgrep the project for XXXX in .php files requird workit
"
" TwitVim
" <F7>/<F8> - load timelines
" :Bpost... - post
" ,g        - load user's timeline
" ,d        - direct message
" ,@        - load the parent to this post
" :IsGd {url} - shorten the url
"
" -----------------------------------------
" Printing:
" set printoptions=paper:A4,syntax:y,wrap:y
" http://vim.runpaint.org/basics/printing/

" bootstrap the pathogen part of the config right away
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Highlight end of line whitespace.
" match WhitespaceEOL /\s\+$/
au InsertEnter * match WhitespaceEOL /\s\+$/
au InsertLeave * match WhitespaceEOL /\s\+$/

" make sure our whitespace matching is setup before we do colorscheme tricks
autocmd ColorScheme * highlight WhitespaceEOL ctermbg=red guibg=red

" now proceed as usual
syntax on                 " syntax highlighing
filetype on               " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype

" In GVIM
if has("gui_running")
set guifont=Liberation\ Mono\ 8" use this font
"set guifont=Monaco\ Regular\ 9
set lines=75          " height = 50 lines
set columns=180       " width = 100 columns
set background=dark  " adapt colors for background
set keymodel=
set mousehide
colorscheme solarized
"colorscheme void

" To set the toolbars toggle (icons on top of the screen)
nnoremap <C-F1> :if &go=~#'m'<BAR>set go-=m<BAR>else<BAR>set go+=m<BAR>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<BAR>set go-=T<BAR>else<BAR>set go+=T<BAR>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<BAR>set go-=r<BAR>else<BAR>set go+=r<BAR>endif<CR>
else
set background=dark   " adapt colors for dark background
colorscheme lucius
set t_Co=256
endif

" ==================================================
" Basic Settings
" ==================================================
let mapleader=","       " change the leader to be a comma vs slash
set textwidth=79        " Try this out to see how textwidth helps
set ch=1                " Make command line two lines high
set ls=2                " allways show status line
set tabstop=4           " numbers of spaces of tab character
set shiftwidth=4        " numbers of spaces to (auto)indent
set scrolloff=3         " keep 3 lines when scrolling
set nocursorline        " have a line indicate the cursor location
set colorcolumn=+2      " 
set cindent             " cindent
set autoindent          " always set autoindenting on
set showcmd             " display incomplete commands
set ruler               " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
"set novisualbell        " turn off visual bell
set nobackup            " do not keep a backup file
set number              " show line numbers
set title               " show title in console title bar
set ttyfast             " smoother changes
set modeline            " last lines in document sets vim mode
set modelines=3         " number lines checked for modelines
set shortmess=atI       " Abbreviate messages
set nostartofline       " don't jump to first character when paging
set backspace=start,indent,eol
set matchpairs+=<:>     " show matching <> (html mainly) as well
set showmatch
set matchtime=3
set spell
set expandtab           " tabs are converted to spaces, use only when required
set sm                  " show matching braces, somewhat annoying...
set hidden

set statusline=[FILE=%{&enc}\|%t\|%{fugitive#statusline()}]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" move freely between files
set whichwrap=b,s,h,l,<,>,[,]

set tags=tags;/         " search for tags file in parent directories

" complete in vim commands with a nice list
set wildmenu
set wildmode=longest,list
set wildignore+=*.pyc

" set the paste toggle key
set pastetoggle=<F11>

" replace the default grep program with ack
set grepprg=ack-grep

" ==================================================
" Config Specific Settings
" ==================================================

" If we're running in vimdiff then tweak out settings a bit
if &diff
set nospell
endif

" ==================================================
" Basic Maps
" ==================================================

" Maps for jj to act as Esc
ino jj <esc>
cno jj <c-c>

" map ctrl-c to something else so I quick using it
map <c-c> <Nop>
imap <c-c> <Nop>

" ,v brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
nmap <leader>v :sp ~/.vimrc<CR><C-W>_
"nmap <silent> <leader>V :source ~/.vimrc <BAR> echo 'Vimrc recarregado!'<CR>

" Run Make with ctrl-m or ,m
map <silent> <leader>m :make<CR>

" quick insertion of a newline
nmap <CR> o<Esc>

" Y yanks to the end of the line
nmap Y y$

" shortcuts for copying to clipboard
nmap <leader>y "*y

" copy the current line to the clipboard
nmap <leader>Y "*yy
nmap <leader>p "*p

" show the registers from things cut/yanked
nmap \r :registers<CR>

" map the various registers to a leader shortcut for pasting from them
nmap <leader>0 "0p
nmap <leader>1 "1p
nmap <leader>2 "2p
nmap <leader>3 "3p
nmap <leader>4 "4p
nmap <leader>5 "5p
nmap <leader>6 "6p
nmap <leader>7 "7p
nmap <leader>8 "8p
nmap <leader>9 "9p

" shortcut to toggle spelling
nmap <leader>s :setlocal spell! spelllang=en_us<CR>

" setup a custom dict for spelling
" zg = add word to dict
" zw = mark word as not spelled correctly (remove)
set spellfile=~/.vim/dict.add

" shortcuts to open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

nmap <leader>l :lopen<CR>
nmap <leader>ll :lclose<CR>
nmap <leader>ln :lN<CR>
nmap <leader>lp :lN<CR>

" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" nnoremap <leader>q gqap

" ==================================================
" Windows / Splits
" ==================================================

" ctrl-jklm  changes to that split
map <a-j> <c-w>j
map <a-k> <c-w>k
map <a-l> <c-w>l
map <a-h> <c-w>h

" Hints for other movements
" <c-w><c-r> rotate window to next spot
" <c-w><c-x> swap window with current one

" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
imap <C-W> <C-O><C-W>

" use - and + to resize horizontal splits
map <a--> <C-W>-
map <a-=> <C-W>+

" and for vsplits with alt-< or alt->
map <M-,> <C-W><
map <M-.> <C-W>>

" F2 close current window (commonly used with my F1/F3 functions)
noremap <f2> <Esc>:close<CR><Esc>

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
if &wrap
  return "g" . a:movement
else
  return a:movement
endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" Split window vertical
nmap <A-v> <C-w>v

" Split window horizontal
nmap <A-s> <C-w>s

" ==================================================
" Search
" ==================================================

" Press Ctrl-N to turn off highlighting.
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set ignorecase          " ignore case when searching
set smartcase           " if searching and search contains upper case, make case sensitive search

nmap <silent> <C-N> :silent noh<CR>

" Search for potentially strange non-ascii characters
map <leader>u :match Error /[\x7f-\xff]/<CR>

" Clean all end of line extra whitespace with ,S
" Credit: voyeg3r https://github.com/mitechie/pyvim/issues/#issue/1
" deletes excess space but maintains the list of jumps unchanged
" for more details see: h keepjumps
fun! CleanExtraSpaces()
let save_cursor = getpos(".")
let old_query = getreg('/')
:%s/\s\+$//e
call setpos('.', save_cursor)
call setreg('/', old_query)
endfun
map <silent><leader>S <esc>:keepjumps call CleanExtraSpaces()<cr>

" ==================================================
" Completion
" ==================================================

" complete on ctrl-l
inoremap <C-l> <C-x><C-o>

set complete+=.
set complete+=k
set complete+=b
set complete+=t

set completeopt+=menuone,longest

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1
let g:SuperTabMidWordCompletion = 1

" ==================================================
" Tab's
" ==================================================
nmap <C-UP> :tabnew<CR>
imap <esc><c-up> :tabnew<CR>
nmap <C-down> :tabclose<CR>
imap <esc><c-down> :tabclose<CR>
nmap <C-right> :tabnext<CR>
imap <esc><c-right> :tabnext<CR>
nmap <C-left> :tabprev<CR>
imap <esc><c-left> :tabprev<CR>

" ==================================================
" Filetypes
" ==================================================

" Auto change the directory to the current file I'm working on
"autocmd BufEnter * lcd %:p:h

" make the smarty .tpl files html files for our purposes
au BufNewFile,BufRead *.tpl set filetype=html
au BufNewFile,BufRead,BufEnter *.mako set filetype=mako

" Filetypes (au = autocmd)
au filetype help set nonumber      " no line numbers when viewing help
au filetype help nnoremap <buffer><cr> <c-]>   " Enter selects subject
au filetype help nnoremap <buffer><bs> <c-T>   " Backspace to go back

"If we're editing a mail message in mutt change to 70 wide and wrap
"without linex numbers
augroup mail
autocmd!
autocmd FileType mail set textwidth=70 wrap nonumber nocursorline
augroup END

" If we're editing a .txt file then skip line numbers
au! BufRead,BufNewFile *.txt set nonu

" automatically give executable permissions if file begins with #! and contains
" '/bin/' in the path
au bufwritepost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile> | endif | endif

" ==================================================
" Python
" ==================================================
au BufReadPost quickfix map <buffer> <silent> <CR> :.cc <CR> :ccl

" au BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
au BufRead *.py compiler nose
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd Filetype python nmap <F9> :!ctags -R --languages=python <return>
autocmd FileType python nmap <leader>r :PyREPLToggle<CR>
autocmd filetype python nmap <silent><C-t> :w<CR>:call <SID>PyRunTests()<CR>
autocmd filetype python imap <silent><C-t> <ESC>:w<CR>:call <SID>PyRunTests()<CR>

" ==================================================
" Javascript
" ==================================================
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen

au BufRead *.js set makeprg=jslint\ %

" ==================================================
" HTML
" ==================================================
" enable a shortcut for tidy using ~/.tidyrc config
map <Leader>T :!tidy -config ~/.tidyrc<cr><cr>

" enable html tag folding with ,f
nnoremap <leader>f Vatzf

" ==================================================
" Ruby
" ==================================================
autocmd Filetype ruby,eruby set ai et sw=2 ts=2 tw=78 sts=2 cc=+2 omnifunc=rubycomplete#Complete
let g:ruby_minlines = 500
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
autocmd Filetype ruby nmap <F9> :!ctags -R --languages=ruby <return>
autocmd FileType ruby nmap <leader>r :RbREPLToggle<CR>

" ==================================================
" PHP
" ==================================================
autocmd Filetype php set ai et sta sw=4 sts=4 tw=86 ts=4 cc=+2 omnifunc=phpcomplete#CompletePHP
autocmd FileType php let php_folding = 1
autocmd FileType php let php_noShortTags = 1
autocmd FileType php let php_parent_error_close = 1
autocmd FileType php let php_parent_error_open = 1
autocmd FileType php let php_large_files = 0
autocmd FileType php let DisableAutoPHPFolding = 1
autocmd FileType php nmap <F6> <ESC>:EnableFastPHPFolds<CR>
"autocmd FileType php nmap <F6> <ESC>:EnablePHPFolds<CR>
autocmd FileType php nmap <F7> <ESC>:DisablePHPFolds<CR>
autocmd Filetype php nmap <F9> :!ctags -R --languages=PHP <return>

" ==================================================
" CoffeeScript
" ==================================================
au BufWritePost *.coffee silent CoffeeMake! -b | cwidow | redraw!
au BufNewFile,BufReadPost *.coffee set ai et sta sw=2 sts=2 tw=80 ts=2 cc=+2
let coffee_make_options = "--bare"

" ==================================================
" SCSS
" ==================================================
au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.less set filetype=less syntax=less ai et sta sw=2 sts=2 tw=86 ts=2 cc=+2

" ==================================================
" Syntax Files
" ==================================================

" xml.vim
" http://github.com/sukima/xmledit/
" % jump between '<' and '>' within the tag
" finish a tag '>'
" press '>' twice it will complete and cursor in the middle

" mako.vim
" http://www.vim.org/scripts/script.php?script_id=2663
" syntax support for mako code

" ==================================================
" Plugins
" ==================================================

" Shell
" https://github.com/xolox/vim-shell.git
let g:shell_mappings_enabled = 0
inoremap <C-F11> <ESC>:Fullscreen<CR>i
nnoremap <C-F11> :Fullscreen<CR>
inoremap <C-F6> <ESC>:Open<CR>i
nnoremap <C-F6> :Open<CR>

" NERDTree
" http://www.vim.org/scripts/script.php?script_id=1658
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
map <leader>a :NERDTreeToggle<CR>
let g:NERDTreeWinPos = 'right'

" Gundo
" http://www.vim.org/scripts/script.php?script_id=3304
nmap \g :GundoToggle<CR>
let g:gundo_right = 1

" CommandT
"nmap \t :CommandT<CR>
"nmap \tt :CommandTFlush<CR>
"let g:CommandTMaxHeight = 10
"let g:CommandTMatchWindowAtTop = 1

" LycosaExplorer
" lf :LycosaFilesystemExplorer<CR>
" lr :LycosaFilesystemExplorerFromHere<CR>
" lb :LycosaBufferExplorer<CR>

" FuzzyFinder
nmap <leader>tf :FufFile<CR>
nmap <leader>tb :FufBuffer<CR>
nmap <leader>td :FufDir<CR>
nmap <leader>tl :FufLine<CR>

" Ack
nmap \a :Ack!

" EasyMotion
let g:EasyMotion_leader_key = '\m'
let g:EasyMotion_mapping_t = '_t'
let g:EasyMotion_mapping_gE = '_gE'

" Solarized
call togglebg#map('<F8>')

" Surround
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<% \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r "
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1

" CakePHP
let g:cakephp_auto_set_project = 1
let g:cakephp_app = "/path/to/cakephp_app/"
nmap \cc :Ccontroller <space>
nmap \cm :Cmodel <space>
nmap \cv :Cview <space>
nmap \cl :Clog <space>

" Ragtag
let g:ragtag_global_maps = 1

" Zencoding
let g:user_zen_expandabbr_key = '<c-e>'
let g:user_zen_complete_tag = 1
let g:user_zen_settings = {
  \ 'php' : {
  \   'extends' : 'html',
  \   'filters' : 'c',
  \ },
  \ 'xml' : {
  \   'extends' : 'html',
  \ },
  \ 'haml' : {
  \   'extends' : 'html',
  \ },
  \ 'erb' : {
  \   'extends' : 'html',
  \ },
  \}

" CheckSyntax
nmap <F5> :CheckSyntax<CR>

" tComment
" http://www.vim.org/scripts/script.php?script_id=1173
" gc        - comment the highlighted text
" gcc       - comment out the current line

" pep8
" http://www.vim.org/scripts/script.php?script_id=2914
autocmd FileType python map <buffer> <leader>M :call Pep8()<CR>


" python folding jpythonfold.vim
" http://www.vim.org/scripts/script.php?script_id=2527
" Setup as ftplugin/python.vim for auto loading

" PyDoc
" http://www.vim.org/scripts/script.php?script_id=910
" Search python docs for the keyword
" <leader>pw - search for docs for what's under cursor
" <leader>pW - search for any docs with this keyword mentioned

" Supertab
" http://www.vim.org/scripts/script.php?script_id=182
" :SuperTabHelp

" SnipMate
" http://www.vim.org/scripts/script.php?script_id=2540
" ,, - complete and tab to next section
" ,n - show list of snippets for this filetype

"bundle/snipmate/after/plugin/snipmate
"source ~/vimfiles/bundle/snipmate/after/plugin/snipMate.vim
ino <silent> <leader>, <c-r>=TriggerSnippet()<cr>
snor <silent> <leader>, <esc>i<right><c-r>=TriggerSnippet()<cr>
ino <silent> <leader>\< <c-r>=BackwardsSnippet()<cr>
snor <silent> <leader>\< <esc>i<right><c-r>=BackwardsSnippet()<cr>
ino <silent> <leader>n <c-r>=ShowAvailableSnips()<cr>

" Surround
" http://www.vim.org/scripts/script.php?script_id=1697
" default shortcuts

" Pyflakes
" http://www.vim.org/scripts/script.php?script_id=3161
" default config for underlines of syntax errors in gvim
let g:pyflakes_use_quickfix = 0

" Gist - github pastbin
" http://www.vim.org/scripts/script.php?script_id=2423
" :Gist
" :Gist -p (private)
" :Gist XXXX (fetch Gist XXXX and load)
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" TwitVim
" http://vim.sourceforge.net/scripts/script.php?script_id=2204
" Twitter/Identica client for vim
" F7/F8 for loading identica/twitter
"source ~/.vim/twitvim.vim

" RopeVim
" http://rope.sourceforge.net/ropevim.html
" Refactoring engine using python-rope
"source /usr/local/ropevim.vim
let ropevim_codeassist_maxfixes=10
let ropevim_vim_completion=1
let ropevim_guess_project=1
let ropevim_enable_autoimport=1
let ropevim_extended_complete=1

" function! CustomCodeAssistInsertMode()
"     call RopeCodeAssistInsertMode()
"     if pumvisible()
"         return "\<C-L>\<Down>"
"     else
"         return ''
"     endif
" endfunction
"
" function! TabWrapperComplete()
"     let cursyn = synID(line('.'), col('.') - 1, 1)
"     if pumvisible()
"         return "\<C-Y>"
"     endif
"     if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$' || cursyn != 0
"         return "\<Tab>"
"     else
"         return "\<C-R>=CustomCodeAssistInsertMode()\<CR>"
"     endif
" endfunction
"
" inoremap <buffer><silent><expr> <C-l> TabWrapperComplete()


" vim-makegreen && vim-nosecompiler
" unit testing python code in during editing
" I use files in the same dir test_xxxx.*
" if we're already on the test_xxx.py file, just rerun current test file
" function MakeArgs()
"     if empty(matchstr(expand('%'), 'test_'))
"     " if no test_ on the filename, then add it to run tests
"     let make_args = 'test_%'
"     else
"     let make_args = '%'
"     endif
"
"     :call MakeGreen(make_args)
" endfunction
"
" autocmd FileType python map <buffer> <leader>t :call MakeArgs()<CR>
"
" ==================================================
" Custom Functions
" ==================================================

" PGrep function to basically do vimgrep within the predefined $PROJ_DIR from
" workit scripts.
" :PG support php -- search the project for /support/j **/*.php
function! PGrep(pattern, ...)
    let pattern = a:pattern

    if a:0 == 0
        let ext = '*'
    else
        let ext = a:1
    endif

    let proj_path = system("echo $PROJ_PATH | tr -d '\n'")
    :exe 'cd '.proj_path

    let search_path = "**/*." . ext

    :execute "vimgrep /" . pattern . "/j " search_path | :copen
endfunction
command! -nargs=* PG :call PGrep(<f-args>)

" javascript folding
function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

" Taken from an IBM DeveloperWorks article on Vim scripting -- prompts for
" creation of nonexistent directories.
augroup AutoMKdir
    autocmd!
    autocmd BufNewFile * :call EnsureDirExists()
augroup END
function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Directory '" . required_dir . "' doesn't exist.", "&Create it?")
        try
            call mkdir( required_dir, 'p' )
        catch
            call AskQuit( "Can't create '" . required_dir . "'", "&Continue anyway?" )
        endtry
    endif
endfunction
function! AskQuit( msg, proposed_action )
    if confirm( a:msg, a:proposed_action . "\n&Quit?" ) == 2
        exit
    endif
endfunction

" " Displays a red or green bar at the bottom of the screen
" function! Bar(type)
"     hi GreenBar guifg=white guibg=green ctermfg=white ctermbg=darkgreen
"     hi RedBar guifg=white guibg=red ctermfg=white ctermbg=darkred
"     if a:type == "red"
"         echohl RedBar
"     else
"         echohl GreenBar
"     endif
"     echon repeat(" ", &columns - 1)
"     echohl None
" endfunc
" 
" " Runs nose on the current file
" function! <SID>PyRunTests()
"     python <<EOF
" import subprocess
" import vim
" 
" filename = vim.eval("expand('%:p')")
" result = subprocess.Popen(["nosetests", filename],
"                           stdout=subprocess.PIPE,
"                           stderr=subprocess.stdout).communicate()[0]
" if result.split("\n")[-2] == "OK":
"     vim.command("execute Bar('green')")
" else:
"     vim.command("execute Bar('red')")
"     print result
" EOF
" endfunc

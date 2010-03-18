" Modeline and Notes {
"   vim: set foldmarker={,} foldlevel=0 :
"
"   my personal .vimrc
"
" }


" Basics {
    set nocompatible " explicitly get out of vi-compatible mode
    set noexrc " don't use local version of .(g)vimrc, .exrc
    let mapleader=","
    set background=dark " we plan to use a dark background
    syntax on " syntax highlighting on
    color desert    
    set guifont=Consolas
" }

" General {
    filetype plugin indent on " load filetype plugins/indent settings
    set nobackup " no backup files
    set backspace=indent,eol,start " make backspace a more flexible
    set clipboard+=unnamed " share windows clipboard
    set hidden " you can change buffers without saving
    "set mouse=a "don't use mouse everywhere
    set noerrorbells " don't make noise
    set wildmenu " turn on command line completion wild style
    " ignore these list file extensions
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
                    \*.jpg,*.gif,*.png
    set wildmode=list:longest " turn on wild mode huge list
    set autowrite
" }

" Vim UI {
    set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you search phrase
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set nohlsearch " do not highlight searched for phrases    
    function ToggleHLSearch()
    	if &hls
    		set nohls
    	else
    		set hls
    	endif
    endfunction
    nmap <leader>h <Esc>:call ToggleHLSearch()<CR>
    
    set nostartofline " leave my cursor where it was
    set number " turn on line numbers
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess+=I "disable startup message
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    function! CurDir()
	    let curdir=substitute(getcwd(), '/home/dccmx/', "~/", "g")
	    return curdir
    endfunction
    set statusline=%F%m%r%h%w\ [CWD=%{CurDir()}]\ %{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" }

" Text Formatting/Layout {
    set completeopt=longest,menu
    set expandtab " no real tabs please!
    autocmd FileType * set formatoptions-=ro
    set ignorecase " case insensitive by default
    set nowrap " do not wrap line
    set autoindent
    set cindent
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase " if there are caps, go case-sensitive
    set shiftwidth=4 " auto-indent amount when using cindent, 
                      " >>, << and stuff like that
    set softtabstop=4 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set tabstop=4 " real tabs should be 8, and they will show with  set list on
" }


" Folding {
    set foldenable " Turn on folding
    set foldmethod=syntax " Fold on the marker
    set foldlevel=100 " Don't autofold anything (but I can still fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds 
    function SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText() " Custom fold text function (cleaner than default)
" }

" Plugin Settings {

    " TagList Settings {
        let Tlist_Auto_Open=0 " let the tag list open automagically
        let Tlist_Compact_Format = 1 " show small menu
        let Tlist_Ctags_Cmd = 'ctags' " location of ctags
        let Tlist_Enable_Fold_Column = 0 " do show folding tree
        let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
        let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
        let Tlist_Sort_Type = "name" " order by 
        let Tlist_Use_Right_Window = 1 " split to the right side of the screen
        let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always) read my functions
        let Tlist_Close_On_Select=1
        let Tlist_Show_One_File=1
        let Tlist_GainFocus_On_ToggleOpen=1
        " Language Specifics {
            " just functions and classes please
            let tlist_aspjscript_settings = 'asp;f:function;c:class' 
            " just functions and subs please
            let tlist_aspvbs_settings = 'asp;f:function;s:sub' 
            " don't show variables in freaking php
            let tlist_php_settings = 'php;c:class;d:constant;f:function' 
            " just functions and classes please
            let tlist_vb_settings = 'asp;f:function;c:class' 
        " }
    " }
    
	" tabbar Settings {
	    let g:Tb_ForceSyntaxEnable=1
        let g:Tb_MaxSize=2
        let g:Tb_TabWrap=1
        map <C-F4> <ESC>:call CloseTab()<CR>
        func! CloseTab()
            let s:buf_nr = bufnr("%")
            echo s:buf_nr
            exec ":Tbbp "
            exec ":bdelete ".s:buf_nr
        endfunction
        autocmd! BufEnter * nested call Test()
        func! Test()
            if bufname("%") == "-TabBar-"
                wincmd j " 跳到下面的視窗
            endif
        endfunction
	"}

	"yank ring
	map <leader>y :YRShow<CR>
	let g:yankring_history_dir = '$HOME/.vim/'
	let g:yankring_history_file = '.yankring_history'

	""""""""""""""""""""""""""""
	"NERD tree
	""""""""""""""""""""""""""""
	let NERDChristmasTree=1
	let NERDTreeAutoCenter=1
	let NERDTreeBookmarksFile=$VIM.'\Data\NerdBookmarks.txt'
	let NERDTreeMouseMode=2
	let NERDTreeShowBookmarks=1
	let NERDTreeShowFiles=1
	let NERDTreeShowHidden=0
	let NERDTreeShowLineNumbers=1
	let NERDTreeQuitOnOpen=1
	let NERDTreeWinSize=31
	let NERDTreeHighlightCursorline=1
	let NERDTreeWinPos="right"
	nmap <leader>f :NERDTreeToggle<CR>

    "NERD_Comment{
        let NERDCommentWholeLinesInVMode=1
    "}


	"ctags{
	    set tags=./tags,tags,../tags,../../tags
        cs add ./cscope.out ./
        set tags+=/usr/include/c++/tags
        cs add usr/include/c++/cscope.out /usr/include/c++
        set tags+=/usr/include/linux/tags
        cs add /usr/include/linux/cscope.out /usr/include/linux
    "}


	""""""""""""""""""""""""""""
	"cscope 
	""""""""""""""""""""""""""""
	set cscopequickfix=g-,s-,c-,d-,i-,t-,e-

	"let OmniCpp_DefaultNamespaces = ["std"]
	"let OmniCpp_GlobalScopeSearch = 1 " 0 or 1
	"let OmniCpp_NamespaceSearch = 1 " 0 , 1 or 2
	"let OmniCpp_DisplayMode = 1
	"let OmniCpp_ShowScopeInAbbr = 0
	"let OmniCpp_ShowPrototypeInAbbr = 1
	"let OmniCpp_ShowAccess = 1
	"let OmniCpp_MayCompleteDot = 1
	"let OmniCpp_MayCompleteArrow = 1
	"let OmniCpp_MayCompleteScope = 1

" }


" Mappings {
    " Make p in Visual mode replace the selected text with the "" register.
    vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

    " Make Arrow Keys Useful Again {
        map <down> <ESC>:NERDTreeToggle<RETURN>
        map <up> <ESC>:Tlist<RETURN>
        map <right> <ESC>:bn!<CR>
        map <left> <ESC>:bp!<CR>
        map <space> <ESC>:b#<CR>
        map <leader>bd <ESC>:bd<CR>
    " }
    nmap <leader>a <Esc>:A!<CR>
    nnoremap <silent> <F3> :Grep<CR> 
	nmap <leader>qw :cw<CR>
	nmap <leader>qn :cn<CR>
	nmap <leader>qp :cp<CR>
	nmap <leader>qc :cclose<CR>
	nmap <leader>s :w<CR>
	nmap <leader>x <Esc>:q<CR>
	nmap <leader>qa :qall<CR>
	nmap <leader><space> :make<CR>

	func! CloseTab()
		let s:buf_nr = bufnr("%")
		echo s:buf_nr
		exec ":Tbbp "
		exec ":bdelete ".s:buf_nr
	endfunction
	map <F9> <ESC>:call CloseTab()<CR>



	""""""""""""""""""""""""""""
	"Window Switch
	""""""""""""""""""""""""""""
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-h> <C-w>h
	noremap <C-l> <C-w>l

	noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm10gt "Remove the Windows ^M

	map <leader>cd :cd %:p:h<CR> "Switch to current dir

	map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f "%:p:h\\tags" "%:p:h"<CR>
	map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
	map <F11> :!cscope -Rbkq<CR>

	nmap <C-t> :colder<CR>:cc<CR>

	nmap <C-_>s :cs find s <C-r>=expand("<cword>")<CR><CR> 
	nmap <C-_>g :cs find g <C-r>=expand("<cword>")<CR><CR> 
	nmap <C-_>c :cs find c <C-r>=expand("<cword>")<CR><CR> 
	nmap <C-_>t :cs find t <C-r>=expand("<cword>")<CR><CR> 
	nmap <C-_>e :cs find e <C-r>=expand("<cword>")<CR><CR> 
	nmap <C-_>f :cs find f <C-r>=expand("<cfile>")<CR><CR> 
	nmap <C-_>i :cs find i ^<C-r>=expand("<cfile>")<CR>$<CR> 
	nmap <C-_>d :cs find d <C-r>=expand("<cword>")<CR><CR>

" }


if has("gui_running")

    set guifont=Consolas
    "把gui的右边的滑动条去掉
    "set guioptions-=r
    "把gui的左边的滑动条去掉
    "set guioptions-=L
    set guioptions-=m
    set guioptions-=T
    au GUIEnter * simalt ~x "启动时最大化窗口

endif

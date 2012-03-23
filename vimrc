source ~/.vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins
set gfn=Monospace\ 8
set bs=2
set background=dark
colorscheme mine
set incsearch
set ignorecase
set smartcase
set laststatus=2
set statusline=%<%f\ %y\[%{&ff}\]\ \ %h%m%r%=%-14.(%l,%c%V%)\ %P
set expandtab
set foldlevel=1000
set foldcolumn=4
set foldmethod=syntax
set title
set hlsearch
set gdefault
set nohidden
set equalalways
set eadirection=ver
set shiftwidth=2
set expandtab
set scrolloff=2
set showtabline=2

set helpheight=40

set diffopt+=vertical,iwhite

" only accept unix file format
set fileformats=unix

" vim-latex requires this
set grepprg=grep\ -nH\ $*
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash
let g:Tex_DefaultTargetFormat = 'pdf'

" AUTO-PST-PDF needs this
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode --shell-escape $*'

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
	" Clear old autocmds in group
	autocmd!
	" autoindent with two spaces, always expand tabs
	autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

:let ruby_operators = 1
:let ruby_space_errors = 1
:let ruby_fold = 1

"   Edit another file in the same directory as the current file
"   uses expression to extract path from current file's path
"  (thanks Douglas Potts)
" if has("unix")
" 	map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
"else
"	map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
"endif

" Delete trailing spaces and replace Tabs with 2 Spaces
command! FixTrailingSpaces :let _s=@/<Bar>:%s/\s*\r\?$//e<Bar>:%s/\t/  /e<Bar>:let @/=_s<Bar>:nohl

" tex.vim options
let g:tex_fold_enabled=1

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" make ä ö ü with "a and so on
" imap "a ä
" imap "o ö
" imap "u ü
" imap "A Ä
" imap "O Ö
" imap "U Ü

" map <F8> to write and execute make
nmap <F8> :w<CR> :make!<CR>

" map <F2> to execute rspec test
nmap <F2> :exec ':!ruby script/spec % -X -fs -l' line(".")<CR>

" map <Caps Lock> to <Esc> (<Caps Lock needs to be mapped to <Help> first see
" http://www.macosxhints.com/article.php?story=20060825072451882)
" map <Help> <Esc>
" map! <Help> <Esc>

" make ` execute the contents of the a register
nnoremap ` @a

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" same for the just defined `
vnoremap ` :normal @a<CR>

" Latex folding for customized enviroments
let g:Tex_FoldedEnvironments = ',XML,quote,lstlisting' 

" This mapping allow you to quickly scroll inactive window when displaying several windows concurrently.

nmap <silent> <M-Down> :call ScrollOtherWindow("down")<CR>
nmap <silent> <M-Up> :call ScrollOtherWindow("up")<CR>
nmap <silent> <M-j> :call ScrollOtherWindow("down")<CR>
nmap <silent> <M-k> :call ScrollOtherWindow("up")<CR>

fun! ScrollOtherWindow(dir)
	if a:dir == "down"
		let move = "\<C-E>"
	elseif a:dir == "up"
		let move = "\<C-Y>"
	endif
	exec "normal \<C-W>p" . move . "\<C-W>p"
endfun

" just like windo but restores the current window when it's done
function! WinDo(command)
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" just like bufdo but restores the current buffer when it's done
function! BufDo(command)
 let currBuff=bufnr("%")
 execute 'bufdo ' . a:command
 execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

" see VimTip 159: Keystroke Saving Substituting and Searching

map <F4> :%s//<Left>
map <S-F4> :%s/<C-r><C-w>//<Left>
vmap / y:execute "/".escape(@",'[]/\.*')<CR>
vmap <F4> y:execute "%s/".escape(@",'[]/\')."//"<Left><Left>

" Mark all tabs as error
syn match TAB_CHAR "\t"
hi link TAB_CHAR Error

" VimTip 271: easy (un)commenting out of source code
" Something that I do quite alot is comment out blocks of text, only to uncomment that same block later. The following mappings have proven useful to me. They can be applied using visually selected blocks, or with motion keys.

" lhs comments
"map ,# :s/^/#/<CR>
"map ,/ :s/^/\/\//<CR>
"map ,> :s/^/> /<CR>
"map ," :s/^/\"/<CR>
"map ,% :s/^/%/<CR>
"map ,! :s/^/!/<CR>
"map ,; :s/^/;/<CR>
"map ,- :s/^/--/<CR>
"map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>

" wrapping comments
"map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>
"map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>
"map ,< :s/^\(.*\)$/<!-- \1 -->/<CR>
"map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>

noremap <silent> ,# :call CommentLineToEnd('# ')<CR>+
noremap <silent> ;# :call CommentLineToEnd('### ')<CR>+
noremap <silent> ,/ :call CommentLineToEnd('// ')<CR>+
noremap <silent> ," :call CommentLineToEnd('" ')<CR>+
noremap <silent> ,; :call CommentLineToEnd('; ')<CR>+
noremap <silent> ,- :call CommentLineToEnd('-- ')<CR>+
noremap <silent> ,* :call CommentLinePincer('/* ', ' */')<CR>+
noremap <silent> ,< :call CommentLinePincer('<!-- ', ' -->')<CR>+

set encoding=utf-8

" surround plugin
let b:surround_indent = 1

" http://vim.wikia.com/wiki/Auto_closing_an_HTML_tag  (does not work right
" now)
:iabbrev </ </<C-X><C-O>

" change tabs with <C-Left> and <C-Right>
map <C-Left> :tabprev
map <C-Right> :tabnext

let rails_ctags_arguments = "--exclude=\"*.js\" --exclude=tmp"

autocmd FileType eruby let b:surround_71 = "<%= _(\"\r\") %>"
autocmd FileType eruby let b:surround_103 = "_(\r)"
autocmd FileType ruby let b:surround_103 = "_(\r)"

set complete=.,w,t,i

let NERDTreeShowBookmarks = 1
let NERDTreeChDirMode     = 2

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
au BufRead,BufNewFile *.rabl setf ruby

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" rchh
set wildmenu
nnoremap <F5> :GundoToggle<CR>

" Show invisibles.
nmap <leader>l :set list!<CR>
set list
set listchars=tab:▸-,trail:•

" Use ack for searches in nertree (see NERD_tree_ACK)
let g:path_to_search_app = "ack"

" Disable toolbar
set guioptions-=T

" Add this type definition to your vimrc
" or do
" coffeetags --vim-conf >> <PATH TO YOUR VIMRC>
" if you want your tags to include vars/objects do:
" coffeetags --vim-conf --include-vars
 let g:tagbar_type_coffee = {
  \ 'kinds' : [
  \   'f:functions',
  \   'o:object'
  \ ],
  \ 'kind2scope' : {
  \  'f' : 'object',
  \   'o' : 'object'
  \},
  \ 'sro' : ".",
  \ 'ctagsbin' : 'coffeetags',
  \ 'ctagsargs' : '--include-vars ',
  \}

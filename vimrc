let g:mxml_syntax_folding = 1

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

" Delete trailing spaces
command! FixTrailingSpaces :let _s=@/<Bar>:%s/\s*\r\?$//e<Bar>:let @/=_s<Bar>:nohl

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
nmap <silent> <D-Down> :call ScrollOtherWindow("down")<CR>
nmap <silent> <D-Up> :call ScrollOtherWindow("up")<CR>
nmap <silent> <D-j> :call ScrollOtherWindow("down")<CR>
nmap <silent> <D-k> :call ScrollOtherWindow("up")<CR>

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
  \" ViM autocommands for binary plist files

" Copyright (C) 2005 Moritz Heckscher
"
" Note: When a file changes externally and you answer no to vim's question if
" you want to write anyway, the autocommands (e.g. for BufWritePost) are still
" executed, it seems, which could have some unwanted side effects.
"
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 2 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
augroup plist
  " Delete existing commands (avoid problems if this file is sourced twice)
  autocmd!

  " Set binary mode (needs to be set _before_ reading binary files to avoid
  " breaking lines etc; since setting this for normal plist files doesn't
  " hurt and it's not yet known whether or not the file to be read is stored
  " in binary format, set the option in any case to be sure).
  " Do it before editing a file in a new buffer and before reading a file
  " into in an existing buffer (using ':read foo.plist').
  autocmd BufReadPre,FileReadPre *.plist set binary

  " Define a little function to convert binary files if necessary...
  fun MyBinaryPlistReadPost()
          " Check if the first line just read in indicates a binary plist
          if getline("'[") =~ "^bplist"
                  " Filter lines read into buffer (convert to XML with plutil)
                  '[,']!plutil -convert xml1 /dev/stdin -o /dev/stdout
                  " Many people seem to want to save files originally stored
                  " in binary format as such after editing, so memorize format.
                  let b:saveAsBinaryPlist = 1
          endif
          " Yeah, plain text (finally or all the way through, either way...)!
          set nobinary
          " Trigger file type detection to get syntax coloring etc. according
          " to file contents (alternative: 'setfiletype xml' to force xml).
          filetype detect
  endfun
  " ... and call it just after editing a file in a new buffer...
  autocmd BufReadPost *.plist call MyBinaryPlistReadPost()
  " ... or when reading a file into an existing buffer (in that case, don't
  " save as binary later on).
  autocmd FileReadPost *.plist call MyBinaryPlistReadPost() | let b:saveAsBinaryPlist = 0

  " Define and use functions for conversion back to binary format
  fun MyBinaryPlistWritePre()
          if exists("b:saveAsBinaryPlist") && b:saveAsBinaryPlist
                  " Must set binary mode before conversion (for EOL settings)
                  set binary
                  " Convert buffer lines to be written to binary
                  silent '[,']!plutil -convert binary1 /dev/stdin -o /dev/stdout
                  " If there was a problem, e.g. when the file contains syntax
                  " errors, undo the conversion and go back to nobinary so the
                  " file will be saved in text format.
                  if v:shell_error | undo | set nobinary | endif
          endif
  endfun
  autocmd BufWritePre,FileWritePre *.plist call MyBinaryPlistWritePre()
  fun MyBinaryPlistWritePost()
          " If file was to be written in binary format and there was no error
          " doing the conversion, ...
          if exists("b:saveAsBinaryPlist") && b:saveAsBinaryPlist && !v:shell_error
                  " ... undo the conversion and go back to nobinary so the
                  " lines are shown as text again in vim.
                  undo
                  set nobinary
          endif
  endfun
  autocmd BufWritePost,FileWritePost *.plist call MyBinaryPlistWritePost()
augroup END}

" Math operations
noremap <kMinus> <C-X>
vnoremap <silent><kMinus> :<C-U>'<,'>s%\(-\?\d\+\)%\=submatch(1) - v:count1%g<CR>:noh<CR>gv
noremap <kPlus> <C-A>
vnoremap <silent><kPlus> :<C-U>'<,'>s%\(-\?\d\+\)%\=submatch(1) + v:count1%g<CR>:noh<CR>gv
noremap <silent><kMultiply> :<C-U>s%\(-\?\d*\%#\d\+\)%\=submatch(1) * v:count1%<CR><C-O>h/\d\+/e<CR>:noh<CR>
vnoremap <silent><kMultiply> :<C-U>'<,'>s%\(-\?\d\+\)%\=submatch(1) * v:count1%g<CR>:noh<CR>gv
noremap <silent><kDivide> :<C-U>s%\(-\?\d*\%#\d\+\)%\=submatch(1) / v:count1%<CR><C-O> ?\d\+?e<CR>:noh<CR>
vnoremap <silent><kDivide> :<C-U>'<,'>s%\(-\?\d\+\)%\=submatch(1) / v:count1%g<CR>:noh<CR>gv

" Camelize and undersore lines
" Haven't found a solution to use only parts of a line or visual blocks
command! -range Camelize <line1>,<line2>s#_\(\l\)#\u\1#
command! -range Underscore <line1>,<line2>s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#

" tags for actionscript
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'

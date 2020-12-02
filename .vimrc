" make vim recognize files of various types for type specific stuff
:filetype on
" all files can be smartindented
:set smartindent
" but files with a C-like syntax are cindented
:autocmd FileType c,cpp,h,java :set cindent
" add pathogen
execute pathogen#infect()
filetype plugin indent on
" do syntax highlighting
:syntax on

" show line number, since this simplifies G-jumping
:set number

" no tabs for indentation, and indent should be 4 spaces
:set expandtab
:set tabstop=2
:set shiftwidth=2


set t_Co=256

" create file~ backups
:set backup

" highlight the cursor line, so that one sees where one is about to type
:set cursorline
":hi CursorLine cterm=NONE ctermbg=cyan ctermfg=black guibg=cyan guifg=black

" show a status line with 
"   t: file name
"   y: file type
"   ff: format (DOS/Unix/...)
"   l,c: line and column number
"   r: read-only status
:set laststatus=2
:set statusline=%t\ %y\ %{&ff}\ (%l,%c)\ %r

" make sure views are auto-saved/loaded so that folds are preserved
" between edit sessions
"au BufWinLeave ?* mkview
"au BufWinEnter ?* silent loadview

" set color scheme
" :colorscheme wombat
" :colorscheme desert
:colorscheme sublimemonokai
syntax enable
":let g:solarized_termcolors=256
":set background=dark
":colorscheme solarized

" make sure some lines above or below current line are visible at all times
:set scrolloff=5

" Search ignores case if only lower case letters are used
:set ignorecase
:set smartcase

" enable vim airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"
"" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"let g:UltiSnipsExpandTrigger = "<nop>"
"let g:ulti_expand_or_jump_res = 0
"function ExpandSnippetOrCarriageReturn()
"    let snippet = UltiSnips#ExpandSnippetOrJump()
"    if g:ulti_expand_or_jump_res > 0
"        return snippet
"    else
"        return "\<CR>"
"    endif
"endfunction
"inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"
"
"g:UltiSnipsExpandTrigger = "<return>"

" g:UltiSnipsJumpForwardTrigger
" g:UltiSnipsJumpBackwardTrigger

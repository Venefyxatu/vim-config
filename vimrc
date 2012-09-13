set tw=0
set nocompatible
set autoindent
set cindent
set syntax=on
set tabstop=4
set shiftwidth=4
set expandtab
set noerrorbells
set number
set nobackup
let NERDTreeWinSize=46
let mapleader="\\"

if version >= 703
   map <Leader>n :if &number <Bar>
               \set relativenumber <Bar>
               \else <Bar>
               \set number <Bar>
               \endif <cr>
endif
set ruler

call pathogen#infect()
call pathogen#helptags()

" Begin python-mode settings


" End python-mode settings
filetype plugin indent on


:imap <Esc>Oq 1
:imap <Esc>Or 2
:imap <Esc>Os 3
:imap <Esc>Ot 4
:imap <Esc>Ou 5
:imap <Esc>Ov 6
:imap <Esc>Ow 7
:imap <Esc>Ox 8
:imap <Esc>Oy 9
:imap <Esc>Op 0
:imap <Esc>On .
:imap <Esc>OQ /
:imap <Esc>OR *
:imap <Esc>Ol +
:imap <Esc>OS -

set showmode

highlight ModeMsg guibg=blue guifg=green gui=NONE cterm=NONE term=NONE

au! BufNewFile,BufRead *.gob set filetype=cpp
au! BufNewFile,BufRead *.dbk set filetype=xml
filetype on
set ai
set showmatch

set wildignore=*.o,*.obj,*.class,*~,.bak

"if has('gui')
"        copen 5
"endif

set foldmethod=indent
set foldlevel=0
set foldcolumn=1

let &cdpath=','.expand("$HOME")

noremap <space> <C-f>

let Tlist_Use_Right_Window=1
if has('gui')
        let Tlist_Auto_Open=1
endif
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=1
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 0


iab teh the
iab seperate separate
iab probalem problem

fun! LoadColourScheme(schemes)
    let l:schemes = a:schemes . ":"
    while l:schemes != ""
        let l:scheme = strpart(l:schemes, 0, stridx(l:schemes, ":"))
        let l:schemes = strpart(l:schemes, stridx(l:schemes, ":") + 1)
        try
            exec "colorscheme" l:scheme
            break
        catch
        endtry
    endwhile
endfun

if has('gui')
    call LoadColourScheme("delek:elflord:biogoo:inkpot:night:rainbow_night:darkblue")
    copen 5
else
    if &t_Co == 88 || &t_Co == 256
        call LoadColourScheme("delek:elflord:biogoo:inkpot:darkblue:")
    else
        call LoadColourScheme("delek:elflord:biogoo:darkblue:")
    endif
endif

if has("autocmd")
    filetype plugin indent on
endif

"map <C-R> :exe GnomeDoc()<CR>

set autowrite
set incsearch
set showmatch

set nofoldenable
set foldmethod=indent
set autoread
set backupext=.bak


set grepprg=grep\ -nH\ $*

let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4

let &guicursor = &guicursor . ",a:blinkon0"

autocmd BufRead,BufNewFile *.py,*.rscript syntax on
autocmd BufRead,BufNewFile *.py,*.rcscript set ai
autocmd BufRead,BufNewFile *.rscript,*.py,*sh set tabstop=4 expandtab shiftwidth=4
autocmd BufRead,BufNewFile *.lua set tabstop=2 expandtab shiftwidth=2 

noremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <F8> :TlistToggle<CR>

noremap <silent> <F9> :TMiniBufExplorer<CR>
noremap <silent> <F10> :cal VimCommanderToggle()<CR>
nnoremap <silent> <F11> :YRShow<CR>

let basedir = "/DATA/projects"
let domain = "be.venefyxatu.palm."
let appversion = "1.0.0"

function GenerateScene(basedir, project, name)
    exe '!palm-generate -t new_scene -p "name=' . a:name . '" ' . a:basedir . '/' . a:project
endfunction

command -nargs=+ Newscene call GenerateScene(basedir, <f-args>)

function Testrun(basedir, domain, appversion, project)
    call PackageApp(a:basedir, a:project)
    call InstallApp(a:domain, a:project, a:appversion)
    call LaunchApp(a:domain, a:project)
endfunction

function PackageApp(basedir, project)
    silent exe '!palm-package ' . a:basedir . '/' . a:project 
endfunction

function InstallApp(domain, project, appversion)
    silent exe '!palm-install ' . a:domain . a:project . '_' . a:appversion . '_all.ipk' 
endfunction

function LaunchApp(domain, project)
    silent exe '!palm-launch ' . a:domain . a:project 
endfunction

function RemoveApp(basedir, domain, appversion, project)
    silent exe '!palm-install -r ' . a:domain . a:project
    silent exe '!rm -f ' . a:basedir . '/' . a:project . '/' . a:domain . a:project . '_' . a:appversion . '_all.ipk'
endfunction

command -nargs=1 Testrun call Testrun(basedir, domain, appversion, <f-args>)
command -nargs=1 Cleanup call RemoveApp(basedir, domain, appversion, <f-args>)

set tw=0



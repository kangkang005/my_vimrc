" #################################################
" ############### No-Plug Vimrc ###################
" #################################################
" reference: chenxuan520/vim-fast

" @Highlight {{{
highlight User1 font=#000000 guifg=#1a1b26 guibg=#9ECE6A
highlight User2 font=#000000 guifg=#9ECE6A guibg=#232433
highlight User3 font=#000000 guifg=#1a1b26 guibg=#9ECE6A
highlight User4 font=#000000 guifg=#9ECE6A guibg=#232433
highlight User5 font=#000000 guifg=#1a1b26 guibg=#7AA2F7
highlight User6 font=#000000 guifg=#7AA2F7 guibg=#232433
" @Highlight }}}

" @General {{{
let mapleader = " "
set nocompatible
filetype on
filetype plugin on
set noeb
syntax enable
syntax on
set t_Co=256
set vb t_vb=
set cmdheight=1
set showcmd
set textwidth=0
set ruler
set laststatus=2
set number
" set relativenumber
set cursorline
set whichwrap+=<,>,h,l
set ttimeoutlen=0
set virtualedit=block,onemore
set noshowmode
set hidden
set matchpairs+=<:>     " add <> match pairs
" set background=dark
" set jumpoptions=stack
" @General }}}

" @Indent, Tab and Style {{{
set autoindent
set cindent
set cinoptions=g0,:0,N-s,(0
set smartindent
filetype indent on
" set noexpandtab       " not allow tab to whitespace
set expandtab           " tab to whitespace
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set nowrap
set backspace=2
set sidescroll=10
set nofoldenable
set list lcs=tab:¦\ 
set sidescroll=0
set sidescrolloff=4
" set scrolloff=5
" @Indent, Tab and Style }}}

" @Completion {{{
set wildmenu
set completeopt=menuone,preview,noselect
set omnifunc=syntaxcomplete#Complete
set shortmess+=c
set cpt+=kspell
" @Completion }}}

" @Search {{{
set hlsearch
set incsearch
set ignorecase
set smartcase
" @Search }}}

" @Cache {{{
set nobackup
set noswapfile
set autoread
set autowrite
set confirm
" @Cache }}}

" @Encode {{{
set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
" @Encode }}}

" @Buffer {{{
" reload .vimrc
nnoremap <leader><leader>s :source $MYVIMRC<cr>
nnoremap <leader><leader>S :source <c-r>=expand('%:p')<cr><cr>

" cursor movement at insert mode
imap <c-j> <down>
imap <c-k> <up>
imap <c-l> <right>
imap <c-h> <left>

inoremap <c-w> <c-o>W
inoremap <c-b> <c-o>B

" super movement
noremap H ^
noremap L $

" set tab indent
xnoremap <tab>   >gv
xnoremap <s-tab> <gv

" map enter
func! s:iSuperEnter()
	let ch=getline('.')[col('.')-1]|let last=getline('.')[col('.')-2]
	if ch=='}'&&last=='{'
		let str=matchstr(getline('.'),"^\\s*")
		call append(line('.'),str.ch)
		return "\<del>\<cr>"
	endif
	return "\<cr>"
endfunc
inoremap <silent><cr> <c-r>=<sid>iSuperEnter()<cr>

func! s:Judge(ch,mode)
	if a:mode!='c'
		let ch=getline('.')[col('.')-1]
	else
		let ch=getcmdline()[getcmdpos()-1]
	endif
	if a:ch=='"'||a:ch=="'"||a:ch=='`'
		if ch!=a:ch
			return a:ch.a:ch."\<left>"
		endif
	endif
	if ch==a:ch
		return "\<right>"
	endif
	return a:ch
endfunc
inoremap <expr><silent>" <sid>Judge('"','i')
inoremap <expr><silent>` <sid>Judge('`','i')
inoremap <expr><silent>' <sid>Judge("'",'i')
inoremap <expr><silent>> <sid>Judge('>','i')
inoremap <expr><silent>) <sid>Judge(')','i')
inoremap <expr><silent>} <sid>Judge('}','i')
inoremap <expr><silent>] <sid>Judge(']','i')
cnoremap <expr>" <sid>Judge('"','c')
cnoremap <expr>` <sid>Judge('`','c')
cnoremap <expr>' <sid>Judge("'",'c')
cnoremap <expr>> <sid>Judge('>','c')
cnoremap <expr>) <sid>Judge(')','c')
cnoremap <expr>} <sid>Judge('}','c')
cnoremap <expr>] <sid>Judge(']','c')

" languages setting
augroup languages
	au!
	autocmd! BufWritePost *.sh,*.py call setfperm(expand('%'),'rwxrwxr-x')
	autocmd BufNewFile *.sh call append(line(".")-1,'#!/bin/bash')
	autocmd BufNewFile *.py call append(line(".")-1,'#!/usr/bin/env python3')
augroup END

" select search in visual mode
xmap g/ "sy/\V<c-r>=@s<cr>
" @Buffer }}}

" @Slash {{{
func! s:SlashCb()
	if g:slash_able
		set nohlsearch|autocmd! slash
	else
		set hlsearch|let g:slash_able=1
	endif
endf
func! s:Slash(oper)
	augroup slash
		autocmd!
		autocmd CursorMoved,CursorMovedI * call <sid>SlashCb()
	augroup END
	let g:slash_able=0
	return a:oper."zz"
endf
nnoremap <silent><expr>n <sid>Slash('n')
nnoremap <silent><expr>N <sid>Slash('N')
xnoremap <silent>* "sy:let @/="\\V".@s<cr>:set hlsearch<cr>
xnoremap <silent># "sy:let @/="\\V".@s<cr>:let v:searchforward=0<cr>:set hlsearch<cr>
nnoremap <silent>* :let @/="\\<".expand('<cword>')."\\>"<cr>:set hlsearch<cr>
nnoremap <silent># :let @/="\\<".expand('<cword>')."\\>"<cr>:let v:searchforward=0<cr>:set hlsearch<cr>
xnoremap <silent>g8 "sy:let @/="\\V".@s<cr>:set hlsearch<cr>
nnoremap <silent>g8 :let @/="\\<".expand('<cword>')."\\>"<cr>:set hlsearch<cr>
" @Slash }}}

" @Completion {{{
inoremap <silent><expr>/ complete_info(["selected"])["selected"]!=-1&&getline(line('.'))[col('.')-2]=='/'?
			\ "\<bs>/\<c-x>\<c-f>":
			\ "/\<c-x>\<c-f>"
let g:cmpX=-1|let g:cmpY=-1
function! s:feed_popup()
	if getline('.')[col('.')-1]=='/'|return|endif
	let x = col('.') - 1|let y = line('.') - 1
	if g:cmpX==x&&g:cmpY==y|return|endif
	let s:min_complete=2
	let s:context=strpart(getline('.'), 0, col('.') - 1)
	let s:match= matchlist(s:context, '\(\k\{' . s:min_complete . ',}\)$')
	if empty(s:match)|return|endif
	silent! call feedkeys("\<c-n>", 'n')
	let g:cmpX=x|let g:cmpY=y
	return
endfunction
augroup Complete
	au!
	au CursorMovedI * nested call s:feed_popup()
	au FileType text setlocal spell|setlocal nospell
augroup END
inoremap <silent><expr><TAB>
			\ pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" @Completion }}}

" @Commentary {{{
func! s:Commentary(line) abort
	let s:num=a:line
	let line=getline(s:num)
	let uncomment=2
	let [l, r] = split( substitute(substitute(substitute(
				\ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', ''), '%s', 1)
	let line = matchstr(getline(s:num),'\S.*\s\@<!')
	if l[-1:] ==# ' ' && stridx(line,l) == -1 && stridx(line,l[0:-2]) == 0|let l = l[:-2]|endif
	if r[0] ==# ' ' && line[-strlen(r):] != r && line[1-strlen(r):] == r[1:]|let r = r[1:]|endif
	if len(line) && (stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)|let uncomment = 0|endif
	let line=getline(s:num)
	let [l, r] = split( substitute(substitute(substitute(
				\ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', ''), '%s', 1)
	if strlen(r) > 2 && l.r !~# '\\'
		let line = substitute(line,
					\'\M' . substitute(l, '\ze\S\s*$', '\\zs\\d\\*\\ze', '') . '\|' . substitute(r, '\S\zs', '\\zs\\d\\*\\ze', ''),
					\'\=substitute(submatch(0)+1-uncomment,"^0$\\|^-\\d*$","","")','g')
	endif
	if uncomment
		let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
	else
		let line = substitute(line,'^\%('.matchstr(getline(s:num),'^\s*').'\|\s*\)\zs.*\S\@<=','\=l.submatch(0).r','')
	endif
	call setline(s:num,line)
endfunc
" visual gcc
func! s:VisualComment() abort
	for temp in range(min([line('.'),line('v')]),max([line('.'),line('v')]))
		call s:Commentary(temp)
	endfor
endfunc
nnoremap <silent><nowait>gcc :call <sid>Commentary(line('.'))<cr>
xnoremap <silent><nowait>gc  :call <sid>VisualComment()<cr>
" @Commentary }}}

" @Statusline {{{
function! GetMode()
	let m = mode()|let s:str=''|let s:color='#9ECE6A'
	if m == 'R'|let s:color='#F7768E'|let s:str= 'Replace '
	elseif m == 'v'|let s:color='#F7768E'|let s:str= 'Visual '
	elseif m == 'i'|let s:color='#7AA2F7'|let s:str= 'Insert '
	elseif m == 't'|let s:color='#7AA2F7'|let s:str= 'Terminal '
	else|let s:color='#9ECE6A'|let s:str= 'Normal '
	endif
	exec 'highlight User3 font=#000000 guifg=#1a1b26 guibg='.s:color
	exec 'highlight User4 font=#000000 guifg='.s:color.' guibg=#232433'
	redraw|return s:str
endfunction

let g:status_git_branch=""
if has('nvim')
	let g:status_git_branch=' nvim'.' |'
endif
func! GitBranchShow(chan,msg)
	let g:status_git_branch=" ".a:msg." |"
endfunc
if g:status_git_branch==""
	call job_start("git rev-parse --abbrev-ref HEAD",{"out_cb":"GitBranchShow"})
endif

set statusline=%3*\ %{GetMode()}
set statusline+=%4*\ %{g:status_git_branch}\ %F\ \|%m%r%h%w%=
set statusline+=%3*\ %Y\ |
set statusline+=%3*¦%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}¦
set statusline+=%5*☰\ %l/%-L¦%3p%%¦:%v\ ¦
" @Statusline }}}

" @Tabline {{{
let s:tab_after=""
func! TabLine(direct)
	let s:tab_result=""|let flag=0
	if a:direct|return s:tab_after!=""?s:tab_after."|":"\ "|else|let s:tab_after=""|endif
	for buf in getbufinfo({'buflisted':1})
		let s:name=buf.name
		if strridx(buf.name,"/")!=-1|let s:name=strpart(buf.name,strridx(buf.name,"/")+1)|endif
		if buf.name!=expand('%:p')
			let bt=getbufvar(buf.bufnr,"&buftype")
			if bt!=""|continue|endif
			if flag==0|let s:tab_result=s:tab_result."\ ".s:name."\ "|else|let s:tab_after=s:tab_after."\ ".s:name."\ "|endif
		else|let flag=1|endif
	endfor
	redrawt
	return s:tab_result
endfunc
func! TabLineSet()
	if len(gettabinfo())>1|return "%5* Tab %2*%=%1* buffer"|endif
	if &modified|let tab="%2* %0.32(%{TabLine(0)}%)%5*\ %t\ %6*%2*%<%{TabLine(1)}%r%h%w%=%6*\ %5* buffer"
	else|let tab="%2* %0.32(%{TabLine(0)}%)%1*\ %t\ %2*%2*%<%{TabLine(1)}%r%h%w%=%2*\ %1* buffer"
	endif
	return tab
endfunc
set tabline=%!TabLineSet()
set showtabline=2
" @Tabline }}}

" @Netrw {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
set fillchars=vert:\⎜
nnoremap <leader>e :Lexplore<cr> " set netrw
highlight VertSplit guibg=#1a1b26 guifg=#232433
" @Netrw }}}

" @like easy motion {{{
let s:easymotion_key=['j','l','k','h','a','s','d','f','g','q','w','e','r','u','i','o','p','c','v','b','n','m','t','y','z','x']
let s:easymotion_leader=[';',',',' ',"'",'.','/','[','\',']']|let s:easymotion_leader_dict={';':0,',':0,'.':0,"'":0,' ':0,'/':0,'[':0,'\':0,']':0}
func! s:EasyMotion()abort
	echo "input key:"|let ch=nr2char(getchar())|let s:easymotion={}|let llen=len(s:easymotion_leader)+1
	let ch=tolower(ch)|if ch>='a'&&ch<='z'|let up=toupper(ch)|else|let up=""|endif
	let info=winsaveview()|let info["endline"]=winheight(0)+info["topline"]|let width=winwidth(0)|let num=0|let old=ch|let pos=0|let klen=len(s:easymotion_key)
	if ch=="\<c-[>"|return|endif|if &fen|setlocal nofen|endif
	let lines=getbufline("%",info["topline"],info["endline"])|let bak=copy(lines)|set nohlsearch
	let hlcomment=[]|let begin=info["topline"]|let end=info["endline"]
	while end-begin>=8|call add(hlcomment,matchaddpos("comment",range(begin,end)))|let begin+=8|endwhile
	call add(hlcomment,matchaddpos("comment",range(begin,end)))
	let listl=range(0,len(lines)-1)|let nowline=info["lnum"]-info["topline"]|call sort(listl,{arg1,arg2 -> abs(arg2-nowline)-abs(arg1-nowline)})
	for i in listl
		" if i+info["topline"]==info["lnum"]|continue|endif
		while 1
			let pos=stridx(lines[i],ch,pos)
			if up!=""|let postemp=stridx(lines[i],up,pos)|if postemp!=-1&&(postemp<pos||pos==-1)|let pos=postemp|endif|endif
			if pos!=-1&&(pos<width||&wrap)
				if num<klen|let req=s:easymotion_key[num]
				elseif num<llen*klen|let req=s:easymotion_leader[num/klen-1].s:easymotion_key[num%klen]
				else|break
				endif
				let m= matchaddpos("incsearch", [[i+info["topline"],pos+1,len(req)]])
				let s:easymotion[req]={"line":i,"pos":pos,"hl":m}
				let lines[i]=strpart(lines[i],0,pos).req.strpart(lines[i],pos+len(req))
				let num+=1|let pos+=2|if num>=llen*klen|break|endif
			else|let pos=0|break
			endif
		endwhile
		if num>=llen*klen|break|endif
	endfor
	if len(s:easymotion)==0|echo "cannot find"|endif
	silent! undojoin|call setline(info["topline"],lines)|redraw!|echo "target key:"| let ch=nr2char(getchar())
	if has_key(s:easymotion_leader_dict,ch)|let ch=ch.nr2char(getchar())|endif
	if has_key(s:easymotion, ch)|let temp=s:easymotion[ch]|call cursor(temp["line"]+info["topline"],temp["pos"]+1)|endif
	for [key,val] in items(s:easymotion)|let i=val["line"]|let pos=val["pos"]|let hl=val["hl"]|call matchdelete(hl)|endfor
	for hlnow in hlcomment|call matchdelete(hlnow)|endfor
	silent! undojoin|call setline(info["topline"],bak)|setlocal nomodified
endfunc
nnoremap <silent>s :call <sid>EasyMotion()<cr>
inoremap <silent><c-s> <c-o>:call <sid>EasyMotion()<cr>
" @like easy motion }}}

" @like clever-f {{{
nnoremap <silent>f :call <sid>CleverF('f')<cr>
nnoremap <silent>F :call <sid>CleverF('F')<cr>
let s:cleverf_hl_arr=[]|let s:cleverf_pos_arr=[]|let s:cleverf_find_now=0
func! s:CleverFDeleteHl() abort
	if s:cleverf_find_now==getline(line("."))[col(".")-1]|return|endif
	for hl in s:cleverf_hl_arr|call matchdelete(hl)|endfor
	let s:cleverf_hl_arr=[]|let s:cleverf_pos_arr=[]|let s:cleverf_find_now=0|let s:cleverf_find_line=-1
	au! CleverF
endfunc
func! s:CleverF(ch) abort
	if type(s:cleverf_find_now)!=0|call feedkeys(a:ch.s:cleverf_find_now,'n')|return|endif
	let line=getline('.')|let line_num=line('.')|let col=col('.')|let ch=nr2char(getchar())|let s:cleverf_pos_arr=[]|let pos=stridx(line,ch,0)
	while pos!=-1|call add(s:cleverf_pos_arr,pos)|let pos=stridx(line,ch,pos+1)|endwhile
	if len(s:cleverf_pos_arr)==0|return|endif
	for now_pos in s:cleverf_pos_arr|let tmp = matchaddpos("incsearch", [[line_num,now_pos+1,1]])|call add(s:cleverf_hl_arr,tmp)|endfor
	let s:cleverf_find_now=ch
	augroup CleverF|au!|autocmd! CursorMoved * call <sid>CleverFDeleteHl()|augroup END
	call feedkeys(a:ch.ch,'n')
endfunc
" @like clever-f }}}

" @like vim sourround {{{
let g:pair_map={'(':')','[':']','{':'}','"':'"',"'":"'",'<':'>','`':'`',}
func! s:AddSourround()
	let s:ch=nr2char(getchar())|let s:col=col('.')|let pos=getcurpos()
	norm! gv"sy
	let s:str = @s
	for k in keys(g:pair_map)
		if s:ch==k||s:ch==g:pair_map[k]
			execute ":s/^\\(.\\{".(col('.')-1)."\\}\\)".escape(s:str, '~"/\.^$[]*')."/\\1".k.escape(s:str, '~"/\.^$[]*').g:pair_map[k]."/"
			call setpos('.', pos)
			return
		endif
	endfor
	echo s:ch.' unknow pair'
endfunc
func! s:DelSourround()
	let s:ch=nr2char(getchar())
	if getline('.')[col('.')-1]!=s:ch|echo 'not begin with'.s:ch|return|endif
	for k in keys(g:pair_map)
		if s:ch==k
			let pair=g:pair_map[k]|let left_pos=[line('.'),col('.')]|call search(pair)|let right_pos=[line('.'),col('.')]
			if left_pos[0]==right_pos[0]&&right_pos[1]!=left_pos[1]
				let now_line=getline('.')
				let now_line=strpart(now_line,0,left_pos[1]-1).strpart(now_line,left_pos[1],right_pos[1]-left_pos[1]-1).strpart(now_line,right_pos[1])
				call setline(left_pos[0],now_line)
			endif
			call cursor(left_pos[0],left_pos[1])|return
		endif
	endfor
endfunc
func! s:ChangeSourround()
	let s:ch=nr2char(getchar())|let s:two=nr2char(getchar())
	if !has_key(g:pair_map,s:ch)|echo 'no this ch'.s:ch|return|endif
	if !has_key(g:pair_map,s:two)|echo 'no this ch'.s:two|return|endif
	let s:pair_ch=g:pair_map[s:ch]|let s:pair_two=g:pair_map[s:two]
	if s:ch=="'"|exec "normal! r".s:two."f'"."r".s:pair_two|return|endif
	let escape_str='~"\.^$[]*'."'"
	let s:escape_ch=escape(s:ch, escape_str)|let s:escape_two=escape(s:two, escape_str)
	let s:escape_pair_ch=escape(s:pair_ch, escape_str)|let s:escape_pair_two=escape(s:pair_two, escape_str)
	let pos=getcurpos()|let now_line=getline('.')|if now_line[col('.')-1]!=s:ch|echo 'not begin with'.s:ch|return|endif
	let now_line=strpart(now_line,0,col('.')-1).s:two.strpart(now_line,col('.'))
	let [ line , col ] = searchpairpos(s:escape_ch, '', s:escape_pair_ch, 'n')
	call setline(line('.'),now_line)
	let next_line=getline(line)|let next_line=strpart(next_line,0,col-1).s:pair_two.strpart(next_line,col)
	call setline(line,next_line)|call setpos('.',pos)
endfunc
xnoremap <silent>S  :<c-u>call <sid>AddSourround()<cr>
nnoremap <silent>ds :call <sid>DelSourround()<cr>
nnoremap <silent>cs :call <sid>ChangeSourround()<cr>
" @like vim sourround }}}

" @HiCursorWords {{{
let g:HiCursorWords_delay = 0
let g:HiCursorWords_hiGroupRegexp = ''
let g:HiCursorWords_debugEchoHiName = 0
highlight! link WordUnderTheCursor Underlined
highlight WordUnderTheCursor cterm=underline term=underline gui=underline

augroup HiCursorWords
    autocmd!
    autocmd  CursorMoved  *  call s:HiCursorWords__startHilighting()
augroup END
function! s:HiCursorWords__getHiName(linenum, colnum)
    let hiname = synIDattr(synID(a:linenum, a:colnum, 0), "name")|let hiname = s:HiCursorWords__resolveHiName(hiname)|return hiname
endfunction
function! s:HiCursorWords__resolveHiName(hiname)
    redir => resolved
    silent execute 'highlight ' . a:hiname
    redir END
    if stridx(resolved, 'links to') == -1|return a:hiname|endif
    return substitute(resolved, '\v(.*) links to ([^ ]+).*$', '\2', '')
endfunction
function! s:HiCursorWords__getWordUnderTheCursor(linestr, linenum, colnum)
    let word = matchstr(a:linestr, '\k*\%' . a:colnum . 'c\k\+')
    if word == ''|return ''|endif
    return '\V\<' . word . '\>'
endfunction
function! s:HiCursorWords__execute()
    if exists("w:HiCursorWords__matchId")|call matchdelete(w:HiCursorWords__matchId)|unlet w:HiCursorWords__matchId|endif
    let linestr = getline('.')|let linenum = line('.')|let colnum = col('.')
    if g:HiCursorWords_debugEchoHiName|echo s:HiCursorWords__getHiName(linenum, colnum)| endif
    let word = s:HiCursorWords__getWordUnderTheCursor(linestr, linenum, colnum)
    if strlen(word) != 0
        if strlen(g:HiCursorWords_hiGroupRegexp) != 0
                    \ && match(s:HiCursorWords__getHiName(linenum, colnum), g:HiCursorWords_hiGroupRegexp) == -1
                return
        endif
        let w:HiCursorWords__matchId = matchadd('WordUnderTheCursor', word, 0)
    endif
endfunction
function! s:HiCursorWords__startHilighting()
    let b:HiCursorWords__oldUpdatetime = &updatetime|let &updatetime = g:HiCursorWords_delay
    augroup HiCursorWordsUpdate
        autocmd!
        autocmd CursorHold,CursorHoldI  *
                    \ if exists('b:HiCursorWords__oldUpdatetime') | let &updatetime = b:HiCursorWords__oldUpdatetime | endif
                    \ | call s:HiCursorWords__execute()
    augroup END
endfunction
" @HiCursorWords }}}

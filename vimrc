" #################################################
" ############### Vim-Plug Vimrc ###################
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
let mapleader = "\<space>"
let maplocalleader = ','
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

" @GUI {{{
if has("gui_running")
	set guifont=Hack\ Nerd\ Font\ Regular\ 12      " set fonts in gvim
	set guioptions-=m           " hide the menu bar
	set guioptions-=T           " hide tool bar
	set guioptions-=L           " hide left scroll bar
	set guioptions-=r           " hide right scroll bar
	set guioptions-=b           " hide bottom scroll bar
	set showtabline=0           " hide tab bar
	" set guicursor=n-v-c:ver5    " set cursor to a vertical line
endif
" @GUI }}}

" @Buffer {{{
" jump to last place when open
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
    if a:mode!='c'| let ch=getline('.')[col('.')-1]
    else| let ch=getcmdline()[getcmdpos()-1]
    endif
    if a:ch=='"'||a:ch=="'"||a:ch=='`'
        if ch!=a:ch| return a:ch.a:ch."\<left>"| endif
    endif
    if ch==a:ch| return "\<right>"| endif
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

" @vim-plug {{{
call plug#begin()
    " which key
    Plug 'liuchengxu/vim-which-key'
    " @vim-which-key {{{
    " @vim-which-key }}}

    " translator
    Plug 'voldikss/vim-translator'
    " @vim-translator {{{
        let g:translator_target_lang = 'zh'
        let g:translator_source_lang = 'auto'
        let g:translator_history_enable = v:false
        let g:translator_window_type = 'popup'

        " " Echo translation in the cmdline
        " nmap <silent> <Leader>t <Plug>Translate
        " vmap <silent> <Leader>t <Plug>TranslateV
        " " Display translation in a window
        " nmap <silent> <Leader>w <Plug>TranslateW
        " vmap <silent> <Leader>w <Plug>TranslateWV
        " " Replace the text with translation
        " nmap <silent> <Leader>r <Plug>TranslateR
        " vmap <silent> <Leader>r <Plug>TranslateRV
        " " Translate the text in clipboard
        " nmap <silent> <Leader>x <Plug>TranslateX
    " @vim-translator }}}

    " float terminal
    Plug 'voldikss/vim-floaterm'
    " @vim-floaterm {{{
        let g:floaterm_wintype  = 'float'
        let g:floaterm_position = 'center'

        let g:floaterm_keymap_new    = '<F7>'
        " let g:floaterm_keymap_new    = '<Leader>ft'
        let g:floaterm_keymap_prev   = '<F8>'
        let g:floaterm_keymap_next   = '<F9>'
        let g:floaterm_keymap_toggle = '<F12>'
    " @vim-floaterm }}}

    " function list/tagbar
    Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
    " @vista {{{
        nnoremap <silent> <leader>t :Vista!!<cr>
        let g:tagbar_width = 22
        let g:vista#renderer#enable_icon = 1
        let g:vista_default_executive = 'ctags'
        let g:vista_sidebar_width = 30
        let g:vista_echo_cursor = 1
        let g:vista_stay_on_open = 1
        " exit vim if vista is the only window remaining in the only tab.
        augroup Vista
            autocmd!
            autocmd BufEnter * if ( &ft == 'vista' || &ft == 'vista_markdown' ) && winnr('$') == 1 | call feedkeys(":vsplit|bn\<cr>") | endif
        augroup END

        " Open Vista on Vim startup
        " autocmd VimEnter * Vista
    " @vista }}}

    " add endif when enter if
    Plug 'tpope/vim-endwise', {'for':['vim','sh','cpp','c']}

    Plug 'tpope/vim-sensible'

    " file tree left
    Plug 'preservim/nerdtree'
    " @nerdtree {{{
        nnoremap <silent><leader>n :NERDTreeToggle<cr>
        nnoremap <silent><leader>N :NERDTreeFind<cr>
        let g:NERDTreeFileExtensionHighlightFullName = 1
        let g:NERDTreeExactMatchHighlightFullName = 1
        let g:NERDTreePatternMatchHighlightFullName = 1
        let g:NERDTreeHighlightFolders = 1
        let g:NERDTreeHighlightFoldersFullName = 1
        let g:NERDTreeDirArrowExpandable='▷'
        let g:NERDTreeDirArrowCollapsible='▼'
        let g:NERDTreeWinSize=18
        " exit vim if NERDTree is the only window remaining in the only tab.
        augroup NerdTree
            autocmd!
            autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | :bn | endif
        augroup END

        " Open NERDTree on Vim startup
        autocmd VimEnter * NERDTree | wincmd p
    " @nerdtree }}}

    " file devicon
    Plug 'ryanoasis/vim-devicons'

    " statusline of bottom
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " @vim-airline {{{
        " let g:airline_theme= "tokyonight"
        let g:airline_powerline_fonts = 1
        let g:airline_extensions = ['tabline' , 'coc', 'branch']
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
    " @vim-airline }}}

    " git control
    Plug 'tpope/vim-fugitive', {'on':['Git','GV','GV!']}
    Plug 'junegunn/gv.vim', {'on':['Git','GV','GV!']}

    " ai
    Plug 'exafunction/codeium.vim', {'on': 'Codeium'}
    Plug 'madox2/vim-ai'
    " @vim-ai {{{
        " ========== Basic AI commands ==========
        " :AI       complete text
        " :AIEdit   edit text
        " :AIChat   continue or open new chat
        " :AIImage  generate image
        " ============== Utilities ==============
        " :AIRedo          repeat last AI command
        " :AIUtilRolesOpen open role config file
        " :AIUtilDebugOn   turn on debug logging
        " :AIUtilDebugOff  turn off debug logging
        "
        " Tip: Press Ctrl-c anytime to cancel completion
        " Tip: Use command shortcuts - :AIE, :AIC, :AIR, :AII or setup your own key bindings
        " Tip: Define and use custom roles, e.g. :AIEdit /grammar.
        " Tip: Use pre-defined roles /right, /below, /tab to choose how chat is open, e.g. :AIC /right
        " Tip: Combine commands with a range :help range, e.g. to select the whole buffer - :%AIE fix grammar

        " This prompt instructs model to be consise in order to be used inline in editor
        let s:initial_complete_prompt =<< trim END
        >>> system

        You are a general assistant.
        Answer shortly, consisely and only what you are asked.
        Do not provide any explanantion or comments if not requested.
        If you answer in a code, do not wrap it in markdown code block.
        END

        " :AI
        " - prompt: optional prepended prompt
        " - engine: chat | complete - see how to configure complete engine in the section below
        " - options: openai config (see https://platform.openai.com/docs/api-reference/completions)
        " - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
        " - options.request_timeout: request timeout in seconds
        " - options.enable_auth: enable authorization using openai key
        " - options.token_file_path: override global token configuration
        " - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
        " - ui.paste_mode: use paste mode (see more info in the Notes below)
        let g:vim_ai_complete = {
        \  "prompt": "",
        \  "engine": "chat",
        \  "options": {
        \    "model": "gpt-4o",
        \    "endpoint_url": "https://api.openai.com/v1/chat/completions",
        \    "max_tokens": 0,
        \    "max_completion_tokens": 0,
        \    "temperature": 0.1,
        \    "request_timeout": 20,
        \    "stream": 1,
        \    "enable_auth": 1,
        \    "token_file_path": "",
        \    "selection_boundary": "#####",
        \    "initial_prompt": s:initial_complete_prompt,
        \  },
        \  "ui": {
        \    "paste_mode": 1,
        \  },
        \}

        " :AIEdit
        " - prompt: optional prepended prompt
        " - engine: chat | complete - see how to configure complete engine in the section below
        " - options: openai config (see https://platform.openai.com/docs/api-reference/completions)
        " - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
        " - options.request_timeout: request timeout in seconds
        " - options.enable_auth: enable authorization using openai key
        " - options.token_file_path: override global token configuration
        " - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
        " - ui.paste_mode: use paste mode (see more info in the Notes below)
        let g:vim_ai_edit = {
        \  "prompt": "",
        \  "engine": "chat",
        \  "options": {
        \    "model": "deepseek-coder",
        \    "endpoint_url": "https://api.deepseek.com/v1/chat/completions",
        \    "max_tokens": 0,
        \    "max_completion_tokens": 0,
        \    "temperature": 0.1,
        \    "request_timeout": 20,
        \    "stream": 1,
        \    "enable_auth": 1,
        \    "token_file_path": "",
        \    "selection_boundary": "#####",
        \    "initial_prompt": s:initial_complete_prompt,
        \  },
        \  "ui": {
        \    "paste_mode": 1,
        \  },
        \}

        " This prompt instructs model to work with syntax highlighting
        let s:initial_chat_prompt =<< trim END
        >>> system

        You are a general assistant.
        If you attach a code block add syntax type after ``` to enable syntax highlighting.
        END

        " :AIChat
        " - prompt: optional prepended prompt
        " - options: openai config (see https://platform.openai.com/docs/api-reference/chat)
        " - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
        " - options.request_timeout: request timeout in seconds
        " - options.enable_auth: enable authorization using openai key
        " - options.token_file_path: override global token configuration
        " - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
        " - ui.open_chat_command: preset (preset_below, preset_tab, preset_right) or a custom command
        " - ui.populate_options: put [chat-options] to the chat header
        " - ui.scratch_buffer_keep_open: re-use scratch buffer within the vim session
        " - ui.force_new_chat: force new chat window (used in chat opening roles e.g. `/tab`)
        " - ui.paste_mode: use paste mode (see more info in the Notes below)
        let g:vim_ai_chat = {
        \  "prompt": "",
        \  "options": {
        \    "model": "deepseek-chat",
        \    "endpoint_url": "https://api.deepseek.com/v1/chat/completions",
        \    "max_tokens": 0,
        \    "max_completion_tokens": 0,
        \    "temperature": 1,
        \    "request_timeout": 20,
        \    "stream": 1,
        \    "enable_auth": 1,
        \    "token_file_path": "",
        \    "selection_boundary": "",
        \    "initial_prompt": s:initial_chat_prompt,
        \  },
        \  "ui": {
        \    "open_chat_command": "preset_below",
        \    "scratch_buffer_keep_open": 0,
        \    "populate_options": 0,
        \    "code_syntax_enabled": 1,
        \    "force_new_chat": 0,
        \    "paste_mode": 1,
        \  },
        \}

        " :AIImage
        " - prompt: optional prepended prompt
        " - options: openai config (https://platform.openai.com/docs/api-reference/images/create)
        " - options.request_timeout: request timeout in seconds
        " - options.enable_auth: enable authorization using openai key
        " - options.token_file_path: override global token configuration
        " - options.download_dir: path to image download directory, `cwd` if not defined
        let g:vim_ai_image_default = {
        \  "prompt": "",
        \  "options": {
        \    "model": "dall-e-3",
        \    "endpoint_url": "https://api.openai.com/v1/images/generations",
        \    "quality": "standard",
        \    "size": "1024x1024",
        \    "style": "vivid",
        \    "request_timeout": 20,
        \    "enable_auth": 1,
        \    "token_file_path": "",
        \  },
        \  "ui": {
        \    "download_dir": "",
        \  },
        \}

        " custom roles file location
        " let g:vim_ai_roles_config_file = s:plugin_root . "/roles-example.ini"

        " custom token file location
        let g:vim_ai_token_file_path = "~/.config/openai.token"

        " debug settings
        let g:vim_ai_debug = 0
        let g:vim_ai_debug_log_file = "/tmp/vim_ai_debug.log"

        " Notes:
        " ui.paste_mode
        " - if disabled code indentation will work but AI doesn't always respond with a code block
        "   therefore it could be messed up
        " - find out more in vim's help `:help paste`
        " options.max_tokens
        " - note that prompt + max_tokens must be less than model's token limit, see #42, #46
        " - setting max tokens to 0 will exclude it from the OpenAI API request parameters, it is
        "   unclear/undocumented what it exactly does, but it seems to resolve issues when the model
        "   hits token limit, which respond with `OpenAI: HTTPError 400`

        " complete text on the current line or in visual selection
        nnoremap <leader>a :AI<CR>
        xnoremap <leader>a :AI<CR>

        " edit text with a custom prompt
        xnoremap <leader>s :AIEdit fix grammar and spelling<CR>
        nnoremap <leader>s :AIEdit fix grammar and spelling<CR>

        " trigger chat
        xnoremap <leader>c :AIChat<CR>
        nnoremap <leader>c :AIChat<CR>

        " redo last AI command
        nnoremap <leader>r :AIRedo<CR>
    " @vim-ai }}}

    " enhance f/t
    Plug 'rhysd/clever-f.vim'

    " pair auto
    Plug 'jiangmiao/auto-pairs'

    " find anything
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    " @LeaderF {{{
        " find file
        nnoremap <space>f :LeaderfFile<cr>
        " recent file
        nnoremap <space>F :LeaderfMru<cr>
        " find buffer
        nnoremap <leader>b :LeaderfBuffer<cr>
        nnoremap <space>b :LeaderfBuffer<cr>
        " function list
        nnoremap <space>t :LeaderfFunction<cr>
        nnoremap <space>T :LeaderfFunctionAll<cr>
        xnoremap <space>t :<c-u>execute ":Leaderf function --all --input " . <sid>GetSelectArea()<cr>
        " find for help
        nnoremap <space>h :LeaderfHelp<cr>
        nnoremap <space>H :Leaderf help --input key:<cr>
        xnoremap <space>h :<c-u>execute ":Leaderf help --input " . <sid>GetSelectArea()<cr><tab>
        " enhance find
        nnoremap <space>/ :LeaderfLine<cr>
        xnoremap <space>/ :<c-u>execute ":Leaderf line --input " . <sid>GetSelectArea()<cr><tab>
        nnoremap <space>? :LeaderfLineAll<cr>
        xnoremap <space>? :<c-u>execute ":Leaderf line --all --input " . <sid>GetSelectArea()<cr><tab>
        " find key word
        nnoremap <space>a :Leaderf rg -i<cr>
        nnoremap <space>A :Leaderf rg -i --cword<cr>
        xnoremap <space>a :<c-u>execute ":Leaderf rg -i --input " . <sid>GetSelectArea()<cr><tab>
        xnoremap <space>A :<c-u>execute ":Leaderf rg -i " . <sid>GetSelectArea()<cr><tab>
        " tags
        nnoremap <space>j :LeaderfBufTag<cr>
        nnoremap <space>J :LeaderfBufTagAll<cr>
        " jumps
        nnoremap <space>k :Leaderf jumps<cr><tab>
        " recall
        nnoremap <space>l :Leaderf --recall<cr><tab>
        " quickfix jump
        nnoremap <space>Q :Leaderf quickfix<cr><tab>
        " find color
        nnoremap <F1> :LeaderfColorscheme<cr>
        " set leaderf work dir
        nnoremap <silent><nowait>=l :let g:Lf_WorkingDirectoryMode = 'ac'<cr>
        nnoremap <silent><nowait>\l :let g:Lf_WorkingDirectoryMode = 'c'<cr>
        " set leaderf options
        let g:Lf_HideHelp = 1
        let g:Lf_WindowPosition = 'popup'
        let g:Lf_StlSeparator = { 'left': '', 'right': ''}
        let g:Lf_PreviewInPopup = 1
        let g:Lf_PreviewResult = {'Function': 1,'Rg': 1,'Line': 1,'BufTag': 1,'Jumps': 1}
        let g:Lf_CommandMap = {'<C-J>':['<C-J>','<C-N>'],'<C-K>':['<C-P>','<C-K>'],'<C-P>':['<C-L>'],'<HOME>':['<C-A>'],'<Del>':['<Del>','<C-D>']}
        let g:Lf_UseCache = 0
        let g:Lf_WildIgnore = {
                    \ 'dir': ['.svn','.git','.hg','.vscode','.idea','bin','static'],
                    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.out']
                    \}
        " f1 to open help menu,f5 to fresh,tab to normal mode
        " c-] open in vertical,c-x open in split,c-v paste clip,c-t open in a tab,c-\ ask for open,D to delete buffer
    " @LeaderF }}}


    " quick add comment: gc, gcc
    Plug 'tpope/vim-commentary'

    " quick move mouse
    Plug 'easymotion/vim-easymotion'
    " @vim-easymotion {{{
        let g:EasyMotion_smartcase = 1
        map <Leader> <Plug>(easymotion-prefix)
        " <Leader>f{char} to move to {char}
        map  <Leader>f <Plug>(easymotion-bd-f)
        nmap <Leader>f <Plug>(easymotion-overwin-f)

        " s{char}{char} to move to {char}{char}
        nmap s <Plug>(easymotion-overwin-f2)

        " Move to line
        map <Leader>L <Plug>(easymotion-bd-jk)
        nmap <Leader>L <Plug>(easymotion-overwin-line)

        " Move to word
        map  <Leader>w <Plug>(easymotion-bd-w)
        nmap <Leader>w <Plug>(easymotion-overwin-w)
    " @vim-easymotion }}}

    Plug 'junegunn/vim-easy-align'
    " @vim-easy-align {{{
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap ga <Plug>(EasyAlign)
        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        nmap ga <Plug>(EasyAlign)
    " @vim-easy-align }}}

    " Completion
    " if report: The ycmd server SHUT DOWN (restart with ':YcmRestartServer') , Type ':YcmToggleLogs xxx.log'
    " Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
    " @YouCompleteMe {{{
        " let g:ycm_min_num_identifier_candidate_chars = 2
        " let g:ycm_show_diagnostics_ui = 1
    " @YouCompleteMe }}}
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " @coc {{{
        " Extensions: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
        let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-marketplace']
        " Install coc marketplace
        " :CocList marketplace
        " Search coc plugin
        " :CocList marketplace python
    " @coc }}}

    " theme
    Plug 'altercation/vim-colors-solarized'
    Plug 'ghifarit53/tokyonight-vim'

    " indent
    Plug 'Yggdroot/indentLine'

call plug#end()
" @vim-plug }}}

" theme
set background=light
colorscheme solarized

" which key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

{ config, pkgs, ... }:

let config = {
  plugins = with pkgs.vimPlugins; [
    coc-nvim
    coc-r-lsp
    ctrlp-vim
    editorconfig-vim
    gist-vim
    goyo-vim
    neomake
    rust-vim
    vim-commentary
    vim-dispatch
    vim-fugitive
    vim-gitgutter
    vim-lastplace
    vim-polyglot
    vim-repeat
    vim-scala
    vim-sleuth
    vim-surround
    vim-trailing-whitespace
    vimtex
    vimux
    vimwiki
  ];
  enable = true;
  extraConfig = ''
      set background=dark
      " allow switching away from unsaved buffers
      set hidden
      set history=1000

      set updatetime=300

      set expandtab
      set shiftwidth=2
      set tabstop=2

      set ignorecase
      set smartcase

      set number
      set relativenumber

      set backupdir=$HOME/.vim/backupfiles//
      set directory=$HOME/.vim/swapfiles//
      set undodir=$HOME/.vim/undofiles//
      set undofile

      set nocompatible

      filetype plugin indent on

      " always set autoindenting on
      set autoindent
      " smart indent; stop indent when closing brackets etc
      set smartindent
      " two spaces after .?! when joining lines
      set joinspaces

      " highlight search result
      set hlsearch
      " incremental search
      set incsearch
      set nolazyredraw

      " delete whitespace, line break and char using <BS>
      set backspace=indent,eol,start
      " always show curser position
      set ruler

      " yank into system clipboard
      set clipboard=unnamedplus

      " true color
      set termguicolors
      " make true colors work in tmux
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

      set textwidth=80
      set colorcolumn=+1
      set signcolumn=yes
      " highlight current line
      set cursorline

      " encoding
      set fileencoding=utf-8

      " break at last word instead of last char
      set linebreak

      " autoload file changes
      set autoread

      set smarttab

      set softtabstop=2
      set shiftround

      " invisible characters
      set list
      " set listchars=tab:â\ ,eol:Â¬,trail:â,extends:â¯,precedes:â®
      " set showbreak=âª

      " code folding settings
      " fold based on syntax
      set foldmethod=indent
      " don't fold by default
      set nofoldenable
      set foldlevel=1

      " smoother redrawing
      set ttyfast
      " diff with vertical split
      set diffopt+=vertical
      " show the status line all the time
      set laststatus=2
      " keep 5 lines on the screen when scrolling
      set scrolloff=5
      " enhanced command line completion
      set wildmenu
      " Search down into subfolders
      " Provides tab-completion for all file-related tasks
      set path+=**

      " show incomplete commands
      set showcmd

      " complete files like a shell
      set wildmode=list:longest

      " command bar height
      set cmdheight=1
      " set terminal title
      set title
      " set shortmess+=TOFwatc
      set shortmess+=c

      " show matching braces
      set showmatch
      " how many tenths of a second to blink
      set mat=2
      " set spell langs
      set spelllang=de,en

      syntax enable
      let g:polyglot_disabled=['latex']
      " highlight clear SpellBad
      " highlight SpellBad cterm=undercurl

      " " Only do this part when compiled with support for autocommands.
      " if has("autocmd")
      " " Put these in an autocmd group, so that we can delete them easily.
      " augroup vimrcEx
      " au!
      " autocmd FileType text setlocal foldtext<
      " augroup END
      " endif " has("autocmd")

      " error bells
      set errorbells
      set visualbell
      set timeoutlen=500

      " turn on manpages (:Man)
      runtime ftplugin/man.vim

      " set a map leader for more key combos
      let mapleader=','

      " clear highlighted search
      noremap <space> :nohlsearch<cr>

      " enable . command in visual mode
      vnoremap . :normal .<cr>

      " make the highlighting of tabs and other non-text less annoying
      highlight SpecialKey ctermbg=none ctermfg=8
      highlight NonText ctermbg=none ctermfg=8

      " ctrlp
      " order top to bottom
      let g:ctrlp_match_window='bottom,order::ttb'
      " open files in new buffer
      let g:ctrlp_switch_buffer=0
      " use ripgrep if available
      if executable('rg')
      set grepprg=rg\ --color=never
      let g:ctrlp_user_command='rg %s --files -i --color=never --glob ""'
      let g:ctrlp_use_caching=0
      endif

      " set textwidth for mails
      autocmd FileType mail setlocal textwidth=72

      " count wraped lines as one line when doing relative jumps
      noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
      noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

      " scroll the viewport faster
      nnoremap <C-e> 3<C-e>
      nnoremap <C-y> 3<C-y>

      "" Section AutoGroups {{{
      "" file type specific settings
      augroup configgroup
      autocmd!

      " automatically resize panes on resize
      autocmd VimResized * exe 'normal! \<c-w>='
      autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
      " save all files on focus lost, ignoring warnings about untitled buffers
      autocmd FocusLost * silent! wa

      " make quickfix windows take all the lower section of the screen
      " when there are multiple windows open
      autocmd FileType qf wincmd J

      autocmd! BufWritePost * Neomake
      augroup END
      " }}}

      " Append modeline after last line in buffer.
      " Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files.
      function! AppendModeline()
      let l:modeline = printf(" vim: set filetype=%s ts=%d sw=%d tw=%d %s :",
      \ &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? 'et' : 'noet')
      let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
      call append(line("$"), l:modeline)
      endfunction
      nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

      " netrw settings
      " disable banner
      let g:netrw_banner=0
      " open in prior window
      let g:netrw_browse_split=4
      " open splits to the right
      let g:netrw_altv=1
      " treeview
      let g:netrw_liststyle=3
      let g:netrw_list_hide=netrw_gitignore#Hide()
      let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

      " vimux mappings
      " Prompt for a command
      map <Leader>vp :VimuxPromptCommand<CR>
      " Prompt for a make command
      map <Leader>vm :VimuxPromptCommand("make ")<CR>
      " Inspect runner pane
      map <Leader>vi :VimuxInspectRunner<CR>
      " Close runner
      map <Leader>vq :VimuxCloseRunner<CR>
      " Rerun last command
      map <Leader>vv :VimuxRunLastCommand<CR>
      " Stop running command
      map <Leader>vs :VimuxInterruptRunner<CR>

      " close Goyo *and* vim with :q
      function! s:goyo_enter()
      let b:quitting=0
      let b:quitting_bang=0
      autocmd QuitPre <buffer> let b:quitting=1
      cabbrev <buffer> q! let b:quitting_bang=1 <bar> q!
      endfunction

      function! s:goyo_leave()
      " Quit Vim if this is the only remaining buffer
      if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
      qa!
      else
      qa
      endif
      endif
      endfunction
      autocmd! User GoyoEnter call <SID>goyo_enter()
      autocmd! User GoyoLeave call <SID>goyo_leave()

      " run rustfmt when saving a file
      let g:rustfmt_autosave=1

      au BufRead,BufNewFile *.sbt set filetype=scala

      let g:coc_global_extensions = [
        \ 'coc-explorer',
        \ 'coc-snippets',
        \ 'coc-pairs'
      \ ]
      nmap ge :CocCommand explorer<CR>
      " Use tab for trigger completion with characters ahead and navigate.
      " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
      inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

      function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      " Use <c-space> to trigger completion.
      inoremap <silent><expr> <c-space> coc#refresh()

      " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
      " Coc only does snippet and additional edit on confirm.
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
      " Or use `complete_info` if your vim support it, like:
      " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

      " Use `[g` and `]g` to navigate diagnostics
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)

      " Remap keys for gotos
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      " Use K to show documentation in preview window
      nnoremap <silent> K :call <SID>show_documentation()<CR>

      function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
      else
      call CocAction('doHover')
      endif
      endfunction

      " Highlight symbol under cursor on CursorHold
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " Remap for rename current word
      nmap <leader>rn <Plug>(coc-rename)

      " Remap for format selected region
      xmap <leader>f  <Plug>(coc-format-selected)
      nmap <leader>f  <Plug>(coc-format-selected)

      augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      augroup end

      " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
      xmap <leader>a  <Plug>(coc-codeaction-selected)
      nmap <leader>a  <Plug>(coc-codeaction-selected)

      " Remap for do codeAction of current line
      nmap <leader>ac  <Plug>(coc-codeaction)
      " Fix autofix problem of current line
      nmap <leader>qf  <Plug>(coc-fix-current)

      " Create mappings for function text object, requires document symbols feature of languageserver.
      xmap if <Plug>(coc-funcobj-i)
      xmap af <Plug>(coc-funcobj-a)
      omap if <Plug>(coc-funcobj-i)
      omap af <Plug>(coc-funcobj-a)

      " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
      nmap <silent> <C-d> <Plug>(coc-range-select)
      xmap <silent> <C-d> <Plug>(coc-range-select)

      " Use `:Format` to format current buffer
      command! -nargs=0 Format :call CocAction('format')

      " Use `:Fold` to fold current buffer
      command! -nargs=? Fold :call     CocAction('fold', <f-args>)

      " use `:OR` for organize import of current buffer
      command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

      " Add status line support, for integration with other plugin, checkout `:h coc-status`
      " set statusline^=%{coc#status()}%{get(b:,'coc_current_function',''')}

      " Using CocList
      " Show all diagnostics
      nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
      " Manage extensions
      nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
      " Show commands
      nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
      " Find symbol of current document
      nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
      " Search workspace symbols
      nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
      " Do default action for next item.
      nnoremap <silent> <space>j  :<C-u>CocNext<CR>
      " Do default action for previous item.
      nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
      " Resume latest coc list
      nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
    '';
}; in

{

  # Note that this doesn’t merge deeply, so you couldn’t add to plugins. For that
  # you can use the nixos module system’s mkMerge with
  # programs.neovim = lib.mkMerge [ config { vimAlias = true; } ]

  programs.neovim = {
    vimAlias = true;
    viAlias = true;
  } // config;
  programs.vim = config;

}

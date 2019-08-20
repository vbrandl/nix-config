{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    settings = {
      background = "dark";
      # allow switching away from unsaved buffers
      hidden = true;
      history = 1000;

      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;

      ignorecase = true;
      smartcase = true;

      number = true;
      relativenumber = true;

      backupdir = [ "$HOME/.vim/backupfiles//" ];
      directory = [ "$HOME/.vim/swapfiles//" ];
      undodir = [ "$HOME/.vim/undofiles//" ];
      undofile = true;
    };
    plugins = [
      "coc-nvim"
      "coc-r-lsp"
      "ctrlp-vim"
      "editorconfig-vim"
      "gist-vim"
      "goyo-vim"
      "neomake"
      "neomake"
      "rust-vim"
      "vim-commentary"
      "vim-dispatch"
      "vim-fugitive"
      "vim-polyglot"
      "vim-repeat"
      "vim-sleuth"
      "vim-surround"
      "vim-trailing-whitespace"
      "vimtex"
      "vimux"
      "vimwiki"
    ];
    extraConfig = ''
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
      set shortmess+=TOFwat

      " show matching braces
      set showmatch
      " how many tenths of a second to blink
      set mat=2
      " set spell langs
      set spelllang=de,en

      syntax enable
      let g:polyglot_disabled=['latex']
      highlight clear SpellBad
      highlight SpellBad cterm=undercurl

      " Only do this part when compiled with support for autocommands.
      if has("autocmd")
        " Put these in an autocmd group, so that we can delete them easily.
        augroup vimrcEx
        au!

        autocmd FileType text setlocal foldtext<

        augroup END

        " remember cursor position
        autocmd BufReadPost *
              \ if line("'\"") > 1 && line("'\"") <= line("$") |
              \ exe "normal! g`\"" |
              \ endif

      endif " has("autocmd")

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
    '';
  };
}

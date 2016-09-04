" bootstrap plug.vim
if empty(glob('$NVIM_HOME/autoload/plug.vim'))
  silent !curl -fLo $NVIM_HOME/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

function! DoRemotePlugins(arg)
  UpdateRemotePlugins
endfunction

call plug#begin(expand('$NVIM_HOME/bundles/'))

"" Plugins
" general
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'mhinz/vim-startify'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'tommcdo/vim-lion'
Plug 'Shougo/vimfiler.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'schickling/vim-bufonly'

" dev
Plug 'Shougo/deoplete.nvim', {'do' : function('DoRemotePlugins')}
Plug 'zchee/deoplete-jedi',  {'for': 'python'}
Plug 'eagletmt/neco-ghc',    {'for': 'haskell'}
Plug 'neomake/neomake'
Plug 'lilydjwg/tagbar'
Plug 'Chiel92/vim-autoformat'
Plug 'carlitux/deoplete-ternjs', {'for': 'javascript'}

" sys dev
Plug 'racer-rust/vim-racer', {'for': 'rust'}
Plug 'zchee/deoplete-go', {'for': 'go'}

" web dev
Plug 'tpope/vim-rails',              {'for': ['ruby', 'eruby']}
Plug 'jelera/vim-javascript-syntax', {'for': 'javascript'}
Plug 'tweekmonster/django-plus.vim', {'for': 'python'}

" writing
Plug 'vim-pandoc/vim-pandoc'

" syntax
Plug 'tpope/vim-git'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tmux-plugins/vim-tmux'
Plug 'rust-lang/rust.vim'
Plug 'vim-ruby/vim-ruby',       {'for': ['ruby', 'eruby']}
Plug 'vim-jp/vim-cpp',          {'for': 'cpp'}
Plug 'JulesWang/css.vim',       {'for': 'css'}
Plug 'othree/html5.vim',        {'for': 'html'}
Plug 'cespare/vim-toml',        {'for': 'toml'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'leshill/vim-json',        {'for': ['json', 'javascript']}
Plug 'avakhov/vim-yaml',        {'for': 'yaml'}
Plug 'mxw/vim-jsx'
Plug 'mustache/vim-mustache-handlebars'
Plug 'digitaltoad/vim-pug'
Plug 'neovimhaskell/haskell-vim'
Plug 'fatih/vim-go', {'for': 'go'}

" colorscheme
Plug 'zyphrus/vim-hybrid'

call plug#end()

"" Configuration

" colorscheme
set background=dark
colorscheme hybrid

" lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'neomake', 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'neomake': 'LightLineNeomake'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler' && &readonly ? '🔒' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineNeomake()
  if winwidth(0) <= 80
    return ''
  endif
  let errs  = neomake#statusline#LoclistCounts()
  let signs = [has_key(errs,'E') ? '✖:' . get(errs,'E') : '',
        \  has_key(errs,'W') ? '⚠:' . get(errs,'W') : '']
  return join(filter(signs , 'v:val != ""'), ' ')
endfunction

" buftabline
let g:buftabline_show = 1
let g:buftabline_indicators = 1

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_ignore_pattern = ['^\.', '.*\.pyc$', '^__.*__$', '^node_modules$']
nmap <silent> <C-o> :VimFiler -buffer-name=VimFiler -status -project -split -toggle -winwidth=30<CR>
" project draw-like functionality
nmap <silent> - :VimFilerBufferDir -find -force-quit -buffer-name=drawer<CR>

call vimfiler#custom#profile('default', 'context', {
      \  'safe': 0,
      \  'explorer': 1,
      \  'auto_expand': 1,
      \  'no_quit': 1
      \ })

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_menu_width = 80

" neomake
autocmd! BufWritePost * Neomake

" autoformat
nmap <leader>ff :Autoformat<CR>
nmap <leader>fw :RemoveTrailingSpaces<CR>

" startify
autocmd User Startified setlocal buftype=
let g:startify_enable_unsafe = 1
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_relative_path = 1
let g:startify_session_dir = $NVIM_HOME.'/sessions'
let g:startify_custom_header = map(split(system('pwd'), '\n'), '"   ". v:val') + ['','']
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
let g:startify_list_order = [
      \ ['   Most recently used in this directory:'],
      \ 'dir',
      \ ['   Most recently used:'],
      \ 'files',
      \ ['   Sessions:'],
      \ 'sessions',
      \ ]
let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
      \ 'bundle/.*/doc',
      \ '\s+',
      \ ]

" ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" vim-gitgutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '~'
let g:gitgutter_realtime = 0
nmap [h :GitGutterPrevHunk<CR>zz
nmap ]h :GitGutterNextHunk<CR>zz
nmap <leader>gh :GitGutterLineHighlightsToggle<CR>

" vim-surround
let g:surround_no_insert_mappings = 0

" tagbar
let g:tagbar_width = 30
let g:tagbar_autofocus = 1
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['+', '-']
nmap <C-T> :TagbarToggle<CR>

" pandoc
let g:pandoc#modules#disabled =["folding"]
let g:pandoc#syntax#conceal#use = 0

" neco-ghc
let g:necoghc_enable_detailed_browse = 1

" vim-go
let g:go_def_mapping_enabled = 0
let g:go_term_mode='split'
au FileType go nmap <leader>gd <Plug>(go-def)
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gn <Plug>(go-rename)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)

" vim ts=2 sw=2 expandtab

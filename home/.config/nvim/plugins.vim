let g:ale_disable_lsp = 1

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" General
call minpac#add('tpope/vim-sleuth')
call minpac#add('bronson/vim-trailing-whitespace')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('nathanaelkane/vim-indent-guides')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('rstacruz/vim-closer')
call minpac#add('moll/vim-bbye')
call minpac#add('dense-analysis/ale')
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('junegunn/fzf.vim')

" Writing
call minpac#add('junegunn/goyo.vim')
call minpac#add('junegunn/limelight.vim')

" Theming
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('itchyny/lightline.vim')

" Language syntax
call minpac#add('pangloss/vim-javascript')
call minpac#add('herringtondarkholme/yats.vim')
call minpac#add('peitalin/vim-jsx-typescript')
call minpac#add('purescript-contrib/purescript-vim')
call minpac#add('neovimhaskell/haskell-vim')
call minpac#add('cespare/vim-toml')
call minpac#add('vmchale/dhall-vim')

command! PackUpdate call minpac#update()
command! PackClean  call minpac#clean()


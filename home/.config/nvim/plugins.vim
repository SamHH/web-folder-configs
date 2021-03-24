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
" call minpac#add('rstacruz/vim-closer')
call minpac#add('moll/vim-bbye')
call minpac#add('vim-test/vim-test')
call minpac#add('dense-analysis/ale')
call minpac#add('junegunn/fzf.vim')
call minpac#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})
call minpac#add('windwp/nvim-ts-autotag')
call minpac#add('joosepalviste/nvim-ts-context-commentstring')
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true },
  }
EOF

" LSP
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('hrsh7th/nvim-compe')
lua <<EOF
  local lspc = require'lspconfig'

  lspc.hls.setup {}
  lspc.purescriptls.setup {}
  lspc.rls.setup {}
  lspc.tsserver.setup {}

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      underline = true,
    }
  )

  require'compe'.setup {
    enabled = true;
    autocomplete = false;
    documentation = true;

    source = {
      nvim_lsp = true;
      path = true;
      buffer = true;
    };
  }
EOF

" Theming
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('itchyny/lightline.vim')

" Language syntax (where not already supported via treesitter)
call minpac#add('purescript-contrib/purescript-vim')
call minpac#add('neovimhaskell/haskell-vim')
call minpac#add('vmchale/dhall-vim')
call minpac#add('derekelkins/agda-vim')

command! PackUpdate call minpac#update()
command! PackClean  call minpac#clean()


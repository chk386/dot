-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
  use("rcarriga/nvim-notify")

  use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
  -- use("NvChad/base46")

  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

  use("szw/vim-maximizer") -- maximizes and restores current window

  -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- vs-code like icons
  use("kyazdani42/nvim-web-devicons")

  -- statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
  use({ "nvim-telescope/telescope-file-browser.nvim" })

  -- autocompletion
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths
  use("hrsh7th/cmp-cmdLine") -- for autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin

  -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- managing & installing lsp servers, linters & formatters
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

  -- configuring lsp servers
  use("neovim/nvim-lspconfig") -- easily configure language servers
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
  use("liuchengxu/vista.vim") -- lsp symbols, tags

  -- formatting & linting
  use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
  use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- git integration
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
  -- TODO: diff tool
  -- https://github.com/sindrets/diffview.nvim

  -- show buffers or tabs
  use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

  -- dims inactive windows
  -- use("sunjon/shade.nvim")

  -- color highliting & picker (ccc)
  use("uga-rosa/ccc.nvim")
  use({
    "folke/lsp-colors.nvim",
    config = function()
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981",
      })
    end,
  })

  -- Start Screen Home
  use("glepnir/dashboard-nvim")

  -- highliting for TODO, FIXME, INFO...
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  })

  -- wiki for vim
  use({
    "vimwiki/vimwiki",
    branch = "dev",
    config = function()
      vim.g["vimwiki_list"] = {
        {
          path = "~/.config/nvim/wiki",
          path_html = "~/.config/nvim/wiki_html",
          syntax = "markdown",
          ext = ".md",
        },
      }
      vim.g["vimwiki_global_ext"] = 0
      vim.g["vimwiki_conceallevel"] = 0

      vim.cmd([[
          let g:vimwiki_key_mappings =
          \ {
          \   'all_maps': 1,
          \   'global': 1,
          \   'headers': 1,
          \   'text_objs': 1,
          \   'table_format': 1,
          \   'table_mappings': 1,
          \   'lists': 1,
          \   'links': 1,
          \   'html': 1,
          \   'mouse': 0,
          \ }
          ]])
    end,
  })
  use("ElPiloto/telescope-vimwiki.nvim")

  -- markdown preview
  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    config = function()
      vim.cmd([[
        " set to 1, nvim will open the preview window after entering the markdown buffer
        " default: 0
        let g:mkdp_auto_start = 0

        " set to 1, the nvim will auto close current preview window when change
        " from markdown buffer to another buffer
        " default: 1
        let g:mkdp_auto_close = 1

        " set to 1, the vim will refresh markdown when save the buffer or
        " leave from insert mode, default 0 is auto refresh markdown as you edit or
        " move the cursor
        " default: 0
        let g:mkdp_refresh_slow = 0

        " set to 1, the MarkdownPreview command can be use for all files,
        " by default it can be use in markdown file
        " default: 0
        let g:mkdp_command_for_global = 0

        " set to 1, preview server available to others in your network
        " by default, the server listens on localhost (127.0.0.1)
        " default: 0
        let g:mkdp_open_to_the_world = 0

        " use custom IP to open preview page
        " useful when you work in remote vim and preview on local browser
        " more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
        " default empty
        let g:mkdp_open_ip = ''

        " specify browser to open preview page
        " for path with space
        " valid: `/path/with\ space/xxx`
        " invalid: `/path/with\\ space/xxx`
        " default: ''
        let g:mkdp_browser = ''

        " set to 1, echo preview page url in command line when open preview page
        " default is 0
        let g:mkdp_echo_preview_url = 0

        " a custom vim function name to open preview page
        " this function will receive url as param
        " default is empty
        let g:mkdp_browserfunc = ''

        " options for markdown render
        " mkit: markdown-it options for render
        " katex: katex options for math
        " uml: markdown-it-plantuml options
        " maid: mermaid options
        " disable_sync_scroll: if disable sync scroll, default 0
        " sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
        "   middle: mean the cursor position alway show at the middle of the preview page
        "   top: mean the vim top viewport alway show at the top of the preview page
        "   relative: mean the cursor position alway show at the relative positon of the preview page
        " hide_yaml_meta: if hide yaml metadata, default is 1
        " sequence_diagrams: js-sequence-diagrams options
        " content_editable: if enable content editable for preview page, default: v:false
        " disable_filename: if disable filename header for preview page, default: 0
        let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1,
            \ 'sequence_diagrams': {},
            \ 'flowchart_diagrams': {},
            \ 'content_editable': v:false,
            \ 'disable_filename': 0,
            \ 'toc': {}
            \ }

        " use a custom markdown style must be absolute path
        " like '/Users/username/markdown.css' or expand('~/markdown.css')
        let g:mkdp_markdown_css = ''

        " use a custom highlight style must absolute path
        " like '/Users/username/highlight.css' or expand('~/highlight.css')
        let g:mkdp_highlight_css = ''

        " use a custom port to start server or empty for random
        let g:mkdp_port = ''

        " preview page title
        " ${name} will be replace with the file name
        let g:mkdp_page_title = '「${name}」'

        " recognized filetypes
        " these filetypes will have MarkdownPreview... commands
        let g:mkdp_filetypes = ['markdown']

        " set default theme (dark or light)
        " By default the theme is define according to the preferences of the system
        let g:mkdp_theme = 'light'

      ]])
    end,
  })

  -- floating terminal
  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("toggleterm").setup()
    end,
  })

  -- indent Blankline
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        -- space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  })

  -- floating signature window for class, function, method
  use({
    "ray-x/lsp_signature.nvim",
  })

  -- expand visual selection
  use("terryma/vim-expand-region")
  -- FIXME: 무조건 해야함
  -- extract function, extract variable, inline variable
  -- https://github.com/ThePrimeagen/refactoring.nvim

  -- use({
  --   "folke/which-key.nvim",
  --   config = function()
  --     require("which-key").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     })
  --   end,
  -- })
  --
  if packer_bootstrap then
    require("packer").sync()
  end

  vim.cmd([[
    function! LastModified()
      if g:md_modify_disabled
          return
      endif

      if (&filetype != "vimwiki")
          return
      endif

      if &modified
          let save_cursor = getpos(".")
          let n = min([10, line("$")])
          keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
              \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
          call histdel('search', -1)
          call setpos('.', save_cursor)
      endif
    endfun

    function! NewTemplate()

        let l:wiki_directory = v:false

        for wiki in g:vimwiki_list
            if expand('%:p:h') =~ expand(wiki.path)
                let l:wiki_directory = v:true
                break
            endif
        endfor

        if !l:wiki_directory
            return
        endif

        if line("$") > 1
            return
        endif

        let l:template = []
        call add(l:template, '---')
        call add(l:template, 'layout  : wiki')
        call add(l:template, 'title   : ')
        call add(l:template, 'summary : ')
        call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
        call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
        call add(l:template, 'tag     : ')
        call add(l:template, 'toc     : true')
        call add(l:template, 'public  : true')
        call add(l:template, 'parent  : ')
        call add(l:template, 'latex   : false')
        call add(l:template, '---')
        call add(l:template, '* TOC')
        call add(l:template, '{:toc}')
        call add(l:template, '')
        call add(l:template, '# ')
        call setline(1, l:template)
        execute 'normal! G'
        execute 'normal! $'

        echom 'new wiki page has created'
    endfunction

    augroup vimwikiauto
      autocmd BufWritePre *wiki/*.md call LastModified()
      autocmd BufRead,BufNewFile *wiki/*.md call NewTemplate()
    augroup END

    let g:md_modify_disabled = 0
  ]])
end)

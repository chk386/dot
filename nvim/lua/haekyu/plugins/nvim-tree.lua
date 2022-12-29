-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
-- change color for arrows in tree to light blue
vim.cmd([[ 
  highlight NvimTreeIndentMarker guifg=#3FC5FF 
]])

-- configure nvim-tree
nvimtree.setup({
  reload_on_bufenter = true,
  -- keymap
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = "<A-v>", action = "vsplit" },
      },
    },
  },
  -- change folder arrow icons
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- arrow when folder is closed
          arrow_open = "", -- arrow when folder is open
        },
      },
    },
  },
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    change_dir = {
      enable = false,
      global = false,
      restrict_above_cwd = true,
    },
    open_file = {
      window_picker = {
        enable = true,
      },
    },
  },
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = { --[[ "node_modules"  ]]
    },
  },
  filters = {
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = {
      "package-lock.json",
      "^\\.git$",
      "dist", --[[ "node_modules"  ]]
    },
    exclude = {},
  },
  -- 	git = {
  -- 		ignore = false,
  -- 	},
})

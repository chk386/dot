local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

bufferline.setup({
  options = {
    mode = "buffers", -- tabs or buffers
    separator_style = "thin",
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    show_close_icon = true,
    color_icons = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true, -- use a "true" to enable the default, or set your own character
      },
    },
    numbers = function(opts)
      return string.format(opts.raise(opts.ordinal), "%s")
    end,

    show_tab_indicators = true,
    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
        local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
        local info = #vim.diagnostic.get(0, { severity = seve.INFO })
        local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

        if error ~= 0 then
          table.insert(result, { text = "  " .. error, fg = "#EC5241" })
        end

        if warning ~= 0 then
          table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
        end

        if hint ~= 0 then
          table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
        end

        if info ~= 0 then
          table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
        end
        return result
      end,
    },
  },
  highlights = {
    separator = {
      fg = "#073642",
      bg = "#002b36",
    },
    separator_selected = {
      fg = "#073642",
    },
    background = {
      fg = "#657b83",
      bg = "#002b36",
    },
    buffer_selected = {
      fg = "#fdf6e3",
      bold = true,
    },
    fill = {
      bg = "#073642",
    },
  },
})

vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
vim.keymap.set("n", "<F13>", "<Cmd>BufferLineGoToBuffer 1<CR>", {})
vim.keymap.set("n", "<F14>", "<Cmd>BufferLineGoToBuffer 2<CR>", {})
vim.keymap.set("n", "<F15>", "<Cmd>BufferLineGoToBuffer 3<CR>", {})
vim.keymap.set("n", "<F16>", "<Cmd>BufferLineGoToBuffer 4<CR>", {})
vim.keymap.set("n", "<F17>", "<Cmd>BufferLineGoToBuffer 5<CR>", {})
vim.keymap.set("n", "<F18>", "<Cmd>BufferLineGoToBuffer 6<CR>", {})
vim.keymap.set("n", "<F19>", "<Cmd>BufferLineGoToBuffer 7<CR>", {})
vim.keymap.set("n", "<F20>", "<Cmd>BufferLineGoToBuffer 8<CR>", {})
vim.keymap.set("n", "<F21>", "<Cmd>BufferLineGoToBuffer 9<CR>", {})

vim.keymap.set("i", "<F13>", "<Cmd>BufferLineGoToBuffer 1<CR>", {})
vim.keymap.set("i", "<F14>", "<Cmd>BufferLineGoToBuffer 2<CR>", {})
vim.keymap.set("i", "<F15>", "<Cmd>BufferLineGoToBuffer 3<CR>", {})
vim.keymap.set("i", "<F16>", "<Cmd>BufferLineGoToBuffer 4<CR>", {})
vim.keymap.set("i", "<F17>", "<Cmd>BufferLineGoToBuffer 5<CR>", {})
vim.keymap.set("i", "<F18>", "<Cmd>BufferLineGoToBuffer 6<CR>", {})
vim.keymap.set("i", "<F19>", "<Cmd>BufferLineGoToBuffer 7<CR>", {})
vim.keymap.set("i", "<F20>", "<Cmd>BufferLineGoToBuffer 8<CR>", {})
vim.keymap.set("i", "<F21>", "<Cmd>BufferLineGoToBuffer 9<CR>", {})

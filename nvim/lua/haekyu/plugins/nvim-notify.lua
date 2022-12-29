local status, notify = pcall(require, "notify")
if not status then
  return
end

-- change default notify to nvim-notify
vim.notify = notify

-- enable :telescope notify
require("telescope").load_extension("notify")

notify.setup({
  background_colour = "Normal",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = "",
  },
  level = 2,
  minimum_width = 50,
  render = "default",
  stages = "fade",
  timeout = 2000,
  top_down = false,
})

local severity = {
  "error",
  "warn",
  "info",
  "info", -- map both hint and info to info?
}
vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
  vim.notify(method.message, severity[params.type])
end

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- move lines
keymap.set("n", "<S-Up>", ":m -2<CR>")
keymap.set("n", "<S-Down>", ":m +1<CR>")
keymap.set("v", "<S-Up>", ":m-2<CR>gv")
keymap.set("v", "<S-Down>", ":m'>+<CR>gv")

-- visual block
keymap.set("n", "<C-b>", "<C-v>")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<C-w>l <cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<C-w>l <cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<C-w>l <cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<C-w>l <cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<C-w>l <cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>fr", "<C-w>l <cmd>Telescope oldfiles<cr>") -- list available help tags
keymap.set("n", "<leader>fm", "<C-w>l <cmd>Telescope keymaps<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

vim.cmd([[
" set
  autocmd TermEnter term://*toggleterm#*
        \ tnoremap <silent><a-t> <Cmd>exe v:count1 . "ToggleTerm"<CR> |
        \ tnoremap <silent><a-f> <Cmd>:5.ToggleTerm<CR> 
     

 " By applying the mappings this way you can pass a count to your
 " mapping to open a specific window.
 " For example: 2<C-t> will open terminal 2
  inoremap <silent><a-t> <Esc><Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>
  nnoremap <silent><a-t> <Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>

  nnoremap <a-f> :5.ToggleTerm direction=float<CR>
  inoremap <a-f> <Esc><Cmd>exe "5.ToggleTerm"<CR>

  nnoremap <a-h> :vertical resize +10<CR>"
  nnoremap <a-l> :vertical resize -10<CR>"
  nnoremap <a-j> :horizontal resize +10<CR>"
  nnoremap <a-k> :horizontal resize -10<CR>"

  inoremap <a-h> :vertical resize +3<CR>"
  inoremap <a-l> :vertical resize -3<CR>"
  inoremap <a-k> :horizontal resize -3<CR>"
  inoremap <a-j> :horizontal resize +3<CR>"
]])

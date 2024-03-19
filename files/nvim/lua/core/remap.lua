-- better <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- go to beginning and end of line on insert mode
vim.keymap.set("i", "<C-b>", "<ESC>^i")
vim.keymap.set("i", "<C-e>", "<End>")

-- navigate within insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })

-- switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- save file
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- copy whole file
vim.keymap.set("n", "<C-c>", ":%y+<CR>")

-- new buffer
vim.keymap.set("n", "<leader>b", ":enew<CR>")

-- close buffer
vim.keymap.set("n", "<leader>x", ":bd<CR>")

-- lsp formatting
vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format { async = true }
end)

-- better <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- better <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- go to beginning and end of line on insert mode
vim.keymap.set("i", "<C-b>", "<ESC>^i")
vim.keymap.set("i", "<C-e>", "<End>")

-- navigate within insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })

-- switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- save file
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- copy whole file
vim.keymap.set("n", "<C-c>", ":%y+<CR>")

-- new buffer
vim.keymap.set("n", "<leader>b", ":enew<CR>")

-- close buffer
vim.keymap.set("n", "<leader>x", ":bd<CR>")

-- lsp formatting
vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format { async = true }
end)

-- escape terminal mode
vim.keymap.set("t", "<C-x>", "<C-\\><C-N>")

-- indent line
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- don't copy replaced text after pasting in visual mode
vim.keymap.set("x", "p", '"_dP')
-- go to beginning and end of line on insert mode
vim.keymap.set("i", "<C-b>", "<ESC>^i")
vim.keymap.set("i", "<C-e>", "<End>")

-- navigate within insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })

-- switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- save file
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- copy whole file
vim.keymap.set("n", "<C-c>", ":%y+<CR>")

-- new buffer
vim.keymap.set("n", "<leader>b", ":enew<CR>")

-- close buffer
vim.keymap.set("n", "<leader>x", ":bd<CR>")

-- lsp formatting
vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format { async = true }
end)


-- Mapping to jump to the next empty line
vim.keymap.set('n', '}', function()
    vim.cmd('call search(\'^\\s*$\\|\\%$\')')
end, { noremap = true  })

-- Mapping to jump to the previous empty line
vim.keymap.set('n', '{', function()
    vim.cmd('call search(\'^\\s*$\\|^%\', \'b\')')
end, { noremap = true })

-- escape terminal mode
vim.keymap.set("t", "<C-x>", "<C-\\><C-N>")

-- indent line
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- don't copy replaced text after pasting in visual mode
vim.keymap.set("x", "p", '"_dP')
-- escape terminal mode
vim.keymap.set("t", "<C-x>", "<C-\\><C-N>")

-- indent line
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- don't copy replaced text after pasting in visual mode
vim.keymap.set("x", "p", '"_dP')

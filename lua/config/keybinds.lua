local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- fzf lua
keymap.set("n", "<Tab>", "<cmd>FzfLua buffers<CR>", opts)
keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<CR>", opts)
keymap.set("n", "<leader>fr", function()
    FzfLua.live_grep({ search = vim.fn.input("Word to grep ") })
end, opts)

-- buffers

keymap.set("n", "ss", "<cmd>split<CR>", opts)
keymap.set("n", "sv", "<cmd>vsplit<CR>", opts)

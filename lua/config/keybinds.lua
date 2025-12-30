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

-- toggle term

keymap.set("n", "<leader>ex", function()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%:t:r")
    local file = vim.fn.expand("%:t")
    local Terminal = require("toggleterm.terminal").Terminal

    local Com

    if vim.fn.has("win32") == 1 then
        Com = "gcc " .. file .. " -o " .. filename .. " && " .. filename .. ".exe"
    else
        Com = "gcc " .. file .. " -o " .. filename .. " && ./" .. filename
    end

    if filetype == "c" then
        local Cterm = Terminal:new({
            cmd = Com,
            direction = "float",
            close_on_exit = false,
            hidden = true,
        })

        Cterm:toggle()
    elseif filetype == "lua" then
        local luaterm = Terminal:new({
            cmd = "lua " .. file,
            direction = "float",
            close_on_exit = false,
            hidden = true,
        })
        luaterm:toggle()
    elseif filetype == 'python' then
        local pyterm = Terminal:new({
            cmd = "python " .. file,
            direction = "float",
            close_on_exit = false,
            hidden = true,
        })
        pyterm:toggle()
    end
end)

keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- fzf lua
keymap.set("n", "<Tab>", "<cmd>FzfLua buffers<CR>", opts)
keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<CR>", opts)
keymap.set("n", "<leader>fr", function()
    FzfLua.live_grep({ search = vim.fn.input("Word to grep ") })
end, opts)

-- colorscheme
local theme_file = vim.fn.stdpath("state") .. "/colorscheme.txt"
keymap.set('n', '<leader>sc',
    function()
        vim.ui.select(
            { 'gruvbox', 'gruvbox-material', 'onedark', 'nord', 'rose-pine', 'kanagawa', 'kanagawa-dragon', },
            {
                prompt = "Choose colorscheme ",
                format_item = function(item)
                    return "" .. item
                end,
            }, function(choice)
                local ch = ''
                if choice == "gruvbox" then
                    ch = choice
                    vim.cmd.colorscheme(ch)
                elseif choice == "gruvbox-material" then
                    ch = choice
                    vim.cmd.colorscheme(ch)
                elseif choice == "onedark" then
                    ch = choice
                    vim.cmd.colorscheme(ch)
                elseif choice == "nord" then
                    ch = choice
                    vim.cmd.colorscheme(ch)
                elseif choice == "rose-pine" then
                    ch = choice
                    vim.cmd.colorscheme(ch)
                elseif choice == "kanagawa" then
                    ch = choice
                    vim.cmd.colorscheme(ch)
                elseif choice == "kanagawa-dragon" then
                    ch = choice
                    vim.cmd.colorscheme(ch)
                end
                local f = io.open(theme_file, "w")
                if f then
                    f:write(choice)
                    f:close()
                end
            end
        )
    end
)

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
        vim.ui.select(
            { "Lua (Vainilla)", "Lua (love2D)" },
            {
                prompt = "choose Which ",
                format_item = function(item)
                    return "" .. item
                end,
            }, function(Lchoice)
                if Lchoice == "Lua (Vainilla)" then
                    local luaterm = Terminal:new({
                        cmd = "lua " .. file,
                        direction = "float",
                        close_on_exit = false,
                        hidden = true,
                    })
                    luaterm:toggle()
                elseif Lchoice == "Lua (love2D)" then
                    local luloveterm = Terminal:new({
                        cmd = "lovec .",
                        direction = "float",
                        close_on_exit = true,
                        hidden = true,
                    })
                    luloveterm:toggle()
                end
            end
        )
    elseif filetype == 'python' then
        local pyterm = Terminal:new({
            cmd = "python " .. file,
            direction = "float",
            close_on_exit = false,
            hidden = true,
        })
        pyterm:toggle()
    elseif filetype == 'javascript' then
        local jsterm = Terminal:new({
            cmd = "node " .. file,
            direction = "float",
            close_on_exit = false,
            hidden = true,
        })
        jsterm:toggle()
    end
end)

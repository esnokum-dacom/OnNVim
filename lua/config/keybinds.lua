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

-- files
local gcc_file = vim.fn.stdpath("config") .. "/gcc.txt"
local theme_file = vim.fn.stdpath("state") .. "/colorscheme.txt"

local fr = io.open(gcc_file, "r")
local flags = ""
if fr then
    flags = fr:read("*a")
    fr:close()
end

local function saveTheme(themes)
    local f = io.open(theme_file, "w")
    if f then
        f:write(themes)
        f:close()
    end
end

-- colorscheme

keymap.set("n", "<leader>sc", function()
    vim.ui.select({ "gruvbox", "onedark", "nord", "rose-pine", "kanagawa", "oxocarbon", "fox" }, {
        prompt = "Choose colorscheme ",
        format_item = function(item)
            return "" .. item
        end,
    }, function(choice)
        local ch = ""
        if choice == "gruvbox" then
            vim.ui.select({ "gruvbox", "gruvbox-material", "retrobox" }, {
                prompt = "Choose " .. choice .. " themes",
                format_item = function(item)
                    return "" .. item
                end,
            }, function(gruvThemes)
                if gruvThemes == "gruvbox" then
                    ch = gruvThemes
                    vim.cmd.colorscheme(ch)
                elseif gruvThemes == "gruvbox-material" then
                    ch = gruvThemes
                    vim.cmd.colorscheme(ch)
                elseif gruvThemes == "retrobox" then
                    ch = gruvThemes
                    vim.cmd.colorscheme(ch)
                end
                saveTheme(gruvThemes)
            end)
        elseif choice == "onedark" then
            ch = choice
            vim.cmd.colorscheme(ch)
        elseif choice == "nord" then
            ch = choice
            vim.cmd.colorscheme(ch)
        elseif choice == "rose-pine" then
            vim.ui.select({ "rose-pine", "rose-pine-dawn", "rose-pine-main", "rose-pine-moon" }, {
                prompt = "Choose " .. choice .. " themes",
                format_item = function(item)
                    return "" .. item
                end,
            }, function(roseTheme)
                if roseTheme == "rose-pine" then
                    ch = roseTheme
                    vim.cmd.colorscheme(ch)
                elseif roseTheme == "rose-pine-dawn" then
                    ch = roseTheme
                    vim.cmd.colorscheme(ch)
                elseif roseTheme == "rose-pine-main" then
                    ch = roseTheme
                    vim.cmd.colorscheme(ch)
                elseif roseTheme == "rose-pine-moon" then
                    ch = roseTheme
                    vim.cmd.colorscheme(ch)
                end
                saveTheme(roseTheme)
            end)
        elseif choice == "kanagawa" then
            vim.ui.select({ "kanagawa", "kanagawa-dragon", "kanagawa-lotus", "kanagawa-wave" }, {
                prompt = "Choose " .. choice .. " themes",
                format_item = function(item)
                    return "" .. item
                end,
            }, function(kanagawaTheme)
                if kanagawaTheme == "kanagawa" then
                    ch = kanagawaTheme
                    vim.cmd.colorscheme(ch)
                elseif kanagawaTheme == "kanagawa-dragon" then
                    ch = kanagawaTheme
                    vim.cmd.colorscheme(ch)
                elseif kanagawaTheme == "kanagawa-lotus" then
                    ch = kanagawaTheme
                    vim.cmd.colorscheme(ch)
                elseif kanagawaTheme == "kanagawa-wave" then
                    ch = kanagawaTheme
                    vim.cmd.colorscheme(ch)
                end
                saveTheme(kanagawaTheme)
            end)
        elseif choice == "oxocarbon" then
            ch = choice
            vim.cmd.colorscheme(ch)
        elseif choice == "fox" then
            vim.ui.select({ "nightfox", "dayfox", "duskfox", "nordfox" }, {
                prompt = "Choose " .. choice .. " themes",
                format_item = function(item)
                    return "" .. item
                end,
            }, function(foxTheme)
                if foxTheme == "nightfox" then
                    ch = foxTheme
                    vim.cmd.colorscheme(ch)
                elseif foxTheme == "dayfox" then
                    ch = foxTheme
                    vim.cmd.colorscheme(ch)
                elseif foxTheme == "duskfox" then
                    ch = foxTheme
                    vim.cmd.colorscheme(ch)
                elseif foxTheme == "nordfox" then
                    ch = foxTheme
                    vim.cmd.colorscheme(ch)
                end
                saveTheme(foxTheme)
            end)
        end
        saveTheme(choice)
    end)
end)

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
        vim.ui.select({ "C vanilla", "C (raylib)", "Custom C/GCC command" }, {
            prompt = "Choose compiler ",
            format_item = function(item)
                return "" .. item
            end,
        }, function(choice)
            if choice == "C vanilla" then
                local Cterm = Terminal:new({
                    cmd = Com,
                    direction = "float",
                    close_on_exit = false,
                    hidden = true,
                })
                Cterm:toggle()
            elseif choice == "C (raylib)" then
                Com = "gcc " .. file .. " -o " .. filename .. " -I./include -L./lib -lraylib && ./" .. filename
                local Crterm = Terminal:new({
                    cmd = Com,
                    direction = "float",
                    close_on_exit = false,
                    hidden = true,
                })
                Crterm:toggle()
            elseif choice == "Custom C/GCC command" then
                vim.notify("default = [" .. flags .. "]")
                vim.ui.input({ prompt = "Enter gcc options for compile", default = flags }, function(input)
                    if not input then
                        return
                    end

                    local Gccterm = Terminal:new({
                        cmd = "gcc " .. file .. " -o " .. filename .. input .. "&& ./" .. filename,
                        direction = "float",
                        close_on_exit = false,
                        hidden = true,
                    })

                    local f = io.open(gcc_file, "w")
                    if f then
                        f:write(input)
                        f:close()
                    end

                    Gccterm:toggle()
                end)
            end
        end)
    elseif filetype == "lua" then
        vim.ui.select({ "Lua (Vainilla)", "Lua (love2D)" }, {
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
        end)
    elseif filetype == "python" then
        local pyterm = Terminal:new({
            cmd = "python " .. file,
            direction = "float",
            close_on_exit = false,
            hidden = true,
        })
        pyterm:toggle()
    elseif filetype == "javascript" then
        local jsterm = Terminal:new({
            cmd = "node " .. file,
            direction = "float",
            close_on_exit = false,
            hidden = true,
        })
        jsterm:toggle()
    end
end)

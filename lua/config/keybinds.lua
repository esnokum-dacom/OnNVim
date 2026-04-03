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
local theme_opts = vim.fn.stdpath("state") .. "/background-type.txt"

local fr = io.open(gcc_file, "r")
local flags = ""
if fr then
    flags = fr:read("*a")
    fr:close()
end

local function saveTheme(themes)
    local f = io.open(theme_file, "w")
    if f then
        f:write(themes .. "\n")
        f:close()
    end
end

local function saveThemeOpts(chopt)
    local f = io.open(theme_opts, "w")
    if f then
        f:write(chopt .. "\n")
        f:close()
    end
end

-- colorscheme

local colorschemes = {
    gruvbox = { "gruvbox", "gruvbox-material", "retrobox" },
    onedark = {},
    catppuccin = {},
    nord = {},
    ["rose-pine"] = { "rose-pine", "rose-pine-dawn", "rose-pine-main", "rose-pine-moon" },
    kanagawa = { "kanagawa", "kanagawa-dragon", "kanagawa-lotus", "kanagawa-wave" },
    oxocarbon = {},
    fox = { "nightfox", "dayfox", "duskfox", "nordfox" },
    ashen = {},
    darkvoid = {},
    bamboo = { "bamboo", "bamboo-light", "bamboo-multiplex", "bamboo-vulgaris" },
    ["monokai-nightasty"] = {},
    ["darcula-dark"] = { "dracula", "darcula-dark", "darcula-solid" },
    poimandres = {},
    onvim = {},
}

local order = {
    "gruvbox",
    "catppuccin",
    "onedark",
    "nord",
    "rose-pine",
    "kanagawa",
    "oxocarbon",
    "fox",
    "ashen",
    "darkvoid",
    "bamboo",
    "monokai-nightasty",
    "darcula-dark",
    "poimandres",
    "on-vim",
    "──────────",
    "change dark/light",
    "change transparency",
}

local function applyTheme(name)
    vim.cmd.colorscheme(name)
    saveTheme(name)
end

keymap.set("n", "<leader>sc", function()
    vim.ui.select(order, {
        prompt = "Choose colorscheme ",
        format_item = function(item)
            return "" .. item
        end,
    }, function(choice)
        if not choice or choice == "──────────" then
            return
        end

        if choice == "change dark/light" then
            vim.ui.select({ "dark", "light" }, {
                prompt = "Choose light ambient",
                format_item = function(item)
                    return "" .. item
                end,
            }, function(ambient)
                if ambient then
                    vim.o.background = ambient
                    saveThemeOpts(ambient)
                end
            end)
            return
        end

        local variants = colorschemes[choice]

        if not variants or #variants == 0 then
            applyTheme(choice)
            return
        end

        vim.ui.select(variants, {
            prompt = "Choose " .. choice .. " theme",
            format_item = function(item)
                return "" .. item
            end,
        }, function(variant)
            if variant then
                applyTheme(variant)
            end
        end)
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
    elseif filetype == "cpp" then
        vim.ui.select({ "C vanilla", "C (raylib)", "Custom C/GCC command" }, {
            prompt = "Choose compiler ",
            format_item = function(item)
                return "" .. item
            end,
        }, function(choice)
            if choice == "C vanilla" then
                local Cterm = Terminal:new({
                    cmd = "g++ " .. file .. " -o " .. filename .. " && ./" .. filename,
                    direction = "float",
                    close_on_exit = false,
                    hidden = true,
                })
                Cterm:toggle()
            elseif choice == "C (raylib)" then
                Com = "g++ " .. file .. " -o " .. filename .. " -I./include -L./lib -lraylib && ./" .. filename
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
                        cmd = "g++ " .. file .. " " .. input .. " -o " .. filename .. " && ./" .. filename,
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

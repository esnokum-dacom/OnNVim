keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local shell = vim.o.shell

-- Harpoon
keymap.set("n", "<Tab>", function ()
    require("harpoon.ui").toggle_quick_menu()
end, opts)

keymap.set("n", "<M-a>", function ()
    require("harpoon.mark").add_file()
end, opts)

for i = 1, 9 do
    local lhs = "<M-" .. i .. ">"

    vim.keymap.set("n", lhs, function()
        require("harpoon.ui").nav_file(i)
    end, opts)
end

-- fzf lua
keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<CR>", opts)
keymap.set("n", "<leader>fr", function()
    vim.ui.input({ prompt = "grep word: " }, function(input)
        if not input or input == "" then
            return
        end

        require("fzf-lua").live_grep({ search = input })
    end)
end, opts)

-- oil
keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- nvim-tree
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Open nvim-tree" })

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
    poimandres = {},
    monochrome = {},
    vscode = {},
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
    "monochrome",
    "vscode",
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

    Com = "make"

    if filetype == "c" then
        vim.ui.select({ "C (Makefile)", "Custom CC command" }, {
            prompt = "Choose compiler ",
            format_item = function(item)
                return "" .. item
            end,
        }, function(choice)
            if choice == "C (Makefile)" then
                local Cterm = Terminal:new({
                    cmd = Com,
                    direction = "float",
		    close_on_exit = false,
		    auto_scroll = true,
                })
                Cterm:toggle()
            elseif choice == "Custom CC command" then
                vim.notify("default = [" .. flags .. "]")
                vim.ui.input({ prompt = "Execute command", default = flags }, function(input)
                    if not input then
                        return
                    end

                    local Gccterm = Terminal:new({
			cmd = shell .. " -c '" .. input .. "'",
			direction = "float",
			close_on_exit = false,
                    })

                    local f = io.open(gcc_file, "w")
                    if f then
                        f:write(input)
                        f:close()
                    end

                    Gccterm:open()
                end)
            end
        end)
    elseif filetype == "cpp" then
        vim.ui.select({ "C++ (Makefile)", "Custom command" }, {
            prompt = "Choose compiler ",
            format_item = function(item)
                return "" .. item
            end,
        }, function(choice)
            if choice == "C++ (Makefile)" then
                local Cterm = Terminal:new({
                    cmd = Com,
                    direction = "float",
                    close_on_exit = false,
                })
                Cterm:toggle()
            elseif choice == "Custom command" then
                vim.notify("default = [" .. flags .. "]")
                vim.ui.input({ prompt = "Enter gcc options for compile", default = flags }, function(input)
                    if not input then
                        return
                    end

                    local Gccterm = Terminal:new({
			cmd = shell .. " -c '" .. input .. "'",
                        direction = "float",
                        close_on_exit = false,
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
    end
end)

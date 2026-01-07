require("config.keybinds")
require("config.vimopts")
require("config.lazy")
local theme_file = vim.fn.stdpath("state") .. "/colorscheme.txt"
local f = io.open(theme_file, "r")
if f then
    local theme = f:read("*l")
    f:close()
    vim.cmd.colorscheme(theme)
end

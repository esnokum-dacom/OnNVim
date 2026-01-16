require("config.keybinds")
require("config.vimopts")
require("config.lazy")
require("config.input")

local theme_file = vim.fn.stdpath("state") .. "/colorscheme.txt"
local theme_opt = vim.fn.stdpath("state") .. "/background-type.txt"

local f = io.open(theme_file, "r")
if f then
	local theme = f:read("*l")
	f:close()
	vim.cmd.colorscheme(theme)
end

local r = io.open(theme_opt, "r")
if r then
	local theme = r:read("*l")
	r:close()
	vim.o.background = theme
end

vim.opt.clipboard = "unnamedplus"
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.numberwidth = 1
vim.o.statuscolumn = "%l "
vim.opt.fillchars = { eob = " " }
vim.o.wrap = true
vim.o.softtabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.o.autoindent = true
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.filetype.add({ extension = { tsx = "typescriptreact", jsx = "javacriptreact" } })

vim.lsp.enable("lua_ls")

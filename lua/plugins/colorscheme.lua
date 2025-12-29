return {
 "ellisonleao/gruvbox.nvim",
 priority = 1000,
 config = true,
 opts = {
  invert_selection = true,
 },
 config = function (_, opts)
 	require("gruvbox").setup(opts)
	vim.cmd.colorscheme "gruvbox"
 end
}

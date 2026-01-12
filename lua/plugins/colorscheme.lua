return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
	},

	{
		"shaunsingh/nord.nvim",
		priority = 1000,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
	},

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "deep",
			})
		end,
	},

	{
		"sainnhe/gruvbox-material",
		priority = 1000,
	},

	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
	},

	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
	},

	{
		"nyoom-engineering/oxocarbon.nvim",
		priority = 1000,
	},
}

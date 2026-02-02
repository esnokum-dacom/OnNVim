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

	{
		"ficcdaf/ashen.nvim",
		priority = 1000,
		lazy = false,
	},

	{
		"aliqyan-21/darkvoid.nvim",
		priority = 1000,
	},
	{
		"ribru17/bamboo.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"polirritmico/monokai-nightasty.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"xiantang/darcula-dark.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"olivercederborg/poimandres.nvim",
		lazy = false,
		priority = 1000,
	},
}

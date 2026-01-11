return {
	{
		"stevearc/dressing.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("dressing").setup({
				select = {
					backend = { "nui" },
					nui = {
						border = {
							style = "double",
						},
					},
				},
			})
		end,
	},
}

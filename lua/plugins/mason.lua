return {
	"mason-org/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				"docker_language_server",
				"codelldb",
				"dockerls",
				"clang-format",
				"prettier",
				"prettierd",
			},
		})
	end,
}

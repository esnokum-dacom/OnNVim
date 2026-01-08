return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier" },
                c = { "clangd", "clang-format" },
                cpp = { "clangd", "clang-format" },
            },
        })
    end
}

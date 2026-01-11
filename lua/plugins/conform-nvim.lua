return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier" },
                c = { "clang-format", prepend_args = { "--style='{BasedOnStyle: llvm, IndentWidth: 8}'" } },
                cpp = { "clang-format" },
                cs = { "csharpier_ramboe" },
                csproj = { "csharpier_ramboe" },
            },
            formatters = {
                csharpier_ramboe = {
                    command = "csharpier",
                    args = {
                        "format",
                        "--write-stdout",
                    },
                    to_stdin = true,
                }
            }
        })
    end
}

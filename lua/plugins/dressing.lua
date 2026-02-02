return {
    {
        "stevearc/dressing.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("dressing").setup({
                select = {
                    backend = { "builtin" },
                    builtin = {
                        show_numbers = true,
                        border = "double",
                        relative = "editor",
                    },
                },
            })
        end,
    },
}

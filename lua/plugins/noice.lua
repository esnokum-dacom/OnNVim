return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            cmdline = {
                format = {
                    cmdline = {
                        icon = "┈➤",
                        title = "𝙲𝙼𝙳",
                        border = "double",
                    }
                }
            },
            views = {
                notify = {
                    border = {
                        style = "double"
                    }
                },
                cmdline_popup = {
                    border = {
                        style = "double",
                    },
                },
                popupmenu = {
                    border = {
                        style = "double",
                    },
                },
                hover = {
                    border = {
                        style = "single",
                    },
                },
            },
        })
        require("notify").setup({
            render = "wrapped-compact",
            stages = "static",
        })
    end
}

return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    ---@diagnostic enable: missing-fields
    config = function()
        require("fzf-lua").setup({
            winopts = {
                preview = {
                    layout = "float",
                    wrap = true,
                    border = "double",
                },
                height = 0.8,
                wrap = true,
                border = "double",
            }
        })
    end
}

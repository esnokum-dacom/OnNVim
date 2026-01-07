return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    ---@module "fzf-lua"
    ---@diagnostic disable: missing-fields
    ---@diagnostic enable: missing-fields
    config = function()
        require("fzf-lua").setup({
            fzf_opts = {
                ["--padding"] = "1,0",
                ["--layout"] = "reverse",
            },
            winopts = {
                preview = {
                    border = "double",
                },
                prompt_position = "bottom",
                height = 0.8,
                border = "double",
            }
        })
    end
}

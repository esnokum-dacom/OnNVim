return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require "nvim-treesitter".setup {
            install_dir = vim.fn.stdpath('data') .. '/site'
        }
        require "nvim-treesitter".install {
            "json",
            "python",
            "javascript",
            "query",
            "typescript",
            "tsx",
            "rust",
            "zig",
            "yaml",
            "html",
            "css",
            "markdown",
            "markdown_inline",
            "bash",
            "lua",
            "vim",
            "vimdoc",
            "c",
            "cpp",
            "dockerfile",
            "gitignore",
        }
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '<filetype>' },
            callback = function() vim.treesitter.start() end,
        })
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
}

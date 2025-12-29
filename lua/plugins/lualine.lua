return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                theme = "gruvbox",
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics', 'filename' },
                lualine_c = { "buffers" },
                lualine_x = {},
                lualine_y = { 'progress', 'encoding', 'filetype', 'location' },
                lualine_z = { function()
                    return os.date("%H-%M")
                end }
            },
        })
    end
}

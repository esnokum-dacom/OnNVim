return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                theme = "auto",
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics', 'filename' },
                lualine_c = { "buffers" },
                lualine_x = {},
                lualine_y = { 'progress', 'location' },
                lualine_z = { function()
                    return os.date("%H-%M")
                end }
            },
        })
    end
}

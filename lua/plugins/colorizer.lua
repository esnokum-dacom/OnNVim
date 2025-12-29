return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require 'colorizer'.setup({
            '*',
            'css',
            'javascript',
            'lua',
            html = { mode = 'background' },
            css = { rgb_fn = true, },
        }, { mode = 'background' })
    end

}

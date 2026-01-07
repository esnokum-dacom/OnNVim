return {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',

    opts = {
        keymap = {
            preset = 'default',
            ['<CR>'] = { 'accept', 'fallback' },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lsp = {
                    name = 'LSP',
                    module = 'blink.cmp.sources.lsp',
                    score_offset = 1000,
                },
                snippets = {
                    name = 'Snippets',
                    module = 'blink.cmp.sources.snippets',
                    score_offset = 750,
                    opts = {
                        friendly_snippets = true,
                        search_paths = { vim.fn.stdpath('config') .. '/snippets' },
                    }
                },
                buffer = {
                    name = 'Buffer',
                    module = 'blink.cmp.sources.buffer',
                    score_offset = 500,
                },
                path = {
                    name = 'Path',
                    module = 'blink.cmp.sources.path',
                    score_offset = 250,
                },
            },
        },
        completion = {
            accept = {
                auto_brackets = { enabled = true },
            },
            menu = {
                border = 'double',
                draw = {
                    columns = {
                        { 'kind_icon' },
                        { 'label',    'label_description', gap = 1 },
                        { 'kind' }
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { border = 'double' }
            },
            ghost_text = { enabled = true },
        },

        signature = {
            enabled = true,
            window = { border = 'double' }
        },
    },
}

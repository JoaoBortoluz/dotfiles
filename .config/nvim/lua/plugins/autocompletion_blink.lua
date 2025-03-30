return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',

        version = '*',

        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-e: Hide menu
            -- C-k: Toggle signature help
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = {
                preset = 'default',
                ["<C-l>"] = { "accept" },
                ["<Tab>"] = {
                    function()
                        local cmp = require("blink.cmp")
                        if cmp.is_visible() then
                            cmp.accept()
                        else
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
                        end
                    end
                },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },

            signature = { enabled = true },

            -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = {
                implementation = "lua"
            }
        },
        -- opts_extend = { "sources.default" }
    },
}

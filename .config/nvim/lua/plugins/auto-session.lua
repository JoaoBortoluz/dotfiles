return{
    'rmagatti/auto-session',
    lazy = false,
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        require("auto-session").setup {
            suppressed_dirs = { "~/Downloads", "/"},
            auto_restore = false,

            session_lens = {
                load_on_setup = true,
                previewer = true,
            }
        }

        vim.keymap.set("n", "<Leader>sl", require("auto-session.session-lens").search_session, {
            desc = 'Load sessions',
            noremap = true,
        })

        vim.keymap.set("n", "<Leader>ss", "<cmd>SessionSave<CR>", {
            desc = "Save current session",
            noremap = true,
            silent = true,
        })

        vim.keymap.set("n", "<Leader>sd", "<cmd>SessionDelete<CR>", {
            desc = "Save current session",
            noremap = true,
            silent = true,
        })
    end,
}

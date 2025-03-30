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

        vim.keymap.set("n", "<Leader>ls", require("auto-session.session-lens").search_session, {
            noremap = true,
        })
    end,
}

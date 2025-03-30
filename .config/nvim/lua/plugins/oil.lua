return {
    "stevearc/oil.nvim",
    config = function()
        local oil = require("oil")
        oil.setup({
            default_file_explorer = true,
        })
        vim.keymap.set("n", "<leader>e", oil.toggle_float, {desc = 'Open [E]xplorer in current dir', silent = true, noremap = true})
    end,
}

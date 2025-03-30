return {
    "HoNamDuong/hybrid.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("hybrid").setup({
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = false,
                emphasis = true,
                comments = true,
                folds = true,
            },
            strikethrough = true,
            inverse = true,
            transparent = true,
            overrides = function(highlights, colors)
                highlights.LineNr = { fg = "#8A8A8A" }  -- Adjust the gray level as needed
                highlights.CursorLineNr = { fg = "#C2C0C0", bold = true }
                highlights.String = { fg = "#A3BE8C" }
                -- highlights.Number = { fg = "#ce917d" }

                -- Make background transparent for other UI elements
                highlights.Normal = { bg = "NONE" }
                highlights.StatusLine = { bg = "NONE" }  -- Transparent status line
                highlights.VertSplit = { fg = "#444444", bg = "NONE" } -- Transparent vertical split line
                highlights.TabLine = { bg = "NONE" } -- Transparent tab line
                highlights.TabLineSel = { bg = "NONE" } -- Transparent selected tab line
                highlights.WinBar = { bg = "NONE" }  -- Transparent window bar
            end,
        })

        vim.cmd.colorscheme("hybrid")
    end,
}

-- return {
--   'EdenEast/nightfox.nvim',
--   name = 'Nordfox',
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--   require('nightfox').setup({
--     options = {
--
--     }
-- }) 
--
--     vim.cmd('colorscheme nordfox')
--   end,
-- }

--  return {
--      "gmr458/vscode_modern_theme.nvim",
--      lazy = false,
--      priority = 1000,
--      config = function()
--          require("vscode_modern").setup({
--              cursorline = true,
--              transparent_background = false,
--              nvim_tree_darker = true,
--          })
--          vim.cmd.colorscheme("vscode_modern")

--     end,
--  }


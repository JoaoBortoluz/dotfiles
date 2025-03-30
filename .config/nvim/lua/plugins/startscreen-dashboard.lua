return {
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
        config = function()
            local function open_config()
                if vim.fn.has("win32") == 1 then
                    require('telescope.builtin').find_files({ cwd = "C:/Users/JoaoV/AppData/Local/nvim" })
                else
                    require('telescope.builtin').find_files({ cwd = "~/.config/nvim" })
                end
            end

            require('dashboard').setup {
                theme = 'hyper',
                shortcut_type = 'number',

                config = {
                    week_header = { enable = true },
                    shortcut = {
                        {
                            desc = '󰊳 Update',
                            group = '@property',
                            action = 'Lazy update',
                            key = 'u',
                        },
                        {
                            icon = ' ',
                            desc = 'New files',
                            group = 'Label',
                            action = function() vim.cmd('ene | startinsert') end,
                            key = 'e',
                        },
                        {
                            icon = '󰈞 ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            icon = ' ',
                            desc = 'Recent Files',
                            group = 'Label',
                            action = 'Telescope oldfiles',
                            key = 'r',
                        },
                        {
                            icon = ' ',
                            desc = 'Session Restore',
                            group = 'Number',
                            action = function() require("auto-session").RestoreSession() end,
                            key = 's',
                        },
                        {
                            icon = ' ',
                            desc = 'Config',
                            group = 'Number',
                            action = open_config,
                            key = 'c',
                        },
                        {
                            icon = '󰅚 ',
                            desc = 'Quit Neovim',
                            group = 'Number',
                            action = function() vim.cmd('qa') end,
                            key = 'q',
                        },
                    },

                    project = { limit = 5 },
                    mru = { limit = 10 },
                    footer = {},
                }
            }
        end
    }
}

return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },

    config = function()
        local alpha = require 'alpha'

        -- Using the default theme
        local dashboard = require 'alpha.themes.dashboard'

        -- Set header for the dashboard
        dashboard.section.header.val = {
            [[                                                    ]],
            [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
            [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
            [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
            [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
            [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
            [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
            [[                                                    ]],
        }

        -- Function to get current time
        local function get_datetime()
            return os.date("󰃰 %d-%m-%Y   %H:%M:%S")
        end

        -- Time section
        dashboard.section.time = {
            type = "text",
            val = get_datetime(),
            opts = { position = "center", hl = "Title" }
        }

        -- Buttons section
        dashboard.section.buttons.val = {
            dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
            dashboard.button( "f", "󰈞  Find file", ":Telescope find_files<CR>"),
            dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
            dashboard.button( "s", "  > Restore Session", ":SessionLoad<CR>"),
            dashboard.button( "c", "  > Config" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
            dashboard.button( "q", "󰅚  Quit Neovim", ":qa<CR>"),
        }

        -- Function to get MRU files (showing only the first two directories and file name)
        local function get_mru()
            local oldfiles = vim.v.oldfiles or {}
            local max_files = 10
            local mru_files = {}

            for i, filepath in ipairs(oldfiles) do
                if i > max_files then break end
                local icon = ""

                -- Extract directories and file name
                local dir = vim.fn.fnamemodify(filepath, ":h")  -- Last directory
                local dir2 = vim.fn.fnamemodify(dir, ":h")  -- Second last directory
                local filename = vim.fn.fnamemodify(filepath, ":t")  -- File name

                -- Format as: "dir2/dir/filename"
                local label = string.format("%s  %s/%s/%s", icon, vim.fn.fnamemodify(dir2, ":t"), vim.fn.fnamemodify(dir, ":t"), filename)

                -- Ensure MRU button uses `tostring(i)` as the shortcut number
                table.insert(mru_files, dashboard.button(
                    tostring(i), -- Shortcut number (tostring(i) added)
                    label,
                    ":e " .. vim.fn.fnameescape(filepath) .. " <CR>"
                ))
            end

            return mru_files
        end

        -- MRU section
        dashboard.section.mru = {
            type = "group",
            val = function()
                return vim.list_extend(
                    { { type = "text", val = "MRU Files:", opts = { hl = "Title", position = "left" } } },
                    get_mru()
                )
            end,
            opts = { position = "left" } -- MRU on the far left
        }

        -- Default layout configuration
        dashboard.config.layout = {
            { type = "padding", val = 1 },
            dashboard.section.header,
            { type = "padding", val = 1 },
            dashboard.section.time,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 4 },
            dashboard.section.mru,  -- MRU section fully left-aligned
            { type = "padding", val = 2 },
        }

        -- Setup alpha-nvim with the updated configuration
        alpha.setup(dashboard.opts)

        -- Update time dynamically every second
        vim.loop.new_timer():start(0, 1000, vim.schedule_wrap(function()
            dashboard.section.time.val = get_datetime()
            pcall(alpha.redraw)
        end))
    end,
}

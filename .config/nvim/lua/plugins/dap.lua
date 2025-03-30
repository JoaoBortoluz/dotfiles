local plugins = {
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
        },
    },
    {
        "mfussenegger/nvim-dap",
        config = function()

            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            -- DAP Debugger key mappings
            map("n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>", opts)
            map("n", "<F5>", "<cmd>DapContinue<CR>", opts)
            map("n", "<F11>", "<cmd>DapStepInto<CR>", opts)
            map("n", "<F10>", "<cmd>DapStepOver<CR>", opts)
            map("n", "<S-F11>", "<cmd>DapStepOut<CR>", opts)
            map("n", "<F7>", "<cmd>DapPause<CR>", opts)
            map("n", "<F6>", "<cmd>DapTerminate<CR>", opts)
            -- map("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", opts)
            -- map("n", "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<CR>", opts)
            -- map("n", "<leader>ds", "<cmd>lua require('dap.ui.widgets').scopes()<CR>", opts)

            -- Compile the current file
            map("n", "<leader>cc", ":!cd \"%:p:h\" && clang++ --debug -g \"%:p\" -o \"%:p:h/%:t:r.exe\"<CR>", { noremap = true, silent = false, desc = 'Compile the current file' })

            -- Run the compiled executable in WezTerm (shows runtime errors)
            map("n", "<leader>rr",
                ":!wezterm start --cwd \"%:p:h\" pwsh -NoExit -Command \"& \\\"%:p:h/%:t:r.exe\\\"; if ($LASTEXITCODE -ne 0) { echo 'Runtime Error: Process exited with code' $LASTEXITCODE }; Read-Host 'Press any key to exit'; exit\"<CR>",
                { noremap = true, silent = false, desc = 'Run the current file in WezTerm (PowerShell)' })

            -- Compile and run the current file in WezTerm (preserves default compile command, adds runtime error handling)
            map("n", "<leader>cr",
                ":!cd \"%:p:h\" && clang++ --debug -g \"%:p\" -o \"%:p:h/%:t:r.exe\" && wezterm start --cwd \"%:p:h\" pwsh -NoExit -Command \"& \\\"%:p:h/%:t:r.exe\\\"; if ($LASTEXITCODE -ne 0) { echo 'Runtime Error: Process exited with code' $LASTEXITCODE }; Read-Host 'Press any key to exit'; exit\"<CR>",
                { noremap = true, silent = false, desc = 'Compile and run the current file in WezTerm (PowerShell)' })
        end,
    },
}

return plugins


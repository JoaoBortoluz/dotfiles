return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",  -- Optional, for UI
        "theHamsta/nvim-dap-virtual-text",  -- Optional, for virtual text
        "nvim-neotest/nvim-nio", -- Required by nvim-dap-ui
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Set up dap-ui
        dapui.setup()

        -- Launch and terminate dap-ui automatically
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Debug Adapter configuration for C++
        dap.adapters.lldb = {
            type = "executable",
            command = "C:/Program Files/LLVM/bin/lldb-vscode.exe", -- Adjust to your system
            name = "lldb",
        }

        dap.adapters.gdb = {
            type = "executable",
            command = "C:/msys64/mingw64/bin/gdb.exe",
            name = "gdb",
        }
        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.expand("%:p:h") .. "\\", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
        }

        dap.configurations.c = dap.configurations.cpp
        vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

        -- Eval var under cursor
        vim.keymap.set("n", "<space>?", function()
            require("dapui").eval(nil, { enter = true })
        end)

        vim.keymap.set("n", "<F5>", dap.continue)
        vim.keymap.set("n", "<F10>", dap.step_over)
        vim.keymap.set("n", "<F11>", dap.step_into)
        vim.keymap.set("n", "<S-F11>", dap.step_out)
        vim.keymap.set("n", "<S-F5>", dap.step_back)
        vim.keymap.set("n", "<F6>", dap.terminate)
        vim.keymap.set("n", "<S-F6>", dap.restart)

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end,
}

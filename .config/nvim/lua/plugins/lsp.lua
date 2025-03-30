return {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        {
            'williamboman/mason.nvim', config = true
        },
        {
            'williamboman/mason-lspconfig.nvim',
            lazy = false,
            opts = {
                auto_install = true,
            },
        },
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { 'j-hui/fidget.nvim', opts = {} },
        -- 'hrsh7th/cmp-nvim-lsp',
        'saghen/blink.cmp',
    },
    config = function()
        -- local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        local on_attach = function(client, bufnr)
            local map = function(keys, func, desc, mode)
                mode = mode or 'n'
                vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
            end

            map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            map('<leader>td', require('telescope.builtin').lsp_type_definitions, '[T]ype [D]efinition')
            map('<leader>fS', require('telescope.builtin').lsp_document_symbols, '[F]ile [S]ymbols')
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            map('<leader>cfr', vim.lsp.buf.rename, '[C]ross [F]ile [R]ename')
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end

        local servers = {
            clangd = {
                cmd = { 'clangd', '--background-index', '--query-driver=C:/msys64/mingw64/bin/g++.exe' },
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
                single_file_support = true,
                root_dir = require('lspconfig').util.root_pattern(
                    '.clangd',
                    '.clang-tidy',
                    '.clang-format',
                    'compile_commands.json',
                    'compile_flags.txt',
                    'configure.ac',
                    '.git'
                ),
            },
            rust_analyzer = {},
            pylsp = {
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                        },
                    },
                },
            },
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
        }

        require('mason').setup()
        require('mason-tool-installer').setup {
            ensure_installed = { 'clangd', 'cmake', 'clang-format', "codelldb" },
        }
        require('mason-lspconfig').setup {
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name)
                    if server_name == 'clangd' then
                        require('lspconfig')[server_name].setup(servers[server_name])
                    else
                        require('lspconfig')[server_name].setup {
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = servers[server_name] and servers[server_name].settings or {},
                        }
                    end
                end,
            },
        }
    end,
}

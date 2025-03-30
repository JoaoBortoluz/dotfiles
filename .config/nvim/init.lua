require 'core.options'
require 'core.keymaps'

-- vim.cmd("language en_US")

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    require 'plugins.auto-session',

    -- require 'plugins.autocompletion_cmp',

    require 'plugins.autocompletion_blink',
    require 'plugins.bufferline',
    require 'plugins.clangd_extensions',
    require 'plugins.colortheme',
    require 'plugins.dap',
    require 'plugins.git-stuff',
    require 'plugins.indent-blankline',
    require 'plugins.lsp',
    require 'plugins.lualine',

    -- require 'plugins.mason',

    require 'plugins.misc',
    require 'plugins.neotree',
    require 'plugins.oil',

    -- require 'plugins.startscreen-alpha',

    require 'plugins.startscreen-dashboard',
    require 'plugins.telescope',
    require 'plugins.treesitter',
    require 'plugins.treesitter-context',
    require 'plugins.undotree',
    require 'plugins.vimbegood'
})

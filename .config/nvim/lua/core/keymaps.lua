-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('i', '<C-l>', '<nop>')

-- For conciseness
local opts = { noremap = true, silent = true }

-- vim.keymap.set("n", "<C-i>", "<C-i>")
-- vim.keymap.set("n", "<Tab>", "<Nop>")

-- Editor settings plugins
vim.keymap.set('v', 'J', ':m ">+1<CR>gv=gv', { desc = '[Move] selected line [down]' })
vim.keymap.set('v', 'K', ':m "<-2<CR>gv=gv', { desc = '[Move] selected line [up]' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines while keeping cursor position' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll [down] and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll [up] and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Search next and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Search previous and center' })
vim.keymap.set('n', '<leader>zig', '<cmd>LspRestart<cr>', { desc = 'Restart [LSP]' })

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = '[Paste] without overwriting clipboard' })

vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]], { desc = '[Yank] to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = '[Yank] whole line to system clipboard' })

vim.keymap.set({'n', 'v'}, '<leader>d', '"_d', { desc = '[Delete] without affecting clipboard' })

vim.keymap.set('n', '<leader>fl', vim.lsp.buf.format, { desc = '[Format] with LSP' })

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = '[Go] to next quickfix item and center' })
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = '[Go] to previous quickfix item and center' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = '[Go] to next location list item and center' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = '[Go] to previous location list item and center' })

vim.keymap.set({'n', 'v'}, '<leader>sr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[Search] and [R]eplace word under cursor' })
-- vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = '[Make] current file executable' })

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', ']b', ':bnext<CR>', opts)
vim.keymap.set('n', '[b', ':bprev<CR>', opts)
vim.keymap.set('n', '<leader>cb', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>nb', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>wv', '<C-w>v', { noremap = true, silent = true, desc = '[W]indow split [V]ertical' })
vim.keymap.set('n', '<leader>wh', '<C-w>s', { noremap = true, silent = true, desc = '[W]indow split [H]orizontal' })
vim.keymap.set('n', '<leader>wz', '<C-w>=', { noremap = true, silent = true, desc = '[W]indow equalize si[Z]e' })
vim.keymap.set('n', '<leader>wc', ':close<CR>', { noremap = true, silent = true, desc = '[W]indow [C]lose' })

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- -- Tabs
-- vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
-- vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
-- vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
-- vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Set paragraphs in Normal mode   
-- vim.keymap.set('n', '<Tab>', '>>_', { noremap = true, silent = true })
-- vim.keymap.set('n', '<S-Tab>', '<<_', { noremap = true, silent = true })

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>od', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>oq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>of', vim.lsp.buf.code_action, { desc = 'Show available fixes' })

-- compile files
vim.api.nvim_set_keymap(
    "n",
    "<F9>",
    ":w<CR>:!clang % -o %:r && echo 'Compilado com sucesso!' || echo 'Erro na compilação'<CR>",
    { noremap = true, silent = true }
)

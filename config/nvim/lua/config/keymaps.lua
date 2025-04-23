print("Loading keymaps...")
-- [[
-- NEOVIM
-- ]]

-- [[
-- PLUGINS
-- ]]

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = '[H]arpoon [A]dd file'})
vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Toggle Harpoon quick menu'})

vim.keymap.set("n", "<C-u>", function() harpoon:list():select(1) end, { desc = 'Jump to first Harpooned file' })
vim.keymap.set("n", "<C-i>", function() harpoon:list():select(2) end, { desc = 'Jump to second Harpooned file' })
vim.keymap.set("n", "<C-o>", function() harpoon:list():select(3) end, { desc = 'Jump to third Harpooned file' })
vim.keymap.set("n", "<C-p>", function() harpoon:list():select(4) end, { desc = 'Jump to fourth Harpooned file' })

vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end)

-- Telescope
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind in [B]uffers' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind in [H]elp'})
vim.keymap.set('n', '<leader>f/', builtin.current_buffer_fuzzy_find, { desc = '[F]ind in [C]urrent buffer' })
vim.keymap.set('n', '<leader>fm', function() builtin.treesitter({default_text=":method:"}) end, { desc = '[F]ind [M]ethod' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume previous' })
vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>fn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[F]ind in [N]eovim files' })


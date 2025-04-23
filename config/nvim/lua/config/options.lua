print("Loading options...")
local opt = vim.opt

-- [[
-- GENERAL
-- ]]
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
-- Unified clipboard
opt.clipboard:append("unnamedplus")
-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- [[
-- EDITOR WINDOW VISUALS
-- ]]
-- Set line for 120 characters line length
vim.opt.colorcolumn = "120"
-- Relative line numbers
vim.opt.relativenumber = true
-- Actual line number of active line
vim.opt.number = true
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false
-- Keep signcolumn on the left of the screen turned on by default
vim.opt.signcolumn = 'yes:1'
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- Show which line your cursor is on
vim.opt.cursorline = true
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 12
-- Enable break indent
vim.opt.breakindent = true
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[
-- MOUSE
-- ]]
-- Disable the mouse while in nvim
opt.mouse = ""
vim.opt.mousescroll = "ver:0,hor:0"


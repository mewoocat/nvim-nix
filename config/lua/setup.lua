
-- Globals
--------------------------------------------------------------
vim.g.mapleader = " " -- Set leader to space


-- Setup pywal
--------------------------------------------------------------
--local pywal = require('pywal')
--pywal.setup()
--vim.cmd.colorscheme = "wal" -- use wal or fork it.  pywal-nvim is borked for reload
--vim.cmd("colorscheme pywal") -- Appears to require theme reload for syntax colors
---- DO I even need pywal for syncing terminal (pywal) colors with nvim???


-- Sorta works (maybe look into this later)
--local neopywal = require("neopywal")
--neopywal.setup()
--vim.cmd.colorscheme("neopywal")

-- Setup neogit
--------------------------------------------------------------
local neogit = require('neogit')
neogit.setup {}

-- Setup coc
--------------------------------------------------------------


-- Setup telescope
--------------------------------------------------------------
require('telescope').setup{
    pickers = {
        buffers = {
            sort_lastused = true,
            sort_mru = true,
            ignore_current_buffer = true,
        }
    }
}
local builtin = require('telescope.builtin') -- Import telescope functions
vim.keymap.set('n', '<leader>o', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>p', builtin.buffers, {})




-- Options
--------------------------------------------------------------
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus" -- External clipboard support
vim.opt.number = true
--vim.opt.relativenumber = true
vim.opt.mouse = ""

--vim.opt.termguicolors = true

-- Disables kitty padding on entry and enables on exit
-- Only needed when settings a specific theme since the padding in kitty will not match the bg color
--[[
vim.cmd [[
augroup kitty_mp
  autocmd!
  au VimLeave * if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=default margin=default
  au VimEnter * if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=0 margin=0
augroup END
]]
--]]


-- Tab config
vim.opt.tabstop = 4 -- A TAB character looks like 2 spaces
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Mappings
--------------------------------------------------------------
vim.keymap.set('n', "<Leader>e", ":Neotree toggle right<cr>")
vim.keymap.set('n', '<leader>n', ":bnext<cr>", {})
vim.keymap.set('n', '<leader>b', ":bprev<cr>", {})
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleMouse>", "<Nop>") -- Disable middle mouse paste
vim.keymap.set('n', '<leader>g', ":Neogit<cr>", {})
vim.keymap.set('n', '<leader>w', ":bd<cr>")

--vim.cmd("nnoremap <silent> <esc><esc> :nohlsearch<CR><esc>")


-- Per filetype config
--------------------------------------------------------------

-- opt_local only affects the current buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function() 
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})










-- Testing
--------------------------------------------------------------
--vim.cmd("autocmd BufWritePost ~/.cache/wal/colors-wal.vim :source ~/.config/nvim/init.lua")
--vim.api.nvim_create_autocmd({"BufWritePost"}, {
--    pattern = {"/home/eXia/.cache/wal/colors-wal.vim"},
--    --command = ":source /home/eXia/.config/nvim/init.lua",
--    command = "colorscheme pywal",
--})

-- Define a function to set the colorscheme to pywal
--local function set_pywal_colorscheme()
--    vim.cmd('colorscheme pywal')
--end

--vim.cmd [[
--augroup AutoPywal
--  autocmd!
--  au BufWritePost ~/.cache/wal/colors-wal.vim colorscheme pywal
--augroup END
--]]

-- Auto sets wal theme on startup
--[[
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*",
  command = "colorscheme wal",
})
--]]

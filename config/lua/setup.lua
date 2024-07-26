
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


-- Only apply neopywal theme if wallust template is found
local neopywalPath = vim.env.HOME .. "/.cache/wallust/colors_neopywal.vim"
local neopywalFile = io.open(neopywalPath, "r")
if (neopywalFile ~= nil) then
    
    -- Close file handle 
    neopywalFile.close()

    -- Works :)
    local neopywal = require("neopywal")
    neopywal.setup({

        plugins = {
            neotree = true,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,

                -- Can either be:
                --   - A color exported by "get_colors()" (e.g.: `color8`)
                --   - A hexadecimal color (e.g.: "#ff0000").
                --   - A function with an optional "C" parameter that returns one of the two options above.
                --     e.g: function(C) return C.color1 end
                scope_color = "",
            }
        },
        -- Uses a template file `~/.cache/wallust/colors_neopywal.vim` instead of the
        -- regular pywal template at `~/.cache/wal/colors-wal.vim`.
        use_wallust = true,

        -- This option allows to specify where Neopywal should look for a ".vim" template file
        -- (e.g.: os.getenv("HOME") .. "/.cache/wal/custom_neopywal_template.vim").
        colorscheme_file = "",

        -- This option allows to use a custom built-in theme palettes like "catppuccin-mocha" or "tokyonight".
        -- To get the list of available themes take a look at `https://github.com/RedsXDD/neopywal.nvim#Alternative-Palettes`.
        -- Take note that this option takes precedence over `use_wallust` and `colorscheme_file`.
        use_palette = "",

        -- Sets the background color of certain highlight groups to be transparent.
        -- Use this when your terminal opacity is < 1.
        transparent_background = true,

        -- With this option you can overwrite all the base colors the colorscheme uses.
        -- For more information take a look at `https://github.com/RedsXDD/neopywal.nvim#Customizing-Colors`
        custom_colors = {},

        -- With this option you can overwrite any highlight groups set by the colorscheme.
        -- For more information take a look at `https://github.com/RedsXDD/neopywal.nvim#Customizing-Highlights`
        custom_highlights = {},

        -- Dims the background when another window is focused.
        dim_inactive = true,

        -- Apply colorscheme for Neovim's terminal (e.g. `g:terminal_color_0`).
        terminal_colors = true,

        -- Shows the '~' characters after the end of buffers.
        show_end_of_buffer = false,

        -- Shows the '|' split separator characters.
        -- It's worth noting that this options works better in conjunction with `dim_inactive`.
        show_split_lines = true,

        no_italic = false, -- Force no italic.
        no_bold = false, -- Force no bold.
        no_underline = false, -- Force no underline.
        no_undercurl = false, -- Force no undercurl.
        no_strikethrough = false, -- Force no strikethrough.

        -- Handles the styling of certain highlight groups (see `:h highlight-args`).
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            includes = { "italic" },
            strings = {},
            variables = { "italic" },
            numbers = {},
            booleans = {},
            types = { "italic" },
            operators = {},
        },

        -- Setting this to false disables all default file format highlights.
        -- Useful if you want to enable specific file format options.
        -- Defaults to false when treesitter is enabled,
        -- unless manually enabled inside the `setup()` function.
        default_fileformats = true,

        -- Setting this to false disables all default plugin highlights.
        -- Useful if you want to enable specific plugin options.
        default_plugins = true,

        -- For more fileformats options please scroll down (https://github.com/RedsXDD/neopywal.nvim#Fileformats)
        fileformats = {
            c_cpp = true,
            c_sharp = true,
        },

    })

    vim.cmd.colorscheme("neopywal")

    -- Use fwatch to watch for changes in wallust theme
    local fwatch = require('fwatch')
    fwatch.watch(vim.env.HOME .. "/.cache/wallust/colors_neopywal.vim", "colorscheme neopywal")

else
    -- Do nothing right now
end


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
vim.opt.laststatus = 0 -- Never show status line
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

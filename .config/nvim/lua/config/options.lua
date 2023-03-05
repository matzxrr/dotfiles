vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_banner = 0 -- Hide banner
vim.g.netrw_keepdir = 0 -- Keep browser in sync with dir
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+' -- hide dot files

local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.mouse = nil
opt.autowrite = true -- Save on next
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enabled highlight of the current line

-- wtf is this
opt.formatoptions = "jcroqlnt" -- tcqj

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = false -- Hide invisible characters (tabs...
opt.number = true -- Print line number
opt.relativenumber = true -- Show relative line numbers
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.scrolloff = 8 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shortmess:append { W = true, I = true, c = true }
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolum, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.spelllang = { "en", "cjk" }
opt.spellsuggest = "best,9"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true --Put new windows right of current
-- opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Comand-Line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.hlsearch = false
opt.incsearch = true
opt.swapfile = false
opt.backup = false

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess:append { C = true }
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0


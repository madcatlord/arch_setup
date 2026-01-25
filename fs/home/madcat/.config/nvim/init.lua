-- Set <space> as the leader key
--	NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- This makes sure that hyprland can identify neovim windows
vim.o.title = true
vim.o.titlestring = "neovim"

-- [[ Setting options ]]
-- See `:help vim.o`
--	For more options, you can see `:help option-list`

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = ""
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false

-- vim.keymap.set("x", ">", ">gv", {})

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--	Schedule the setting after `UiEnter` because it can increase startup-time.
--	Remove this option if you want your OS clipboard to remain independent.
--	See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true
vim.o.breakindentopt = "list:-1" -- This makes bullet points and the like have their wrapped lines appear not beneath the bullet point, but rather the first character after the actual bullet point
vim.o.wrap = true
vim.o.linebreak = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--	See `:help 'list'`
--	and `:help 'listchars'`
--
--	Notice listchars is set using `vim.opt` instead of `vim.o`.
--	It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--	 See `:help lua-options`
--	 and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 8

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = false

-- [[ Basic Keymaps ]]
--	See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--	See `:help hlsearch`
-- NOTE: Moved this to the lsp-config file, because there the ESC functionality is extended
-- TODO: Should group all keymaps in their own file
-- vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--	Use CTRL+<hjkl> to switch between windows
--
--	See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "[S]ave" })
vim.keymap.set("n", "<Leader>rt", [[:set noexpandtab<CR>:%retab!<CR>:set expandtab<CR>]], { desc = "[R]e[T]ab" })

-- [[ Basic Autocommands ]]
--	See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--	Try it with `yap` in normal mode
--	See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Load separated config files
require("winbar")

-- [[ Install `lazy.nvim` plugin manager ]]
--		See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--	To check the current status of your plugins, run
--		:Lazy
--
--	You can press `?` in this menu for help. Use `:q` to close the window
--
--	To update plugins you can run
--		:Lazy update
--
require("lazy").setup({
	{
		"NMAC427/guess-indent.nvim",
		opts = {
			on_tab_options = {
				["tabstop"] = 4,
				["shiftwidth"] = 4,
				["expandtab"] = false,
			},
			-- EXP: This does not really seem needed
			-- NOTE: This is necessary since guess-indent doesn't fuck with the builtin nvim and treesitters indention system, which we need for proper JSX indention... ALLEGEDLY, not sure if this is actually any issue
			-- filetype_exclude = { "javascriptreact", "typescriptreact" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
			highlight = { max_line_len = 1024 },
			keywords = {
				TMP = { icon = "", color = "temporary" },
				EXP = { icon = "󰙨", color = "experimental" },
			},
			colors = {
				temporary = "#D9A7B5",
				experimental = "#5A3E85",
			},
		},
	},

	-- Sort recently used files by an algorithm that takes frequency and recency of use into account
	{
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},

	{ import = "plugins" },
	{ import = "colorschemes" },
	--
	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	-- Or use telescope!
	-- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
	-- you can continue same window with `<space>sr` which resumes last telescope search
})

-- Set colorscheme
vim.cmd.colorscheme("gruvbox")

-- Custom script that introduces a way to execute (run) code files
require("executer")

------- KEYMAPS CUSTOM --------
-- Open docs window and instantly tab into it (overrides default behaviour for K, where it does not tab into it)
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Show Documentation" })

-- Keep selection when changing indentation while in any visual mode
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Go to error, primarily intended for use with harper spelling errors
vim.keymap.set("n", "ghb", vim.diagnostic.goto_prev, { desc = "Previous Error" })
vim.keymap.set("n", "ghn", vim.diagnostic.goto_next, { desc = "Next Error" })

-- Overwrite keymaps which are set from plugins
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- Autlist overwrites the default redo command, so here we reinstutate it
		vim.keymap.set("n", "<C-r>", "<C-r>", { noremap = true })
	end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

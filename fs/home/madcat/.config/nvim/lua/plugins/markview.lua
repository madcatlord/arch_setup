vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		local opts = { buffer = true, noremap = true, silent = true, expr = true }
		vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", opts)
		vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", opts)
		vim.keymap.set("n", "0", "g0")
		vim.keymap.set("n", "$", "g$")
	end,
})

return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	---@type markview.config
	opts = {
		preview = {
			debounce = 0,
			icon_provider = "mini",
			linewise_hybrid_mode = true,
			edit_range = { 0, 0 },
			draw_range = { 0.8 * vim.o.lines, 0.8 * vim.o.lines },

			-- NOTE: Just having hybrid on in insert-mode produces bad results, because switching from insert to normal mode will leave the currently selected line in the edit-state, even though it should be the read-state
			modes = { "n", "no", "i" },
			hybrid_modes = { "n", "i" },

			callbacks = {
				-- FIX: Doesnt work
				on_mode_change = function()
					vim.notify("TESTING")
					print("TEST2")
					-- if mode == "n" then
					-- 	vim.cmd("Markview render " .. buf)
					-- 	print("THIS TRIGGERED")
					-- end
				end,
				-- WARN: This seems to break more than it fixed
				-- on_enable = function(_, win)
				-- 	vim.wo[win].conceallevel = 2 -- set conceal level
				-- 	vim.wo[win].concealcursor = "c"
				-- end,
			},
		},
		markdown = {
			list_items = {
				wrap = false,
				marker_minus = {
					add_padding = false,
				},
				marker_dot = {
					add_padding = false,
				},
			},
		},
	},

	-- Completion for `blink.cmp`
	dependencies = { "saghen/blink.cmp" },
}

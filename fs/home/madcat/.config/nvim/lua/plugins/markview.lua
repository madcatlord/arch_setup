return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	---@type markview.config
	opts = {
		preview = {
			debounce = 0,
			icon_provider = "mini",
			linewise_hybrid_mode = true,
			edit_range = { 2, 2 },
			draw_range = { 0.8 * vim.o.lines, 0.8 * vim.o.lines },
		},
	},

	-- Completion for `blink.cmp`
	dependencies = { "saghen/blink.cmp" },
}

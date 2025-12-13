vim.keymap.set("n", "gtc", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = "[G]o [T]o [C]ontext", silent = true })

local set_sep = function()
	-- This makes it so that the context differentiates itself from the regular content

	-- NOTE: Remnants of me trying to invert colors of fg and bg
	-- local hl = vim.api.nvim_get_hl(0, { name = "NormalFloat" })

	-- Color attempt
	-- local bgc = "#1e1c1b"
	-- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = bgc })

	-- Border attempt
	vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
end

return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup()
		--
		-- Set the hl colors of the context
		set_sep()

		-- This makes sure the ColorScheme doesn't overwrite it
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				set_sep()
			end,
		})
	end,
}

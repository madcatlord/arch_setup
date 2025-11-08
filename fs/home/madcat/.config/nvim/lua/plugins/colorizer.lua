return {
	"norcalli/nvim-colorizer.lua",
	version = "*",
	config = function()
		require("colorizer").setup({
			"*",
		}, {
			css = true,
		})
	end,
}

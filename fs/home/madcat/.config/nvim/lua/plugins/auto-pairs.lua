return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
	priority = 100, -- NOTE: So that this loads before autolist FIX: Doesnt do shit
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
}

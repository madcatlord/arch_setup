-- NOTE: I tried to remove no-neck-pain on BufLeave, but that enters an infinite loop.
-- BufEnter opens the side-buffers, which center the actual buffer. But BufLeave for some reason triggers on BufEnter too, which disables the side-buffers. Them being closed for some reason triggers BuffEnter, which enables them again, and so on.
-- I have not yet found a fix, but removing BufLeave autocmd will at least prevent the infinite loop
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(event)
		if vim.bo[event.buf].buftype ~= "" then
			return
		end
		if vim.bo[event.buf].filetype ~= "markdown" then
			return
		end

		require("no-neck-pain").enable()
	end,
})

return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	keys = {
		{ "<leader>zc", "<cmd>NoNeckPain<CR>", desc = "[C]enter Buffer" },
	},
	opts = {
		width = 90,
		buffers = {
			colors = {
				blend = -0.2,
			},
			wo = {
				fillchars = "eob: ",
			},
		},
		config = function() end,
	},
}

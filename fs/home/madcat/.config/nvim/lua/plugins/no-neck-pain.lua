-- NOTE: I tried to remove no-neck-pain on BufLeave, but that enters an infinite loop.
-- BufEnter opens the side-buffers, which center the actual buffer. But BufLeave for some reason triggers on BufEnter too, which disables the side-buffers. Them being closed for some reason triggers BuffEnter, which enables them again, and so on.
-- I have not yet found a fix, but removing BufLeave autocmd will at least prevent the infinite loop
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(event)
		if vim.bo[event.buf].buftype ~= "" then
			return
		end

		local ft = vim.bo[event.buf].filetype

		-- NOTE: Since we'd usually be working on an Android project if these filetypes come up, this makes sure that the sidebuffers are aligned in a way that the emulator can float on the right side without obstructing view
		if ft == "typescriptreact" or ft == "typescript" then
			require("no-neck-pain").config.buffers.left.enabled = false
			require("no-neck-pain").config.width = 65
			require("no-neck-pain").enable()
		end

		if ft == "markdown" then
			require("no-neck-pain").enable()
			return
		end
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

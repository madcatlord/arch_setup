-- PYTHON ONLY
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function(args)
		-- Important stuff
		local bufnr = args.buf

		-- Shortcuts
		local aktc = '; read -n 1 -s -r -p "Press any key to close..."' -- AnyKeyToClose, makes the terminal await a keypress in order to close immediately

		-- Keymaps
		-- Run the currently focused file in buffer
		vim.keymap.set("n", "<leader>ee", function()
			local file = vim.fn.expand("%:p")
			local cwd = vim.fn.getcwd()
			vim.fn.jobstart({
				"alacritty",
				"--working-directory",
				cwd,
				"--command",
				"sh",
				"-c",
				"uv run " .. vim.fn.shellescape(file) .. aktc,
			}, { detach = true })
		end, { desc = "[E]xecute [C]urrent File", buffer = bufnr })

		-- This does not immediately execute the file, but rather prepoluates the terminal with the execution line -- allowing the user to input args
		vim.keymap.set("n", "<leader>ea", function()
			local file = vim.fn.expand("%")
			local cwd = vim.fn.getcwd()

			os.execute("alacritty --working-directory " .. cwd .. " &")
			-- short delay to let terminal appear
			vim.wait(300)
			-- type the command using wtype
			os.execute(string.format('wtype "uv run %s -- "', file))
		end, { desc = "[E]xecute Current File With [A]rgs", buffer = bufnr })

		-- NOTE: This does NOT work. It should run the root file of the project
		vim.keymap.set("n", "<leader>er", function()
			local cwd = vim.fn.getcwd()
			vim.fn.jobstart({
				"alacritty",
				"--working-directory",
				cwd,
				"--command",
				"sh",
				"-c",
				"uv run $(uv project script)" .. aktc,
			}, { detach = true })
		end, { desc = "[E]xecute [R]oot File", buffer = bufnr })
	end,
})

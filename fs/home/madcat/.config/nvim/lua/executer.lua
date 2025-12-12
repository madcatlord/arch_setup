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

		-- NOTE: This runs the main.py file at the root of the python project (name needs to match)
		vim.keymap.set("n", "<leader>er", function()
			local cwd = vim.fn.getcwd()

			local venv_path = vim.fn.getenv("VIRTUAL_ENV")
			if not venv_path or venv_path == "" then
				return nil
			end
			--
			-- remove trailing slash (optional)
			venv_path = venv_path:gsub("[/\\]+$", "")
			-- strip last directory
			local root_dir = venv_path:match("^(.*)[/\\][^/\\]+$")

			vim.fn.jobstart({
				"alacritty",
				"--working-directory",
				cwd,
				"--command",
				"sh",
				"-c",
				"uv run " .. root_dir .. "/main.py" .. aktc,
			}, { detach = true })
		end, { desc = "[E]xecute [R]oot File", buffer = bufnr })
	end,
})

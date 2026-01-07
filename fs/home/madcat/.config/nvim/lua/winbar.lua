-- NOTE: This is stolen from https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/config/options.lua
-- Its purpose is to add a sort of statusline at the top of the window, which shows the current amount of buffers loaded, the filename and the absolute path to the file
--
-- Winbar
-- Function to shorten long paths (> shorten_if_more_than real dirs)
local function shorten_path(path)
	local shorten_if_more_than = 6 -- change this to 5, 7, etc
	-- Strip and remember the root ("/" or "~/")
	local prefix = ""
	if path:sub(1, 2) == "~/" then
		prefix = "~/"
		path = path:sub(3)
	elseif path:sub(1, 1) == "/" then
		prefix = "/"
		path = path:sub(2)
	end
	-- Split the remaining path into its components
	local parts = {}
	for part in string.gmatch(path, "[^/]+") do
		table.insert(parts, part)
	end
	-- Shorten only when there are more than shorten_if_more_than directories
	if #parts > shorten_if_more_than then
		local first = parts[1]
		local last_four = table.concat({
			parts[#parts - 3],
			parts[#parts - 2],
			parts[#parts - 1],
			parts[#parts],
		}, "/")
		return prefix .. first .. "/../" .. last_four
	end

	-- Re-attach the prefix when no shortening is needed
	return prefix .. table.concat(parts, "/")
end
-- Function to get the full path and replace the home directory with ~
local function get_winbar_path()
	local full_path = vim.fn.expand("%:p:h")
	return full_path:gsub(vim.fn.expand("$HOME"), "~")
end
-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
	return vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
end
-- Function to update the winbar
local function update_winbar()
	local home_replaced = get_winbar_path()
	local buffer_count = get_buffer_count()
	local display_path = shorten_path(home_replaced)
	vim.opt.winbar = "%#WinBar1#%m "
		.. "%#WinBar2#("
		.. buffer_count
		.. ") "
		-- this shows the filename on the left
		.. "%#WinBar3#"
		.. vim.fn.expand("%:t")
		-- This shows the file path on the right
		.. "%*%=%#WinBar1#"
		.. display_path
	-- I don't need the hostname as I have it in lualine
	-- .. vim.fn.systemlist("hostname")[1]
end
-- Winbar was not being updated after I left lazygit
vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged" }, {
	callback = function(args)
		local old_mode = args.event == "ModeChanged" and vim.v.event.old_mode or ""
		local new_mode = args.event == "ModeChanged" and vim.v.event.new_mode or ""
		local do_update = false

		-- Only update if ModeChanged is relevant (e.g., leaving LazyGit)
		if args.event == "ModeChanged" then
			-- Get buffer filetype
			local buf_ft = vim.bo.filetype
			-- Only update when leaving `snacks_terminal` (LazyGit)
			if buf_ft == "snacks_terminal" or old_mode:match("^t") or new_mode:match("^n") then
				do_update = true
			end
		else
			do_update = true
		end

		-- print("BUFS: " .. args.buf .. " " .. args.event .. " " .. args.file .. " " .. args.id)
		-- This should prevent sidebars from no-neck-pain to have winbars FIX: But it doesnt, I think thats because winbar is not buffer specific, but rather is set for every buffer, thusly the main file sets the winbar, and the side-buffers therefore still show it
		if do_update and args.file ~= "" then
			update_winbar()
		end
	end,
})

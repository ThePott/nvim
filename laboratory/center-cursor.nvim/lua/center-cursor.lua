--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
local M = {}
local trigger = function()
	local windowInfo = vim.fn.winsaveview()
	local lineNumber = windowInfo.lnum
	local halfHeight = math.floor(vim.fn.winheight(0) / 2)
	local targetTopline = lineNumber - halfHeight
	if windowInfo.topline == targetTopline then
		return -- Already at desired position
	end

	vim.fn.winrestview({
		topline = targetTopline,
	})

	local changedWindowInfo = vim.fn.winsaveview()
	local text = "target:"
		.. targetTopline
		.. " || "
		.. "actual:"
		.. changedWindowInfo.topline
		.. " || "
		.. "half:"
		.. halfHeight
		.. " || "
		.. "line:"
		.. lineNumber
	print(text)
end

local actOnMove = function()
	trigger()
end

local add_top_padding = function()
	-- Create namespace for our virtual lines
	local ns_id = vim.api.nvim_create_namespace("center_cursor_padding")

	-- Clear any existing extmarks first
	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

	-- Add 5 virtual empty lines above line 1
	vim.api.nvim_buf_set_extmark(0, ns_id, 0, 0, {
		virt_lines = {
			{ { "", "Normal" } }, -- Virtual line 1
			{ { "", "Normal" } }, -- Virtual line 2
			{ { "", "Normal" } }, -- Virtual line 3
			{ { "", "Normal" } }, -- Virtual line 4
			{ { "", "Normal" } }, -- Virtual line 5
		},
		virt_lines_above = true,
	})

	print("Added 5 virtual lines above line 1")
end

M.add_top_padding = add_top_padding

M.trigger = trigger

M.setup = function()
	local scrollWatcherGroup = vim.api.nvim_create_augroup("ScrollWatcher", { clear = true })

	vim.api.nvim_create_autocmd({ "CursorMoved" }, {
		group = scrollWatcherGroup,
		pattern = "*",
		callback = actOnMove,
	})
	vim.keymap.set("n", "<leader>tt", trigger, { desc = "[T]est [T]rigger" })
	vim.o.scrolloff = 0
end
return M
--
--
--
--

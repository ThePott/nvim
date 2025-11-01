local M = {}

local printOnTrigger = function()
	print("----", "scrolloff", vim.o.scrolloff, "win cur line", vim.fn.winline())
end

M.printOnTrigger = printOnTrigger

M.setup = function()
	local scrollWatcherGroup = vim.api.nvim_create_augroup("ScrollWatcher", { clear = true })

	vim.api.nvim_create_autocmd({ "CursorMoved", "WinScrolled" }, {
		group = scrollWatcherGroup,
		pattern = "*",
		callback = printOnTrigger,
	})
end
return M

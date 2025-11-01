local M = {}
local scrolloff = vim.o.scrolloff

print("---- yeah loaded for sure")

local printOnTrigger = function()
	print("----re-locate-cursor")
	local win_height = vim.fn.winheight(0)

	vim.o.scrolloff = win_height % 2 == 0 and scrolloff - 1 or scrolloff
end

M.printOnTrigger = printOnTrigger
return M

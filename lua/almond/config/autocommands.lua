local nvim_create_autocmd = vim.api.nvim_create_autocmd

nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.fn.system("im-select com.apple.keylayout.ABC")
	end,
})

nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("only")
	end,
})

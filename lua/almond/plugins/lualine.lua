local function getProjectName()
	local project_path = vim.fn.getcwd()
	local project_name = project_path:match("([^/]+)$")
	return project_name
end

-- print(getProjectName())
local function getFilePath()
	return vim.fn.expand("%")
end

-- print(vim.fn.expand("%"))

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		sections = {
			lualine_a = {
				"mode",
				{ getProjectName },
			},
			lualine_c = {
				{ getFilePath },
			},
			lualine_x = {},
			lualine_y = {},
		},
	},
}

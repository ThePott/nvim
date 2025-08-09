local function files_first_sorter(nodes)
	table.sort(nodes, function(a, b)
		-- If one is a file and the other is a directory, file comes first
		if a.type == "file" and b.type == "directory" then
			return true
		elseif a.type == "directory" and b.type == "file" then
			return false
		else
			-- If both are the same type, sort alphabetically by name
			return a.name < b.name
		end
	end)
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	-- lazy = false,
	dependencies = { "nvim-material-icon" },
	opts = {
		view = {
			width = 35,
			relativenumber = true,
			side = "right",
		},
		renderer = {
			indent_markers = { enable = true },
			icons = { glyphs = { folder = { arrow_closed = "", arrow_open = "" } } },
		},
		actions = {
			open_file = {
				window_picker = { enable = false },
				quit_on_open = true,
			},
		},
		filters = {
			custom = { ".DS_Store" },
			git_ignored = false,
		},
		sort = { sorter = files_first_sorter },
	},
	keys = {
		{ "<leader>eo", "<cmd>NvimTreeFindFile<CR>", desc = "[E]xplorer [O]pen" },
		{ "<leader>em", "<cmd>NvimTreeClose<CR>", desc = "[E]xplorer [M]inimize" },
		{ "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "[E]xplorer [R]efresh" },
		{ "<leader>ew", "<cmd>NvimTreeCollapse<CR>", desc = "[E]xplorer collapse u[W]u" },
	},
}

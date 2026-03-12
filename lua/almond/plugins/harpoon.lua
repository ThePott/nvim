return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		settings = {
			save_on_toggle = true,
		},
	},
	keys = function()
		local keys = {
			{
				"<leader>hf",
				function()
					require("harpoon"):list():add()
				end,
				desc = "[H]arpoon [F]ile",
			},
			{
				"<leader>ho",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "[H]arpoon [O]pen",
			},
			{
				"<M-.>",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon to File 1",
			},
			{
				'<M-">',
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon to File 2",
			},
			{
				"<M-=>",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon to File 3",
			},
			{
				"<M-/>",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon to File 4",
			},
			{
				"<M-->",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "Harpoon to File 5",
			},
			{
				"<M-`>",
				function()
					require("harpoon"):list():select(6)
				end,
				desc = "Harpoon to File 6",
			},
			{
				"<M-;>",
				function()
					require("harpoon"):list():select(7)
				end,
				desc = "Harpoon to File 7",
			},
		}
		return keys
	end,
}

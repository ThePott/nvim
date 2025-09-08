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
		}

		-- Option + 1-9 for files 1-9
		for i = 1, 9 do
			table.insert(keys, {
				"<M-" .. i .. ">", -- M = Meta/Option key on macOS
				function()
					require("harpoon"):list():select(i)
				end,
				desc = "Harpoon to File " .. i,
			})
		end

		-- Option + 0, -, = for files 10, 11, 12
		local extra_keys = {
			{ "<M-0>", 10, "Harpoon to File 10" },
		}

		for _, key_info in ipairs(extra_keys) do
			table.insert(keys, {
				key_info[1],
				function()
					require("harpoon"):list():select(key_info[2])
				end,
				desc = key_info[3],
			})
		end

		return keys
	end,
}

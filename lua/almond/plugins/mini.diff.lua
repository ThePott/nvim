return {
	"nvim-mini/mini.diff",
	version = false,
	config = function()
		local MiniDiff = require("mini.diff")
		MiniDiff.setup({
			view = {
				style = "sign",
				signs = { add = " ", change = " ", delete = " " },
				priority = 0,
			},
		})

		local function show_overlay(buf_id)
			buf_id = buf_id or vim.api.nvim_get_current_buf()
			local buf_data = MiniDiff.get_buf_data(buf_id)
			if buf_data and not buf_data.overlay then
				MiniDiff.toggle_overlay(buf_id)
			end
		end

		local function hide_overlay(buf_id)
			buf_id = buf_id or vim.api.nvim_get_current_buf()
			local buf_data = MiniDiff.get_buf_data(buf_id)
			if buf_data and buf_data.overlay then
				MiniDiff.toggle_overlay(buf_id)
			end
		end

		vim.keymap.set("n", "<leader>go", show_overlay, { desc = "[G]it [O]verlay" })
		vim.keymap.set("n", "<leader>gp", hide_overlay, { desc = "[G]it colla[P]se" })
	end,
}

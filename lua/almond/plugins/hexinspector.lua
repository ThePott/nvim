vim.pack.add({ "https://github.com/Punity122333/hexinspector.nvim" })

local hexinspector = require("hexinspector")

vim.keymap.set("n", "<leader>dm", hexinspector.open, { desc = "Debugger open memory view" })
vim.keymap.set("n", "<leader>dM", function()
    vim.ui.input({ prompt = "File path: ", default = vim.fn.expand("%:p") }, function(input)
        if input and input ~= "" then
            require("hexinspector").open(input)
        end
    end)
end, { desc = "Debugger open memory view" })

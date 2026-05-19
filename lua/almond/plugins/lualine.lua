local function getProjectName()
    local project_path = vim.fn.getcwd()
    local project_name = project_path:match("([^/]+)$")
    return project_name
end

local function getFilePath()
    return vim.fn.expand("%")
end

vim.pack.add({
    "https://www.github.com/nvim-tree/nvim-web-devicons",
    "https://www.github.com/nvim-lualine/lualine.nvim",
})
require("lualine").setup({
    sections = {
        lualine_a = {
            "mode",
            -- { getProjectName },
        },
        lualine_c = {
            { getFilePath },
        },
        lualine_x = {},
        lualine_y = {},
    },
})

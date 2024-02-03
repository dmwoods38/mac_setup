return {
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        name = "onedark",
        style = "deep",
        config = function()
            vim.cmd.colorscheme("onedark")
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "onedark",
        },
    },
}

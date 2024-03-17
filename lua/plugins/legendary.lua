return {
    {
        "mrjones2014/legendary.nvim",
        version = "v2.1.0",
        priority = 999,
        lazy = false,
        config = function()
            require("legendary").setup({})
        end,
    },
    {
        "stevearc/dressing.nvim",
        priority = 999,
        lazy = false,
        config = function()
            require("dressing").setup()
        end,
    },
}

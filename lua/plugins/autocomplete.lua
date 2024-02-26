return {

    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP autocompletions
                    { name = "luasnip" }, -- For luasnip users.
                    { name = "buffer" }, -- Autocompletions from current buffer
                    { name = "calc" }, -- Autocomplete mathematical expressions
                    { name = "digraphs" }, -- Autocomplete digraphs
                    {
                        name = "async_path", -- Autocomplete with path objects, directories run async to avoid blocking nvim when many directories are traveresed
                        option = {
                            trailing_slash = true,
                        },
                    },
                }),
            })
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/cmp-nvim-lsp",
    },
}

return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- Formatters
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.formatting.pyink,
                    null_ls.builtins.formatting.beautysh,
                    null_ls.builtins.formatting.yamlfix,
                    null_ls.builtins.formatting.jsonnetfmt,

                    -- Diagnostics
                    null_ls.builtins.diagnostics.alex,
                    null_ls.builtins.diagnostics.checkmake,
                    null_ls.builtins.diagnostics.cppcheck, -- cppcheck needs to be installed on the system
                },
            })
        end,
    },
}

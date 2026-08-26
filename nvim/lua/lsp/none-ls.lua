local null = require("null-ls")

null.setup({
  sources = {
    -- Python
    null.builtins.formatting.black,
    -- Lua
    null.builtins.formatting.stylua,
  },
})

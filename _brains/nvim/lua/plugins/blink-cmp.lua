return {
  "saghen/blink.cmp",
  dependencies = { "giuxtaposition/blink-cmp-copilot" },
  opts = {

    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          kind = "Copilot",
          score_offset = -100,
          async = true,
        },
      },
    },

    keymap = {
      preset = "default",
      ["<C-y>"] = { "select_and_accept" },
    },
  },
}

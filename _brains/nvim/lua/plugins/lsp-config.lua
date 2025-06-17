return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      --QML support
      qmlls = {
        cmd = { "qmlls6" },
        filetypes = { "qml", "qmljs" },
      },
      -- --
    },
  },
}

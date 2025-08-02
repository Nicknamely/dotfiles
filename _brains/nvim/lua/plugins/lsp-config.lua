return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      --QML
      qmlls = {
        cmd = { "qmlls6" },
        filetypes = { "qml", "qmljs" },
      },
      --clangd
      clangd = {
        init_options = {
          fallbackFlags = {
            -- "--all-scopes-completion",
            -- "--background-index",
            -- "--clang-tidy",
            -- "--header-insertion=iwyu",
            -- "--suggest-missing-includes",
            -- "--std=c23",
            "-Wall",
            "-Wextra",
          },
        },
      },
    },
  },
}

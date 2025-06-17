return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = function()
    require("live-server").setup({
      args = { "--browser=chromium" }, -- Change 'firefox' to your preferred browser
    })
  end,
  keys = {
    { "<leader>dv", "<cmd>LiveServerToggle<cr>", desc = "toggle Live server" },
  },
}

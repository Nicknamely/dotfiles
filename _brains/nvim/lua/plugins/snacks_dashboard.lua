local dasboard_handle_header = io.popen("figlet -f ANSI-Shadow '" .. os.date("%A") .. "'")
local today_date = dasboard_handle_header:read("*a")
dasboard_handle_header:close()
return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,

        header = string.format("%s", today_date),
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {
          fg = "#a6adc8",
        }),
        vim.api.nvim_set_hl(0, "SnacksDashboardKey", {
          fg = "#a6adc8",
        }),
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", {
          fg = "#a6adc8",
        }),
        vim.api.nvim_set_hl(0, "SnacksDashboardIcon", {
          fg = "#a6adc8",
        }),
      },

      -- Layout
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
  keys = {
    {
      "<leader>qh",
      function()
        require("snacks.dashboard").open()
      end,
      desc = "Snacks Dashboard",
    },
  },
}

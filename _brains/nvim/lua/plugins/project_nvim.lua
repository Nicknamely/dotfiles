return {
  "coffebar/neovim-project",
  opts = {
    projects = { -- define project roots
      "~/.Dotfiles/*/.config/*",
      "~/Projects/01-personal/actual-projects/*",
      "~/Projects/01-personal/challenges/self-thought/*",
      "~/Projects/01-personal/codecademy/Full-Stack_Engineer/02-Building_Interative_Website/*",
      "~/Projects/01-personal/challenges/frontend-mentor/Newbie/html-css/*",
      "~/Projects/01-personal/experiments/*",
    },
    dashboard_mode = true,
    picker = {
      type = "snacks.nvim", -- or "fzf-lua"
    },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "Shatur/neovim-session-manager" },
    --   -- optional picker
    --   { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
    --   -- optional picker
    --   { "ibhagwan/fzf-lua" },
  },
  lazy = false,
  priority = 100,
}

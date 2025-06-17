require("config.lazy")

-- neovide configuration
if vim.g.neovide then
  --background
  vim.g.neovide_opacity = 0.75
  --padding
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- Hide Mouse when typing
  vim.g.neovide_hide_mouse_when_typing = true

  --Dynamically change scale at runtime
  vim.g.neovide_scale_factor = 0.9
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)
end

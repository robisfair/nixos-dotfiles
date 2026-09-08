return {
  -- 1. Setup neanias's pure Lua Everforest repository
  {
    "neanias/everforest-nvim",
    priority = 1000, -- Make sure it loads immediately on startup
    lazy = false,
    opts = {
      background = "soft", -- Options: "hard", "medium", "soft"
      transparent_background_level = 0, -- 0: solid, 1: transparent buffers, 2: transparent float menus too!
      ui_contrast = "low",
      dim_inactive_windows = false,
    },
    config = function(_, opts)
      -- Initialize the configuration options
      require("everforest").setup(opts)

      -- Load the colorscheme
      require("everforest").load()

      -- Ensure floating menus and neo-tree are also perfectly cleared out
      local hl = vim.api.nvim_set_hl
      hl(0, "NormalFloat", { bg = "none" })
      hl(0, "FloatBorder", { bg = "none" })
      hl(0, "NeoTreeNormal", { bg = "none" })
      hl(0, "NeoTreeNormalNC", { bg = "none" })
    end,
  },

  -- 2. Direct LazyVim to prioritize Everforest over defaults
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}

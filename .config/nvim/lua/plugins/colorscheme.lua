return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night", -- Select the “night” variant
      transparent = true, -- Enable global transparency
      styles = {
        sidebars = "transparent", -- Transparent sidebars
        floats = "transparent", -- Transparent floating windows
      },
    },
    -- Ensure the colorscheme is applied after setup
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}

return {
  "nvim-telescope/telescope.nvim",
  opts = function()
    return {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "__pycache__",
          "%.pyc", -- Regex to match .pyc extension
          ".venv",
          -- Add any other patterns you want to ignore
        },
      },
    }
  end,
}

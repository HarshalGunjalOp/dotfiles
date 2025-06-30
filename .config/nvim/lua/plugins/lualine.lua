return {
  "nvim-lualine/lualine.nvim",
  config = function()
    -- Patch the 'auto' theme to make all backgrounds transparent
    local auto = require("lualine.themes.auto")
    for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive", "terminal" }) do
      if auto[mode] and auto[mode].c then
        auto[mode].c.bg = "NONE"
      end
      -- Optionally, you can set ALL sections to NONE for full transparency
      -- (Uncomment the following if you want all sections transparent)
      -- for _, section in ipairs({ "a", "b", "c", "x", "y", "z" }) do
      --   if auto[mode] and auto[mode][section] then
      --     auto[mode][section].bg = "NONE"
      --   end
      -- end
    end

    require("lualine").setup({
      options = {
        theme = auto, -- Use our patched theme
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" }, -- Typo fixed: should be ""
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 }, -- **Corrected below!**
        },
      },
    })

    -- Hide native statusline

    if vim.env.TMUX == nil then
      vim.o.laststatus = 3 -- or 2, depending on your preference
    else
      vim.o.laststatus = 0
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE")
        vim.cmd("hi lualine_c_normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi lualine_c_insert guibg=NONE ctermbg=NONE")
        vim.cmd("hi lualine_c_visual guibg=NONE ctermbg=NONE")
        vim.cmd("hi lualine_c_replace guibg=NONE ctermbg=NONE")
        vim.cmd("hi lualine_c_command guibg=NONE ctermbg=NONE")
        vim.cmd("hi lualine_c_inactive guibg=NONE ctermbg=NONE")
      end,
    })

    -- Failsafe for plugin conflicts
    vim.api.nvim_create_autocmd("VimEnter", {
      pattern = "*",
      callback = function()
        vim.o.laststatus = 0
      end,
    })
  end,
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
  },
  sections = {
    lualine_a = {
      { "mode", separator = { right = "", left = " " } },
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = {
      { "location", separator = { right = " ", left = "" } },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  -- sections = {
  --   lualine_a = {
  --     { "mode", separator = { right = "", left = " " } },
  --   },
  --   lualine_b = { "branch", "diff", "diagnostics" },
  --   lualine_c = { "filename" },
  --   lualine_x = { "encoding", "fileformat" },
  --   lualine_y = { "filetype", "progress" },
  --   lualine_z = {
  --     { "location", separator = { right = " ", left = "" } },
  --   },
  --   inactive_sections = {
  --     lualine_a = { "filename" },
  --     lualine_b = {},
  --     lualine_c = {},
  --     lualine_x = {},
  --     lualine_y = {},
  --     lualine_z = { "location" },
  --   },
  -- },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})

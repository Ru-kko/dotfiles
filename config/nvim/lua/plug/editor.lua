return {
  -- Tabs
  {
    "akinsho/bufferline.nvim",
    after = "catppuccin",
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        diagnostics_indicator = function(_, _, diag)
          local ret = (diag.error and " " .. diag.error .. " " or "")
              .. (diag.warning and " " .. diag.warning or "")
          return vim.trim(ret)
        end,
      },
    },
    keys = {
      {
        "<leader><tab>",
        function()
          require("bufferline").cycle(1)
        end,
        mode = { "n", "i", "v" },
      },
      {
        "<S-tab>",
        function()
          require("bufferline").cycle(-1)
        end,
        mode = { "n", "i", "v" },
      },
    },
    config = function(_, opts)
      opts.highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
      })
      require("bufferline").setup(opts)
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  -- Error highlighting
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup({
        signs = {
          error = " ",
          warning = " ",
          hint = " ",
          information = " ",
          other = "﫠",
        },
      })
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>q", "<cmd>Trouble<CR>" },
    },
  },
  -- Code collapse
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "AerialNavToggle",
    },
    keys = {
      { "<leader>zz", "<cmd>AerialToggle<CR>", mode = "n" },
    },
    opts = {
      layout = {
        placement = "edge",
        default_direction = "float",
      },
      keymaps = {
        ["<"] = "actions.tree_decrease_fold_level",
        [">"] = "actions.tree_increase_fold_level",
      },
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
    config = true,
  },
  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cond = (vim.fn.executable("git") == 1 or (vim.fn.executable("curl") == 1 and vim.fn.executable("tar") == 1)),
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSConfigInfo",
      "TSDisable",
      "TSEditQuery",
      "TSEditQueryUserAfter",
      "TSEnable",
      "TSInstall",
      "TSInstallFromGrammar",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSToggle",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    init = function()
      if vim.fn.argc() >= 1 then
        require("lazy").load({ plugins = { "nvim-treesitter" } })
      end
    end,
    config = function()
      require("plug.treesitter")
    end,
  },
}

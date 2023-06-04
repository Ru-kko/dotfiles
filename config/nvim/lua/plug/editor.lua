return {
  -- git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      end,
    },
  },
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
        "<leader>k",
        function()
          require("bufferline").cycle(1)
        end,
      },
      {
        "<leader>j",
        function()
          require("bufferline").cycle(-1)
        end,
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
  -- Spits
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to left split",
        mode = { "n", "i", "v" },
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to right split",
        mode = { "n", "i", "v" },
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to above split",
        mode = { "n", "i", "v" },
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to below split",
        mode = { "n", "i", "v" },
      },
      {
        "<S-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize split down",
        mode = { "n", "i", "v" },
      },
      {
        "<S-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize split up",
        mode = { "n", "i", "v" },
      },
      {
        "<S-l>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize split right",
        mode = { "n", "i", "v" },
      },
      {
        "<S-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize split left",
        mode = { "n", "i", "v" },
      },
    },
    opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
  },
}

local configs = require("nvim-treesitter.configs")
---@diagnostic disable-next-line: missing-fields
configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "diff",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "git_rebase",
    "vimdoc",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "r",
    "regex",
    "sql",
    "tsx",
    "typescript",
    "vim",
    "yaml",
    "astro",
  },
  auto_install = true,
  highlight = {
    enable = true,                    -- false will disable the whole extension
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end
  },
  indent = { enable = true, disable = { "yaml" } },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@block.outer",
        ["if"] = "@block.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    autotag = {
      enable = true,
    },
  }
}
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })


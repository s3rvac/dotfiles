-------------------------------------------------------------------------------
-- Plugins (management, settings).
-------------------------------------------------------------------------------

-- Using the lazy.nvim plugin manager.
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install and set up all the plugins.
require("lazy").setup({
  -- Nvim Treesitter configurations and abstraction layer
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
      "nvim-treesitter/nvim-treesitter",
      tag = "v0.9.2",
      build = ":TSUpdate",
      config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
              "bash",
              "c",
              "cmake",
              "cpp",
              "css",
              "csv",
              "diff",
              "dockerfile",
              "doxygen",
              "gitignore",
              "go",
              "haskell",
              "html",
              "java",
              "javascript",
              "json",
              "kotlin",
              "latex",
              "llvm",
              "lua",
              "markdown",
              "markdown_inline",
              "php",
              "proto",
              "python",
              "ruby",
              "rust",
              "sql",
              "terraform",
              "toml",
              "vim",
              "vimdoc",
              "xml",
              "yaml",
            },
            sync_install = false,
            highlight = {
              enable = true,
              -- Disable treesitter highlighting for the following file types
              -- as the original, non-treesitter, regex-based version looks
              -- better, at least at the moment.
              disable = {
                "gitcommit",
                "python",
                "toml",
              },

              -- Do not combine Vim's regex-based highlighting with
              -- Treesitter's highlighting.
              additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
              enable = false,
            },
            indent = {
              enable = false
            },
          })
      end
  },

  -- Fuzzy finding, grepping, etc.
  -- https://github.com/ibhagwan/fzf-lua
  {
    "ibhagwan/fzf-lua",
  },

  -- GitHub Copilot.
  -- https://github.com/github/copilot.vim
  {
    "github/copilot.vim",
    tag = "v1.16.0",
  },

  -- Snippets.
  -- https://github.com/SirVer/ultisnips
  {
    "SirVer/ultisnips",
  },

  -- Automatic detection of file encodings.
  -- https://github.com/s3rvac/AutoFenc
  {
    "s3rvac/AutoFenc",
  },

  -- Replace text with the contents of a register, without overwriting the
  -- register.
  -- https://github.com/inkarkat/vim-ReplaceWithRegister
  {
    "inkarkat/vim-ReplaceWithRegister",
  },

  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease.
  -- https://github.com/tpope/vim-surround
  {
    "tpope/vim-surround",
  },

  -- Enable repeating supported plugin maps with ".".
  -- https://github.com/tpope/vim-repeat
  {
    "tpope/vim-repeat",
  },

  -- Quick commenting and uncommenting of code.
  -- https://github.com/tomtom/tcomment_vim
  {
    "tomtom/tcomment_vim",
  },

  -- A Git wrapper.
  -- https://github.com/tpope/vim-fugitive
  {
    "tpope/vim-fugitive",
  },

  -- A Git commit browser.
  --https://github.com/junegunn/gv.vim
  {
    "junegunn/gv.vim",
  },

  -- Various wrappers around shell commands, e.g. to rename or delete a file
  -- from within Vim.
  -- https://github.com/tpope/vim-eunuch
  {
    "tpope/vim-eunuch",
  },

  -- Wrap and unwrap function arguments, lists, and dictionaries.
  -- https://git.foosoft.net/alex/vim-argwrap
  {
    url = "https://git.foosoft.net/alex/vim-argwrap",
    tag = "24.1.15.0",
  },

  -- Additional text objects or text-object-related plugins.
  -- https://github.com/wellle/targets.vim
  {
    "wellle/targets.vim",
  },
  -- https://github.com/michaeljsmith/vim-indent-object
  {
    "michaeljsmith/vim-indent-object",
  },
  -- https://github.com/christoomey/vim-sort-motion
  {
    "christoomey/vim-sort-motion",
  },

  -- Nyancat in Vim :-)
  -- https://github.com/koron/nyancat-vim
  {
    "koron/nyancat-vim",
  },

  -- Vim syntax highlighting for YARA rules.
  -- https://github.com/s3rvac/vim-syntax-yara
  {
    "s3rvac/vim-syntax-yara",
  },

  -- Themes, mainly for testing purposes as I use my own colorscheme.
  -- https://github.com/aktersnurra/no-clown-fiesta.nvim
  {
    "aktersnurra/no-clown-fiesta.nvim",
  },
  -- https://github.com/EdenEast/nightfox.nvim
  {
    "EdenEast/nightfox.nvim",
  },
},
{
  lockfile = vim.fn.stdpath("config") .. "/data/lazy.vim/lazy-lock.json"
})

--------------------------------------
-- Fzf (fuzzy finding, grepping, etc.)
--------------------------------------

-- Mappings.
local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>fb', fzf.buffers, {})
vim.keymap.set('n', '<leader>fc', fzf.command_history, {})
vim.keymap.set('n', '<leader>ff', fzf.files, {})
vim.keymap.set('n', '<leader>fgb', fzf.git_branches, {})
vim.keymap.set('n', '<leader>fgc', fzf.git_commits, {})
vim.keymap.set('n', '<leader>fgC', fzf.git_bcommits, {})
vim.keymap.set('n', '<leader>fgs', fzf.git_status, {})
vim.keymap.set('n', '<leader>fgt', fzf.git_tags, {})
vim.keymap.set('n', '<leader>fr', fzf.resume, {})
vim.keymap.set('n', '<leader>fs', fzf.search_history, {})
vim.keymap.set('n', '<leader>/', fzf.live_grep_native, {})
vim.keymap.set('n', '<leader>*', fzf.grep_cword, {})

-- Configuration.
local fzf_defaults = require('fzf-lua.defaults').defaults;
require("fzf-lua").setup {
  winopts = {
    preview = {
      -- Decrease the width of the preview window to have more available space
      -- for file names.
      horizontal = 'right:50%',
    },
  },
  fzf_colors = {
    -- Use the same colors as I use in the shell version of fzf.
    ["hl"]  = { "fg", "Statement" },
    ["hl+"] = { "fg", "Statement" },
  },
  files = {
    -- Disable icons (speedup + it more resembles fzf in the shell).
    git_icons = false,
    file_icons = false,
  },
  grep = {
    -- 1) Make ripgrep search also in hidden files/directories when grepping.
    -- 2) Use the same colors as I have defined for grep, git grep, etc.
    rg_opts = "--hidden --colors \"match:fg:0xff,0xff,0x60\" --colors \"match:bg:black\" --colors \"match:style:bold\" " .. fzf_defaults.grep.rg_opts,
  },
}

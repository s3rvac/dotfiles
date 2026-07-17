-- GitHub Copilot with chat support
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  commit = "2025f92022bef434de0511c5157a19974a9377a4", -- 2026-06-02
  dependencies = {
    -- For regular Copilot usage.
    { "github/copilot.vim" },
    -- For curl, log, and async functions.
    { "nvim-lua/plenary.nvim", commit = "74b06c6c75e4eeb3108ec01852001636d85a932b" },
  },
  build = "make tiktoken",
  event = "VeryLazy",
  config = function()
    local copilot_chat = require("CopilotChat")
    copilot_chat.setup({
      mappings = {
        reset = {
          normal = "<C-x>",
          insert = "<C-x>",
        },
        submit_prompt = {
          normal = "<C-s>",
          insert = "<C-s>",
        },
        show_help = {
          normal = "g?",
        },
      },
      prompts = {
        -- Code related prompts.
        Documentation = {
          prompt = "Provide documentation for the following code.",
        },
        Explain = {
          prompt = "Explain how the following code works.",
          system_prompt = "COPILOT_EXPLAIN",
        },
        FixCode = {
          prompt = "Fix the following code to make it work as intended.",
        },
        FixError = {
          prompt = "Explain the error in the following text and provide a solution.",
        },
        Namings = {
          prompt = "Provide better names for the following variables and functions.",
        },
        Refactor = {
          prompt = "Refactor the following code to improve its clarity and readability.",
        },
        Review = {
          prompt = "Review the following code and provide suggestions for improvement.",
          system_prompt = "COPILOT_REVIEW",
        },
        Tests = {
          prompt = "Explain how the selected code works, then generate unit tests for it.",
        },

        -- Text related prompts.
        Grammar = {
          prompt = "Correct any grammar and spelling errors in the following text. Use American English.",
        },
        Summarize = {
          prompt = "Summarize the following text.",
        },
        Wording = {
          prompt = "Correct any grammar and spelling errors in the following text. Improve the wording to make it more professional and concise. Use American English. Preserve formatting.",
        },
      },
    })

    -- Keymaps.
    vim.keymap.set("n", "<Leader>gcc", ":CopilotChatToggle<CR>")
    -- Select a prompt to be be used on the buffer.
    vim.keymap.set("n", "<Leader>gcp", function()
      copilot_chat.select_prompt({ context = { "buffers" } })
    end)
    -- Select a prompt to be be used on the highligted block.
    vim.keymap.set("x", "<Leader>gcp", copilot_chat.select_prompt)
    -- Reword the file / block.
    vim.keymap.set("n", "<Leader>gcw", "ggVG:CopilotChatWording<CR>")
    vim.keymap.set("x", "<Leader>gcw", ":CopilotChatWording<CR>")
  end,
}

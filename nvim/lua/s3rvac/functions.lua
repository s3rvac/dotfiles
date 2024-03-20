local M = {}

-- Is the given file or program executable?
function M.is_executable(file_or_prog)
  return vim.fn.executable(file_or_prog) == 1
end

-- Returns true if Neovim is running inside a GUI (e.g. nvim-qt), false
-- otherwise.
function M.is_running_in_gui()
  -- This condition works for nvim-qt (which is what I use), but I do not know
  -- whether it works for other GUIs as well.
  return vim.o.term == "nvim"
end

-- Unpacks the given table.
function M.unpack(t)
  -- Before Lua 5.2, unpack() was a global function. Since Lua 5.2, unpack() is
  -- at table.unpack().
  if table.unpack then
    return table.unpack(t)
  else
    return unpack(t)
  end
end

-- Returns a path to the given config file of a tool.
function M.tool_config_path_for(config_file)
  return vim.fn.stdpath("config") .. "/data/configs/" .. config_file
end

-- Returns a path to the given Mason-provided executable.
function M.mason_bin_path_to(executable)
  return vim.env.HOME .. "/.local/share/nvim/mason/bin/" .. executable
end

-- Returns true if the given Mason-provided executable exists, false otherwise.
function M.mason_bin_exists(executable)
  return vim.fn.executable(M.mason_bin_path_to(executable)) == 1
end

-- Returns keymap options with sensible defaults that can be overridden.
function M.keymap_opts(t)
  return {
    buffer = t["buffer"] ~= nil and t["buffer"] or false,
    desc = t["desc"] ~= nil and t["desc"] or "",
    expr = t["expr"] ~= nil and t["expr"] or false,
    noremap = t["noremap"] ~= nil and t["noremap"] or true,
    silent = t["silent"] ~= nil and t["silent"] or true,
  }
end

-- Sets the selected indent style for the current buffer.
local function set_indent_style(use_spaces, indent_length)
  vim.opt_local.expandtab = use_spaces
  vim.opt_local.tabstop = indent_length
  vim.opt_local.softtabstop = indent_length
  vim.opt_local.shiftwidth = indent_length
end

-- Sets the indent style for the current buffer to tabs.
function M.set_indent_style_to_tabs()
  set_indent_style(false, 4)
end

-- Sets the indent style for the current buffer to 4 spaces.
function M.set_indent_style_to_4_spaces()
  set_indent_style(true, 4)
end

-- Sets the indent style for the current buffer to 2 spaces.
function M.set_indent_style_to_2_spaces()
  set_indent_style(true, 2)
end

-- Interactively selects and prints a new indentation style for the current
-- buffer.
function M.select_indent_style()
  vim.ui.select(
    { "tabs", "4 spaces", "2 spaces" },
    { prompt = "Select indent style:" },
    function(choice)
      if choice == "tabs" then
        M.set_indent_style_to_tabs()
        print("Indent: tabs")
      elseif choice == "4 spaces" then
        M.set_indent_style_to_4_spaces()
        print("Indent: 4 spaces")
      elseif choice == "2 spaces" then
        M.set_indent_style_to_2_spaces()
        print("Indent: 2 spaces")
      end
    end
  )
end

-- Open the given link in a browser.
function M.open_link(link)
  vim.fn.jobstart({ "xdg-open", link })
end

-- Creates a (1) Man command and (2) filetype <Leader>man autocommand for
-- opening documentation for (1) the selected symbol and (2) the symbol under
-- the cursor in a web browser.
function M.create_man_cmd_and_ft_autocmd_for_opening_docs(ft_group, ft_pattern, link_prefix)
  vim.api.nvim_create_autocmd("FileType", {
    group = ft_group,
    pattern = ft_pattern,
    callback = function()
      local function open_docs_for_symbol(symbol)
        local complete_link = link_prefix .. symbol
        print("Opening " .. complete_link)
        M.open_link(complete_link)
      end

      -- :Man <symbol>
      vim.api.nvim_create_user_command("Man", function(t)
        open_docs_for_symbol(t.args)
      end, {
        nargs = 1,
        desc = "Open documentation for the given symbol in a web browser",
      })

      -- <Leader>man
      vim.keymap.set(
        "n",
        "<Leader>man",
        function()
          -- When selecting the word under the cursor, include the dot to match
          -- e.g. "sys.exit" instead of just "exit".
          local orig_iskeyword = vim.bo.iskeyword
          vim.bo.iskeyword = vim.bo.iskeyword .. ",."
          local symbol = vim.fn.expand("<cword>")
          vim.bo.iskeyword = orig_iskeyword

          open_docs_for_symbol(symbol)
        end,
        M.keymap_opts({
          buffer = true,
          desc = "Open documentation for the symbol under the cursor in a web browser",
        })
      )
    end,
    desc = "FileType " .. ft_pattern .. ": Command for <Leader>man",
  })
end

return M

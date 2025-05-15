-- Always display a statusline.
vim.opt.laststatus = 2

-- Since I'm using a statusline, disable ruler.
vim.opt.ruler = false

------- Encoding and line endings for the statusline -------

local function encoding_and_line_ending()
  local encoding = vim.bo.fenc == "" and vim.o.enc or vim.bo.fenc
  local bom = vim.bo.bomb and ",BOM" or ""
  local line_ending = vim.bo.ff
  return string.format("[%s%s,%s]", encoding, bom, line_ending)
end

------- LSP/linter/formatter-related parts of the statusline -------

local function attached_lsp_clients()
  local attached_clients = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, vim.bo.filetype) ~= -1 then
      table.insert(attached_clients, client.name)
    end
  end
  return table.concat(attached_clients, ", ")
end

local function enabled_linters()
  local lint_loaded, lint = pcall(require, "lint")
  if not lint_loaded then
    -- The plugin is not available right now (this can happen during the
    -- very first plugin installation).
    return ""
  end

  local linters_enabled = {}
  for _, linter in ipairs(lint._resolve_linter_by_ft(vim.bo.filetype)) do
    if lint.linters[linter].enabled then
      table.insert(linters_enabled, linter)
    end
  end
  return table.concat(linters_enabled, ", ")
end

local function enabled_formatters()
  local conform_loaded, conform = pcall(require, "conform")
  if not conform_loaded then
    -- The plugin is not available right now (this can happen during the
    -- very first plugin installation).
    return ""
  end

  local formatters_enabled = {}
  local formatters_by_ft = conform.formatters_by_ft[vim.bo.filetype] or {}
  for _, formatter in ipairs(formatters_by_ft) do
    if conform.formatters[formatter].enabled then
      table.insert(formatters_enabled, formatter)
    end
  end
  return table.concat(formatters_enabled, ", ")
end

local function is_lsp_progressing()
  return vim.lsp.status() ~= ""
end

local function lsp_linter_formatter_status()
  return string.format(
    "[%s%s,%s,%s]",
    attached_lsp_clients() ~= "" and "lsp" or "-",
    is_lsp_progressing() and "*" or "",
    enabled_linters() ~= "" and "lnt" or "-",
    enabled_formatters() ~= "" and "fmt" or "-"
  )
end

------- Statusline itself -------

function Statusline()
  local parts = {
    -- Path to the file in the buffer.
    "%<%f",
    -- Flags (e.g. [+], [RO]).
    "%h%w%m%r%k",
    -- Encoding and line ending.
    encoding_and_line_ending(),
    -- File type.
    "%y",
    -- Is LSP/linter/formatter enabled for the current buffer?
    lsp_linter_formatter_status(),
    -- Line and column numbers.
    "[%l/%L (%p%%),%v]",
  }
  return table.concat(parts, " ")
end

vim.opt.statusline = "%!v:lua.Statusline()"

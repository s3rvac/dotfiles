-- Snippets.
-- https://github.com/SirVer/ultisnips
return {
  "SirVer/ultisnips",
  event = {
    "BufReadPre *.snippets",
    "InsertEnter",
  },
}

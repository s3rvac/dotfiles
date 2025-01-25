-- Stuff just for fun with no practical use :-).
return {
  {
    -- Nyancat in Vim.
    -- https://github.com/koron/nyancat-vim
    "koron/nyancat-vim",
    commit = "6454a2765e31db8099f6ba665eb2d2aa23ea357d", -- 2021-03-21
    cmd = { "Nyancat", "Nyancat2" },
  },
  {
    -- Cellular automaton simulation in Vim.
    -- https://github.com/Eandrju/cellular-automaton.nvim
    "Eandrju/cellular-automaton.nvim",
    commit = "11aea08aa084f9d523b0142c2cd9441b8ede09ed", -- 2024-06-30
    cmd = { "CellularAutomaton", "CA1", "CA2", "CA3" },
    config = function()
      vim.api.nvim_create_user_command("CA1", "silent! CellularAutomaton game_of_life", {})
      vim.api.nvim_create_user_command("CA2", "silent! CellularAutomaton make_it_rain", {})
      vim.api.nvim_create_user_command("CA3", "silent! CellularAutomaton scramble", {})
    end,
  },
}

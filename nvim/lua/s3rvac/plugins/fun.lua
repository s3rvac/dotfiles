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
    commit = "b7d056dab963b5d3f2c560d92937cb51db61cb5b", -- 2023-09-01
    cmd = { "CellularAutomaton", "CA1", "CA2", "CA3" },
    config = function()
      vim.api.nvim_create_user_command("CA1", "silent! CellularAutomaton game_of_life", {})
      vim.api.nvim_create_user_command("CA2", "silent! CellularAutomaton make_it_rain", {})
      vim.api.nvim_create_user_command("CA3", "silent! CellularAutomaton scramble", {})
    end,
  },
}

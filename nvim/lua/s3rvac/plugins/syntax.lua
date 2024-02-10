return {
  -- Syntax highlighting for Kotlin.
  -- Note: The treesitter-based one works but (1) looks worse than this one and
  -- (2) takes around 0.5s to load.
  -- https://github.com/udalov/kotlin-vim
  {
    "udalov/kotlin-vim",
    ft = "kotlin",
  },
  -- Syntax highlighting for Terraform.
  -- Note: The treesitter-based one works but looks a bit worse than this one.
  -- https://github.com/hashivim/vim-terraform
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "terraform-vars", "hcl" },
  },
  -- Syntax highlighting for YARA rules.
  -- https://github.com/s3rvac/vim-syntax-yara
  {
    "s3rvac/vim-syntax-yara",
    ft = "yara",
  },
  -- Syntax highlighting for Jira issues.
  -- https://github.com/s3rvac/vim-syntax-jira
  {
    "s3rvac/vim-syntax-jira",
    ft = "jira",
  },
}

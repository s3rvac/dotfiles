-- Automatic detection of file encodings.
-- https://github.com/s3rvac/AutoFenc
return {
  "s3rvac/AutoFenc",
  config = function()
    -- Settings.
    vim.g.autofenc_ext_prog_path = "enca"

    -- I am from the Czech Republic, so assume that input files are in a
    -- Czech-specific encoding when running enca. This improves detection.
    vim.g.autofenc_ext_prog_args = "-i -L czech"

    -- This is what enca prints when the encoding cannot be detected.
    vim.g.autofenc_ext_prog_unknown_fenc = "???"

    -- Sometimes, enca detects UTF-7, which is almost always invalid detection.
    vim.g.autofenc_enc_blacklist = "utf-7"
  end,
}

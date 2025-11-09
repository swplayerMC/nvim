return { -- this string here is an alias to use in 'vim.lsp.enable()'
  cmd = { "lua-language-server" }, -- this need to match the name in ':Mason' > '(2) LSP' tab
  filetypes = { "lua" }, -- the file extentions to apply
  root_markers = { -- some file or folder names to help
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
}

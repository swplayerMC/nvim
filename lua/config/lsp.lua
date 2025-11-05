-- Example configuration with Lua
vim.lsp.config("lua_ls", { -- this string here is an alias to use in 'vim.lsp.enable()'
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
})

vim.lsp.config("csharp_ls", {
  cmd = { "csharp-language-server" },
  filetypes = { "cs" },
  root_markers = {
    ".git",
    "obj",
    "bin",
    "Program.cs",
    ".csproj"
  }
})

vim.lsp.config("python_ls", {
  cmd = { "pyright" },
  filetypes = { "py" },
  root_markers = {
    "__pycache__",
    ".git"
  }
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("csharp_ls")
vim.lsp.enable("python_ls")

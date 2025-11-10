vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.clipboard = "xclip"
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<C-e>", "<cmd>Neotree<CR>")

vim.keymap.set("n", "[t", 
  function()
    require("todo-comments").jump_prev() 
  end, { desc = "Previous todo comment" })


vim.keymap.set("n", "]t", 
  function()
    require("todo-comments").jump_next() 
  end, { desc = "Next todo comment" })


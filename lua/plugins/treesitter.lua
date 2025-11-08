return {
    "nvim-treesitter/nvim-treesitter", branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
	    highlight = { enable = true, },
	    indent = { enable = true },
	    autotage = { enable = true },
	    ensure_installed = {
		"lua",
		"c",
		"c_sharp",
		"python",
		"bash"
	    },
	    auto_install = false
	})
    end
}

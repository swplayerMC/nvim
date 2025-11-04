return {

    "folke/which-key.nvim",
    dependencies = {

	{ "nvim-mini/mini.icons", version = false },
	{ "nvim-tree/nvim-web-devicons" }
    },
    event = "VeryLazy",
    opts = {
    -- configs here, leave empty to use defaults
    },
    keys = {

	{

	    "<leader>?",
	    function()
		require("which-key").show({ global = false })
	    end,
	    desc = "Buffer Local Keymaps (which-key)",
	},
    }
}

return {
    {
	-- This helps with ssh tunneling and copying to clipboard
	"ojroques/vim-oscyank",
	config = function()
	    vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator')
	    vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
	    vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')
	end
    },
    {
	-- Git plugin
	"tpope/vim-fugitive"
    },
    {
	-- Show CSS colors
	"brenoprata10/nvim-highlight-colors",
	config = function()
	    require("nvim-highlight-colors").setup({})
	end
    },
    {

	"lewis6991/gitsigns.nvim",
	-- Command:
	-- Gitsigns toggle_current_line_blame  
    },
}

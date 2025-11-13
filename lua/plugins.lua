return {
    -- // Language Servers Setup // --
    {
	"nvim-treesitter/nvim-treesitter", branch = "master",
	lazy = false,
	build = ":TSUpdate",
	opts = {
	    highlight = { enable = true, },
	    indent = { enable = true },
	    autotage = { enable = true },
	    ensure_installed = {
		"lua",
		"c",
	    },
	    auto_install = false
	}
    },
    {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
	    {
		"mason-org/mason.nvim",
		opts = {
		    ui = {
			icons = {
			    package_installed = "✓",
			    package_pending = "➜",
			    package_uninstalled = "✗"
			}
		    }
		},
	    },
	    {
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		opts = {
		    servers = {
			lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
			c_ls = {}
		    }
		},
		config = function (_, opts)
		    for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges
			-- with the capabilities in your `opts[server].capabilities`
			-- if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			vim.lsp.config(server, config)
		    end
		end
	    }
	}
    },
    -- // Debuging Setup... i think // --
    {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	dependencies = { "nvim-tree/nvim-web-devicons",
	    {
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
	        priority = 1000,
		config = function()
		    require("tiny-inline-diagnostic").setup({
			preset = "powerline",
			options = {
			    multilines = { enabled = true, always_show = true },
			    -- show_source = { enabled = true },
			    show_all_diags_on_cursorline = true,
			    show_diags_only_under_cursor = false
			}
		    })
		    vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
		end
	    }
	},
	keys = {
	    {
		"<leader>xx",
		"<cmd>Trouble diagnostics toggle<cr>",
		desc = "Diagnostics (Trouble)"
	    },
	    {
		"<leader>xX",
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		desc = "Buffer Diagnostics (Trouble)"
	    },
	    {
		"<leader>cs",
		"<cmd>Trouble symbols toggle focus=false<cr>",
		desc = "Symbols (Trouble)"
	    },
	    {
		"<leader>cl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		desc = "LSP Definitions / references / ... (Trouble)"
	    },
	    {
		"<leader>xL",
		"<cmd>Trouble loclist toggle<cr>",
		desc = "Location List (Trouble)"
	    },
	    {
		"<leader>xQ",
		"<cmd>Trouble qflist toggle<cr>",
		desc = "Quickfix List (Trouble)"
	    }
	}
    },
    -- // Web Development Setup // --
    {
    },
    -- // Telescope, Harpoon and Fuzzy Finds // --
    {
	"nvim-telescope/telescope.nvim", tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
	    local builtin = require('telescope.builtin')
	    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
	    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
	    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
	    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	end,
    },
    {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
	    local conf = require("telescope.config").values
	    local themes = require("telescope.themes")

	    local function toggle_telescope(harpoon_files)
		local file_paths = {}
		for _, item in ipairs(harpoon_files.items) do
		    table.insert(file_paths, item.value)
		end
		local opts = themes.get_ivy({ prompt_title = "Working List" })

		require("telescope.pickers").new(opts, {
		    finder = require("telescope.finders").new_table({
		    results = file_paths,
		}),
		previewer = conf.file_previewer(opts),
		sorter = conf.generic_sorter(opts),
		}):find()
	    end

	    local harpoon = require("harpoon")

	    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
	    vim.keymap.set("n", "<leader>r", function() harpoon:list():remove() end)
	    vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
	    vim.keymap.set("n", "<leader>fl", function() toggle_telescope(harpoon:list()) end,
		{ desc = "Open Harpoon list in Telescope" })

	    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
	    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
	    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
	    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

	    -- Toggle previous & next buffers stored within Harpoon list
	    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
	    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
	end
    },
    -- // GitHub helpers // --
    {
	"tpope/vim-fugitive"
    },
    {
	-- With the 'command' you can see the Git status
	-- of the cursor line, like in VS Code
	"lewis6991/gitsigns.nvim",
	-- Command:
	-- Gitsigns toggle_current_line_blame  
    },
    -- // Setting Themes and color related things // --
    {
	-- The color theme is this
	"folke/tokyonight.nvim",
	config = function()
	    vim.cmd.colorscheme "tokyonight"
	    -- The line below makes the background transparent
	    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	end
    },
    {
	-- Show Hexadecimal codes colors
	"brenoprata10/nvim-highlight-colors",
	opts = {}
	-- config = function()
	--   require("nvim-highlight-colors").setup({})
	-- end
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons"
	},
	opts = {
	    theme = "tokyonight"
	},
    },
    {
	-- TODO: maybe changing some colors would be cool
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
	-- your configuration comes here
	-- or leave it empty to use the default settings
	}
    },
    -- // Keymap and typing related plugins // --
    {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
	    "neovim/nvim-lspconfig",
	    "hrsh7th/cmp-nvim-lsp",
	    "hrsh7th/cmp-buffer",
	    "hrsh7th/cmp-path",
	    "hrsh7th/cmp-cmdline",
	    {
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
		    -- TODO: see :h blink-cmp-keymap for defining your own keymap
		    keymap = { preset = "default" },
		}

	    },
	},
	config = function()
	    local cmp = require("cmp")

	    cmp.setup({
		snippet = {
		    expand = function(args)
			vim.snippet.expand(args.body)
		    end
	    },
	    window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	    },
	    mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
		    -- Prefer jumping if both jumping and expanding are available
		    -- Otherwise, you may recursively expand a snippet without ever jumping
		    -- (which is annoying)
		    if cmp.visible() then
			cmp.select_next_item()
		    else
			fallback()
		    end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
		    -- Prefer jumping if both jumping and expanding are available
		    -- Otherwise, you may recursively expand a snippet without ever jumping
		    -- (which is annoying)
		    if cmp.visible() then
			cmp.select_prev_item()
		    else
			fallback()
		    end
		end, { "i", "s" }),
	    }),
	    sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "html-css" },
	    }, {
		    {
			name = "buffer",
			option = {
			    keyword_pattern = [[\k\+]],
			    -- Enable completion from all visible buffers
			    get_bufnrs = function()
				local bufs = {}
				for _, win in ipairs(vim.api.nvim_list_wins()) do
				    bufs[vim.api.nvim_win_get_buf(win)] = true
				end
				return vim.tbl_keys(bufs)
			    end,
			},
		    }
		})
	    })
	    cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
		    { name = "path" },
		    { name = "cmdline" }
	        }),
		matching = { disallow_symbol_nonprefix_matching = false },
	    })

	    -- Set up LSP config --
	    local capabilities = require("cmp_nvim_lsp").default_capabilities()
	    vim.lsp.config("lua_ls", {
		capabilities = capabilities
	    })
	    vim.lsp.config("c_ls", {
		capabilities = capabilities
	    })
	end
    },
    {
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
    },
    {
        "windwp/nvim-autopairs",
	event = "InsertEnter",
        config = true,
	opts = {}
    },
    {
        "numToStr/Comment.nvim",
	opts = {},
    }
}

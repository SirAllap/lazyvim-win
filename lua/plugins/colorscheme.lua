return {
	{
		"EdenEast/nightfox.nvim",
		opts = {},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			flavour = "macchiato",
			transparent_background = false,
			term_colors = true,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				functions = { "bold" },
				keywords = { "bold" },
				types = { "italic", "bold" },
				variables = {},
			},
			integrations = {
				telescope = true,
				treesitter = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "storm",
		},
	},
	{
		"shaunsingh/moonlight.nvim",
		init = function()
			vim.g.moonlight_italic_comments = true
			vim.g.moonlight_italic_keywords = true
			vim.g.moonlight_italic_functions = false
			vim.g.moonlight_italic_variables = false
			vim.g.moonlight_contrast = true
			vim.g.moonlight_borders = false
			vim.g.moonlight_disable_background = false
		end,
	},
	{
		"samharju/synthweave.nvim",
		opts = {
			transparent = false,
		},
	},
	{
		"ray-x/aurora",
		init = function()
			vim.g.aurora_italic = 1
			vim.g.aurora_transparent = 0
			vim.g.aurora_bold = 1
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		opts = {
			transparent = false,
			italic_comments = true,
			borderless_pickers = true,
		},
	},
	{
		"eldritch-theme/eldritch.nvim",
		opts = {
			palette = "default",
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
			},
		},
	},
	{
		"maxmx03/fluoromachine.nvim",
		opts = {},
	},
	{
		"LazyVim/LazyVim",
		opts = function(_, opts)
			local theme = require("core.theme")
			opts.colorscheme = theme.name
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		},
		keys = {
			{
				"<leader>uT",
				function()
					require("telescope.builtin").colorscheme({
						enable_preview = true,
					})
				end,
				desc = "Theme Switcher",
			},
		},
	},
}

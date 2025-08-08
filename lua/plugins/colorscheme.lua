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
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			variant = "auto", -- auto, main, moon, or dawn
			dark_variant = "main",
			styles = {
				bold = true,
				italic = true,
				transparency = false,
			},
		},
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = {
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		},
	},
	{
		"Mofiqul/dracula.nvim",
		opts = {
			colors = {},
			show_end_of_buffer = true,
			transparent_bg = false,
			lualine_bg_color = "#44475a",
			italic_comment = true,
		},
	},
	{
		"navarasu/onedark.nvim",
		opts = {
			style = "dark", -- dark, darker, cool, deep, warm, warmer, light
			transparent = false,
			term_colors = true,
			ending_tildes = false,
			cmp_itemkind_reverse = false,
			code_style = {
				comments = "italic",
				keywords = "none",
				functions = "none",
				strings = "none",
				variables = "none",
			},
			lualine = {
				transparent = false,
			},
		},
	},
	{
		"Shatur/neovim-ayu",
		config = function()
			require('ayu').setup({
				mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
				terminal = true, -- Set to `false` to let terminal manage its own colors.
				overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		config = function()
			require('github-theme').setup({
				options = {
					compile_path = vim.fn.stdpath("cache") .. "/github-theme",
					compile_file_suffix = "_compiled",
					hide_end_of_buffer = true,
					hide_nc_statusline = true,
					transparent = false,
					terminal_colors = true,
					dim_inactive = false,
					module_default = true,
					styles = {
						comments = "italic",
						functions = "NONE",
						keywords = "NONE",
						variables = "NONE",
						conditionals = "NONE",
						constants = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
					},
				},
				palettes = {},
				specs = {},
				groups = {},
			})
		end,
	},
	{
		"sainnhe/gruvbox-material",
		init = function()
			vim.g.gruvbox_material_style = "material" -- material, mix, original
			vim.g.gruvbox_material_background = "medium" -- hard, medium, soft
			vim.g.gruvbox_material_foreground = "material" -- material, mix, original
			vim.g.gruvbox_material_disable_italic_comment = 0
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_transparent_background = 0
			vim.g.gruvbox_material_better_performance = 1
		end,
	},
	{
		"sainnhe/everforest",
		init = function()
			vim.g.everforest_style = "medium" -- hard, medium, soft
			vim.g.everforest_background = "medium" -- hard, medium, soft
			vim.g.everforest_enable_italic = 1
			vim.g.everforest_disable_italic_comment = 0
			vim.g.everforest_transparent_background = 0
			vim.g.everforest_better_performance = 1
		end,
	},
	{
		"marko-cerovac/material.nvim",
		opts = {
			contrast = {
				terminal = false,
				sidebars = false,
				floating_windows = false,
				cursor_line = false,
				lsp_virtual_text = false,
				non_current_windows = false,
				filetypes = {},
			},
			styles = {
				comments = { italic = true },
				strings = { bold = false },
				keywords = { italic = false },
				functions = { bold = false, italic = false },
				variables = {},
				operators = {},
				types = {},
			},
			plugins = {
				"nvim-cmp",
				"nvim-web-devicons",
				"telescope",
				"which-key",
			},
			disable = {
				colored_cursor = false,
				borders = false,
				background = false,
				term_colors = false,
				eob_lines = false,
			},
			high_visibility = {
				lighter = false,
				darker = false,
			},
			lualine_style = "default",
			async_loading = true,
			custom_colors = nil,
			custom_highlights = {},
		},
	},
	{
		"oxfist/night-owl.nvim",
		opts = {
			bold = true,
			italics = true,
			underline = true,
			undercurl = true,
			inverse = true,
			transparent_background = false,
		},
	},
	{
		"AlexvZyl/nordic.nvim",
		opts = {
			swap_backgrounds = false,
			on_highlight = function(highlights, palette)
				-- Custom highlight overrides can go here
			end,
			cursorline = {
				theme = "dark",
				blend = 0.85,
			},
			noice = {
				style = "flat",
			},
			telescope = {
				style = "flat",
			},
			leap = {
				dim_backdrop = false,
			},
			ts_context = {
				dark_background = true,
			},
		},
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

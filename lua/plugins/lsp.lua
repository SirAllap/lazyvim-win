return {
	-- mason tools
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"stylua",
				"selene",
				"luacheck",
				"shellcheck",
				"shfmt",
				"tailwindcss-language-server",
				"typescript-language-server",
				"css-lsp",
				"pyright",
				"black",
				"ruff-lsp",
			})
		end,
	},

	-- 🔒 pin mason-lspconfig to a safe version
	{
		"williamboman/mason-lspconfig.nvim",
		version = "1.26.0",
	},

	-- lspconfig + server setup
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.inlay_hints = { enabled = false }

			opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
				eslint = { -- Add this to disable ESLint
					autostart = false,
				},
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = false,
							analysis = {
								typeCheckingMode = "off",
								useLibraryCodeForTypes = true,
								diagnosticSeverityOverrides = {
									reportUnusedImport = "warning",
									reportMissingImports = "error",
								},
							},
						},
					},
				},
				cssls = {},
				html = {},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				lua_ls = {
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									ambiguity = "Opened",
									await = "Opened",
									codestyle = "None",
									duplicate = "Opened",
									global = "Opened",
									luadoc = "Opened",
									redefined = "Opened",
									strict = "Opened",
									strong = "Opened",
									["type-check"] = "Opened",
									unbalanced = "Opened",
									unused = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			})

			-- don't override setup unless needed
			opts.setup = opts.setup or {}

			-- keymap override for Telescope
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			vim.list_extend(keys, {
				{
					"gd",
					function()
						require("telescope.builtin").lsp_definitions({ reuse_win = false })
					end,
					desc = "Goto Definition (Telescope)",
					has = "definition",
				},
			})
		end,
	},
}

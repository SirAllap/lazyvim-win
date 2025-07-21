return {
	-- mason tools
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			-- This list explicitly tells Mason what to install and keep installed.
			-- All other previously installed tools not in this list will be uninstalled.
			opts.ensure_installed = {
				"black",
				"css-lsp",
				"html-lsp",
				"json-lsp",
				"lua-language-server",
				"luacheck",
				"prettier",
				"pyright",
				"ruff", -- Ruff CLI tool, used by ruff-lsp
				"ruff-lsp", -- LSP for Ruff
				"selene",
				"stylua",
				"tailwindcss-language-server",
				"typescript-language-server",
				"yaml-language-server",
			}
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

			-- This table configures the specific LSP servers.
			-- Only servers listed in opts.ensure_installed above should have configuration here,
			-- unless you intend for Mason to manage them implicitly.
			opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
				-- Python LSP servers
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = false,
							analysis = {
								typeCheckingMode = "off", -- Or "basic", "strict"
								useLibraryCodeForTypes = true,
								diagnosticSeverityOverrides = {
									reportUnusedImport = "warning",
									reportMissingImports = "error",
									reportLineTooLong = "none", -- To ignore E501 if Pyright reports it
									reportConstantTypo = "none",
								},
							},
						},
					},
				},
				ruff_lsp = {
					settings = {
						args = {
							"--ignore=E501", -- The primary fix for E501 from Ruff
							-- Or, if you prefer a longer line length:
							-- "--line-length=120",
						},
					},
				},

				-- Frontend LSP servers
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
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},

				-- General purpose LSP servers
				cssls = {},
				html = {},
				jsonls = {},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},

				-- Lua LSP server (for your Neovim config)
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

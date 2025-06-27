return {
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},
	{
		"b0o/incline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		config = function()
			local function get_hl_color(group, type, default)
				local ok, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
				if not ok or hl == nil then
					return default
				end
				local color = hl[type]
				if color then
					return string.format("#%06x", color)
				end
				return default
			end

			require("incline").setup({
				window = {
					padding = 0,
					margin = { vertical = 0, horizontal = 1 },
					winhighlight = {
						Normal = "Normal",
						FloatBorder = "FloatBorder",
					},
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local icon, icon_color = require("nvim-web-devicons").get_icon_color(filename)
					local modified = vim.bo[props.buf].modified and "[+] " or ""
					local readonly = vim.bo[props.buf].readonly and " " or ""
					local git_branch = vim.b[props.buf].gitsigns_head_name or ""

					local colors = {
						modified = get_hl_color("DiffChange", "foreground", "#FACC15"),
						readonly = get_hl_color("DiffDelete", "foreground", "#EF4444"),
						filename = get_hl_color("Normal", "foreground", "#D8D8D8"),
						branch = get_hl_color("Constant", "foreground", "#C080FF"),
						icon = icon_color,
					}

					return {
						{ icon, guifg = colors.icon },
						{ " " },
						{ modified, guifg = colors.modified },
						{ readonly, guifg = colors.readonly },
						{ filename, guifg = colors.filename, gui = "bold" },
						{ git_branch ~= "" and "  " .. git_branch or "", guifg = colors.branch },
					}
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return {
				options = {
					theme = nil,
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "diagnostics" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_c = { "filename" },
					lualine_x = { "location" },
				},
			}
		end,
	},
	{
		"folke/snacks.nvim",
		opts = {
			scroll = {
				enabled = false,
			},
			dashboard = {
				preset = {
					header = [[
⠀⠀⡶⠛⠲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡶⠚⢶⡀⠀
⢰⠛⠃⠀⢠⣏⠀⠀⠀⠀⣀⣠⣤⣤⣤⣤⣤⣤⣄⣀⡀⠀⠀⠀⣸⠇⠀⠈⠙⣧
⠸⣦⣤⣄⠀⠙⢷⣤⣶⠟⠛⢉⣁⣤⣤⣤⣤⣀⣉⠙⠻⢷⣤⡾⠋⢀⣤⣤⣴⠏
⠀⠀⠀⠈⠳⣤⡾⠋⣀⣴⣿⣿⠿⠿⠟⠛⠿⠿⣿⣿⣶⣄⠙⢿⣦⠟⠁⠀⠀⠀
⠀⠀⠀⢀⣾⠟⢀⣾⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣷⡄⠹⣷⡀⠀⠀⠀
⠀⠀⠀⣾⡏⢠⣿⣿⡯⠤⠤⠤⠒⠒⠒⠒⠒⠒⠒⠤⠤⠽⣿⣿⡆⠹⣷⡀⠀⠀
⠀⠀⢸⣟⣠⡿⠿⠟⠒⣒⣒⣉⣉⣉⣉⣉⣉⣉⣉⣉⣒⣒⡛⠻⠿⢤⣹⣇⠀⠀
⠀⠀⣾⡭⢤⣤⣠⡞⠉⠁⢀⣀⣀⠀⠀⠀⠀⢀⣀⣀⠀⠈⢹⣦⣤⡤⠴⣿⠀⠀
⠀⠀⣿⡇⢸⣿⣿⣇⠀⣼⣿⣿⣿⣷⠀⠀⣼⣿⣿⣿⣷⠀⢸⣿⣿⡇⠀⣿⠀⠀
⠀⠀⢻⡇⠸⣿⣿⣿⡄⢿⣿⣿⣿⡿⠀⠀⢿⣿⣿⣿⡿⢀⣿⣿⣿⡇⢸⣿⠀⠀
⠀⠀⠸⣿⡀⢿⣿⣿⣿⣆⠉⠛⠋⠀⢴⣶⠀⠉⠛⠉⣠⣿⣿⣿⡿⠀⣾⠇⠀⠀
⠀⠀⠀⢻⣷⡈⢻⣿⣿⣿⣿⣶⣤⣀⣈⣁⣀⡤⣴⣿⣿⣿⣿⡿⠁⣼⠏⠀⠀⠀
⠀⠀⠀⢀⣽⣷⣄⠙⢿⣿⣿⡟⢲⠧⡦⠼⠤⢷⢺⣿⣿⡿⠋⣠⣾⢿⣄⠀⠀⠀
⣰⠟⠛⠛⠁⣨⡿⢷⣤⣈⠙⢿⡙⠒⠓⠒⠒⠚⡹⠛⢁⣤⣾⠿⣧⡀⠙⠋⠙⣆
⠹⣤⡀⠀⠐⡏⠀⠀⠉⠛⠿⣶⣿⣶⣤⣤⣤⣾⣷⠾⠟⠋⠀⠀⢸⡇⠀⢠⣤⠟
⠀⠀⠳⢤⠾⠃⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠘⠷⠤⠾⠁⠀
]],
				},
			},
		},
	},
}

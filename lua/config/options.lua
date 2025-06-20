-- Leader Key
vim.g.mapleader = " "

-- Global LazyVim settings
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "blink.cmp"

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- UI & Appearance
vim.opt.number = true
vim.opt.title = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.scrolloff = 10
vim.opt.showbreak = "↪ "

-- Searching
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.inccommand = "split"

-- Indentation & Tabs
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Text Wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Backups & Files
vim.opt.backup = false
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Window Splitting
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"

-- Behavior
vim.opt.shell = "fish"
vim.opt.backspace = { "start", "eol", "indent" }
vim.o.mouse = "ni"

-- File types
vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})

-- Dynamic Highlight Overrides (Theme Agnostic)
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local function get_hl(group, fallback)
			local ok, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
			if ok and hl then
				return hl
			end
			ok, hl = pcall(vim.api.nvim_get_hl_by_name, fallback, true)
			if ok and hl then
				return hl
			end
			return {}
		end

		local colors = {
			base_bg = get_hl("Normal", "Normal").background,
			medium_bg = get_hl("ColorColumn", "Visual").background,
			light_bg = get_hl("CursorLine", "Visual").background,
			visual_bg = get_hl("Visual", "ColorColumn").background,
			line_nr_fg = get_hl("Directory", "String").foreground,
			overlay_fg = get_hl("Comment", "Comment").foreground,
			cursor_fg_reverse = true,
		}

		vim.opt.cursorline = true
		vim.opt.cursorcolumn = false

		vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.light_bg })
		vim.api.nvim_set_hl(0, "CursorColumn", { bg = colors.light_bg })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.line_nr_fg, bold = true })
		vim.api.nvim_set_hl(0, "LineNr", { fg = colors.overlay_fg, bg = colors.base_bg })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = colors.base_bg })
		vim.api.nvim_set_hl(0, "Cursor", { reverse = colors.cursor_fg_reverse })

		local group = vim.api.nvim_create_augroup("ModeHighlights", { clear = true })

		vim.api.nvim_create_autocmd("InsertEnter", {
			pattern = "*",
			group = group,
			callback = function()
				vim.opt.cursorcolumn = true
				vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.medium_bg })
				vim.api.nvim_set_hl(0, "CursorColumn", { bg = colors.overlay_fg })
			end,
		})

		vim.api.nvim_create_autocmd("InsertLeave", {
			pattern = "*",
			group = group,
			callback = function()
				vim.opt.cursorcolumn = false
				vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.light_bg })
				vim.api.nvim_set_hl(0, "CursorColumn", { bg = colors.light_bg })
			end,
		})

		vim.api.nvim_create_autocmd("ModeChanged", {
			pattern = "*:[vV\x16]",
			group = group,
			callback = function()
				vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.visual_bg })
			end,
		})

		vim.api.nvim_create_autocmd("ModeChanged", {
			pattern = "[vV\x16]:n",
			group = group,
			callback = function()
				vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.light_bg })
			end,
		})
	end,
})

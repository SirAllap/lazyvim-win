-- Autocommands setup
local autocmd = vim.api.nvim_create_autocmd

-- 🧼 Turn off paste mode when leaving insert mode
autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- 🧠 Warn user if paste mode is on when entering insert mode
autocmd("InsertEnter", {
	pattern = "*",
	callback = function()
		if vim.o.paste then
			vim.notify("Paste mode is ON. You may want to turn it off.", vim.log.levels.WARN)
		end
	end,
})

-- 🧾 Disable concealing in specific filetypes if set to default conceallevel
local conceal_overrides = {
	json = 0,
	jsonc = 0,
	markdown = 0,
}

autocmd("FileType", {
	pattern = vim.tbl_keys(conceal_overrides),
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if vim.wo.conceallevel == 3 then -- LazyVim default
			vim.opt_local.conceallevel = conceal_overrides[ft]
		end
	end,
})

-- 🖥 Terminal enhancements for TUI apps like lazydocker or btop
local tui_commands = { "lazydocker", "btop", "htop", "yazi", "gitui", "nnn" }

autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		local buf_name = vim.api.nvim_buf_get_name(0):lower()

		-- Check if this terminal runs a known TUI app
		for _, cmd in ipairs(tui_commands) do
			if buf_name:find(cmd) then
				vim.wo.number = false
				vim.wo.relativenumber = false
				break
			end
		end

		-- UX: Auto-enter insert mode in terminal
		vim.cmd("startinsert")
	end,
})

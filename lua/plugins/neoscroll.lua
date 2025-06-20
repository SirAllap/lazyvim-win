return {
	"karb94/neoscroll.nvim",
	event = "WinScrolled",
	config = function()
		require("neoscroll").setup({
			-- All these keys will be mapped to their respective scrolling animations
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			hide_cursor = true, -- Hide cursor while scrolling
			stop_eof = true, -- Stop at <EOF> when scrolling down
			respect_scrolloff = false, -- Ignore 'scrolloff' when scrolling
			cursor_scrolls_alone = true, -- Allow cursor to scroll even if window can’t

			-- Smoothing options
			easing_function = "quadratic", -- Options: "sine", "circular", "cubic", "quadratic", "quartic"
			performance_mode = false, -- Disable if FPS drops
		})
	end,
}

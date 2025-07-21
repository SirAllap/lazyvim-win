return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		adapters = {
			gemini = {
				-- Your API key for the Gemini model
				api_key = os.getenv("GEMINI_API_KEY"),
			},
		},
		-- Other configuration options...
	},
}

-- TODO: I need to use ai for autocompletion
return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	file_selector = {
		--- @alias FileSelectorProvider "native" | "fzf" | "telescope" | string
		provider = "fzf",
		-- Options override for custom providers
		provider_opts = {},
	},
	compat = {
		"avante_commands",
		"avante_mentions",
		"avante_files",
	},
	providers = {
		avante_commands = {
			name = "avante_commands",
			module = "blink.compat.source",
			score_offset = 90, -- show at a higher priority than lsp
			opts = {},
		},
		avante_files = {
			name = "avante_commands",
			module = "blink.compat.source",
			score_offset = 100, -- show at a higher priority than lsp
			opts = {},
		},
		avante_mentions = {
			name = "avante_mentions",
			module = "blink.compat.source",
			score_offset = 1000, -- show at a higher priority than lsp
			opts = {},
		},
	},
	opts = {
		keymap = { preset = "default" },
		appearance = {
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		signature = { enabled = true },
	},
}

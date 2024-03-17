require("jupynium").setup({
	-- Set python_host to use the Conda environment "myenv"
	python_host = { "conda", "run", "--no-capture-output", "-n", "myenv", "python" },

	default_notebook_URL = "localhost:8888/nbclassic",

	-- If you want to use Jupyter from the Conda environment "myenv", uncomment and modify the line below
	jupyter_command = { "conda", "run", "--no-capture-output", "-n", "myenv", "jupyter" },

	-- Rest of the configuration remains the same
	notebook_dir = nil,
	firefox_profiles_ini_path = nil,
	firefox_profile_name = nil,
	auto_start_server = {
		enable = false,
		file_pattern = { "*.ju.*" },
	},
	auto_attach_to_server = {
		enable = true,
		file_pattern = { "*.ju.*", "*.md" },
	},
	auto_start_sync = {
		enable = false,
		file_pattern = { "*.ju.*", "*.md" },
	},
	auto_download_ipynb = true,
	auto_close_tab = true,
	autoscroll = {
		enable = true,
		mode = "always",
		cell = {
			top_margin_percent = 20,
		},
	},
	scroll = {
		page = { step = 0.5 },
		cell = {
			top_margin_percent = 20,
		},
	},
	jupynium_file_pattern = { "*.ju.*" },
	use_default_keybindings = true,
	textobjects = {
		use_default_keybindings = true,
	},
	syntax_highlight = {
		enable = true,
	},
	shortsighted = false,
	kernel_hover = {
		floating_win_opts = {
			max_width = 84,
			border = "none",
		},
	},
})

vim.cmd [[
hi! link JupyniumCodeCellSeparator CursorLine
hi! link JupyniumMarkdownCellSeparator CursorLine
hi! link JupyniumMarkdownCellContent CursorLine
hi! link JupyniumMagicCommand Keyword
]]

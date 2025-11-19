return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local diffview = require("diffview")

		diffview.setup({
			enhanced_diff_hl = true,
			use_icons = true,
			view = {
				default = {
					layout = "diff2_horizontal",
					winbar_info = true,
				},
				merge_tool = {
					layout = "diff3_horizontal",
					disable_diagnostics = true,
					winbar_info = true,
				},
				file_history = {
					layout = "diff2_horizontal",
					winbar_info = true,
				},
			},
			file_panel = {
				listing_style = "tree",
				tree_options = {
					flatten_dirs = true,
					folder_statuses = "only_folded",
				},
				win_config = {
					position = "left",
					width = 35,
				},
			},
		})

		vim.keymap.set("n", "<leader>gdo", function()
			vim.cmd("DiffviewOpen")
		end, { desc = "[o]pen diffview" })

		vim.keymap.set("n", "<leader>gdc", function()
			vim.cmd("DiffviewClose")
		end, { desc = "[c]lose diffview" })

		vim.keymap.set("n", "<leader>gdh", function()
			vim.cmd("DiffviewFileHistory")
		end, { desc = "file [h]istory" })

		vim.keymap.set("n", "<leader>gdf", function()
			vim.cmd("DiffviewFileHistory %")
		end, { desc = "current [f]ile history" })

		vim.keymap.set("n", "<leader>gdr", function()
			vim.cmd("DiffviewRefresh")
		end, { desc = "[r]efresh diffview" })
	end,
}

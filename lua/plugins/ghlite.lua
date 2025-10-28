return {
	"daliusd/ghlite.nvim",
	dependencies = {
		"sindrets/diffview.nvim",
		"ibhagwan/fzf-lua",
	},
	config = function()
		-- Register FzfLua as UI select handler for ghlite
		vim.cmd('FzfLua register_ui_select')

		require("ghlite").setup({
			debug = false,
			view_split = "vsplit",
			diff_split = "vsplit",
			comment_split = "split",
			open_command = vim.fn.has('mac') == 1 and 'open' or 'xdg-open',
		})

		-- Key bindings following your <leader>g (git) pattern

		-- PR selection and checkout
		vim.keymap.set("n", "<leader>gps", "<cmd>GHLitePRSelect<cr>", { desc = "Select PR" })
		vim.keymap.set("n", "<leader>gpc", "<cmd>GHLitePRCheckout<cr>", { desc = "Checkout PR" })
		vim.keymap.set("n", "<leader>gpv", "<cmd>GHLitePRView<cr>", { desc = "View PR" })

		-- PR diff and review
		vim.keymap.set("n", "<leader>gpd", "<cmd>GHLitePRDiff<cr>", { desc = "PR diff" })
		vim.keymap.set("n", "<leader>gpdv", "<cmd>GHLitePRDiffview<cr>", { desc = "PR diffview" })
		vim.keymap.set("n", "<leader>gpl", "<cmd>GHLitePRLoadComments<cr>", { desc = "Load PR comments" })

		-- PR actions
		vim.keymap.set("n", "<leader>gpa", "<cmd>GHLitePRApprove<cr>", { desc = "Approve PR" })
		vim.keymap.set("n", "<leader>gpr", "<cmd>GHLitePRRequestChanges<cr>", { desc = "Request changes" })
		vim.keymap.set("n", "<leader>gpm", "<cmd>GHLitePRMerge<cr>", { desc = "Merge PR" })

		-- PR comments
		vim.keymap.set("n", "<leader>gcp", "<cmd>GHLitePRAddPRComment<cr>", { desc = "Add PR comment" })
		vim.keymap.set("n", "<leader>gca", "<cmd>GHLitePRAddComment<cr>", { desc = "Add inline comment" })
		vim.keymap.set("n", "<leader>gcu", "<cmd>GHLitePRUpdateComment<cr>", { desc = "Update comment" })
		vim.keymap.set("n", "<leader>gcd", "<cmd>GHLitePRDeleteComment<cr>", { desc = "Delete comment" })
		vim.keymap.set("n", "<leader>gco", "<cmd>GHLitePROpenComment<cr>", { desc = "Open comment in browser" })
	end,
}

return {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ibhagwan/fzf-lua",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("octo").setup({
			picker = "fzf-lua",
		})

		vim.keymap.set("n", "<leader>gpl", "<cmd>Octo pr list<cr>", { desc = "[l]ist prs" })
		vim.keymap.set("n", "<leader>gps", function()
			vim.ui.input({ prompt = "pr filters: " }, function(input)
				if input then
					vim.cmd("Octo pr search " .. input)
				end
			end)
		end, { desc = "[s]earch prs" })
		vim.keymap.set("n", "<leader>gpc", "<cmd>Octo pr create<cr>", { desc = "[c]reate pr" })
	end,
}

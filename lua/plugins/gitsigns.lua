return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			-- Git blame configuration
			current_line_blame = false, -- Disabled by default (on-demand only)
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- Show at end of line
				delay = 300,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		})

		-- Git blame keymaps under <leader>gb (git blame)
		vim.keymap.set("n", "<leader>gbt", function()
			vim.cmd("Gitsigns toggle_current_line_blame")
		end, { desc = "Toggle git blame" })

		vim.keymap.set("n", "<leader>gbb", function()
			vim.cmd("Gitsigns blame_line")
		end, { desc = "Show full blame" })

		-- Git hunk operations under <leader>gh (git hunk)
		local gs = require("gitsigns")

		vim.keymap.set("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
		vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
		vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { desc = "Restore/reset hunk" })
		vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Restore/reset buffer" })
		vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })

		-- Visual mode for staging/resetting selected hunks
		vim.keymap.set("v", "<leader>ghs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Stage hunk" })
		vim.keymap.set("v", "<leader>ghr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Restore/reset hunk" })

		-- Hunk navigation
		vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next hunk" })
		vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
	end,
}

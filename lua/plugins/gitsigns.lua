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

		local gs = require("gitsigns")

		vim.keymap.set("n", "<leader>gbt", function()
			vim.cmd("Gitsigns toggle_current_line_blame")
		end, { desc = "[t]oggle git blame" })

		vim.keymap.set("n", "<leader>gbb", function()
			vim.cmd("Gitsigns blame_line")
		end, { desc = "show full [b]lame" })

		vim.keymap.set("n", "<leader>ghs", gs.stage_hunk, { desc = "[s]tage hunk" })
		vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "[u]ndo stage hunk" })
		vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { desc = "[r]estore/reset hunk" })
		vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "[R]estore/reset buffer" })
		vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "[p]review hunk" })

		vim.keymap.set("v", "<leader>ghs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "[s]tage hunk" })
		vim.keymap.set("v", "<leader>ghr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "[r]estore/reset hunk" })

		vim.keymap.set("n", "]h", gs.next_hunk, { desc = "next hunk" })
		vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "previous hunk" })
	end,
}

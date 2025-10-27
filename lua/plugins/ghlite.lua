return {
	"daliusd/ghlite.nvim",
	dependencies = { "ibhagwan/fzf-lua" },
	config = function()
		local ghlite = require("ghlite")

		ghlite.setup({
			debug = false,
			view_split = "vsplit",
			diff_split = "vsplit",
			comment_split = "split",
			open_command = vim.fn.has('mac') == 1 and 'open' or 'xdg-open',
		})

		-- Key bindings following your <leader>g (git) pattern

		-- PR operations
		vim.keymap.set("n", "<leader>gpl", function()
			ghlite.pr_list()
		end, { desc = "List PRs" })

		vim.keymap.set("n", "<leader>gpo", function()
			ghlite.pr_open()
		end, { desc = "Open PR" })

		vim.keymap.set("n", "<leader>gpc", function()
			ghlite.pr_checkout()
		end, { desc = "Checkout PR" })

		vim.keymap.set("n", "<leader>gpd", function()
			ghlite.pr_diff()
		end, { desc = "PR diff" })

		vim.keymap.set("n", "<leader>gpm", function()
			ghlite.pr_merge()
		end, { desc = "Merge PR" })

		vim.keymap.set("n", "<leader>gpa", function()
			ghlite.pr_approve()
		end, { desc = "Approve PR" })

		-- Issues
		vim.keymap.set("n", "<leader>gil", function()
			ghlite.issue_list()
		end, { desc = "List issues" })

		vim.keymap.set("n", "<leader>gio", function()
			ghlite.issue_open()
		end, { desc = "Open issue" })

		-- Comments
		vim.keymap.set("n", "<leader>gcc", function()
			ghlite.comment_create()
		end, { desc = "Create comment" })

		-- FzfLua integration for PRs
		vim.keymap.set("n", "<leader>gfp", function()
			local fzf = require("fzf-lua")
			local prs = ghlite.get_prs_list()

			if not prs or #prs == 0 then
				vim.notify("No PRs found", vim.log.levels.INFO)
				return
			end

			local entries = {}
			for _, pr in ipairs(prs) do
				table.insert(entries, string.format("#%d: %s (@%s) [%s]",
					pr.number, pr.title, pr.user.login, pr.state))
			end

			fzf.fzf_exec(entries, {
				prompt = "PRs❯ ",
				actions = {
					["default"] = function(selected)
						local pr_num = selected[1]:match("#(%d+)")
						if pr_num then
							ghlite.pr_open(tonumber(pr_num))
						end
					end,
					["ctrl-d"] = function(selected)
						local pr_num = selected[1]:match("#(%d+)")
						if pr_num then
							ghlite.pr_diff(tonumber(pr_num))
						end
					end,
					["ctrl-c"] = function(selected)
						local pr_num = selected[1]:match("#(%d+)")
						if pr_num then
							ghlite.pr_checkout(tonumber(pr_num))
						end
					end,
				},
				winopts = {
					height = 0.70,
					width = 0.85,
					preview = {
						hidden = "hidden",
					},
				},
			})
		end, { desc = "FZF PR picker" })

		-- FzfLua integration for Issues
		vim.keymap.set("n", "<leader>gfi", function()
			local fzf = require("fzf-lua")
			local issues = ghlite.get_issues_list()

			if not issues or #issues == 0 then
				vim.notify("No issues found", vim.log.levels.INFO)
				return
			end

			local entries = {}
			for _, issue in ipairs(issues) do
				table.insert(entries, string.format("#%d: %s (@%s) [%s]",
					issue.number, issue.title, issue.user.login, issue.state))
			end

			fzf.fzf_exec(entries, {
				prompt = "Issues❯ ",
				actions = {
					["default"] = function(selected)
						local issue_num = selected[1]:match("#(%d+)")
						if issue_num then
							ghlite.issue_open(tonumber(issue_num))
						end
					end,
				},
				winopts = {
					height = 0.70,
					width = 0.85,
					preview = {
						hidden = "hidden",
					},
				},
			})
		end, { desc = "FZF issue picker" })
	end,
}

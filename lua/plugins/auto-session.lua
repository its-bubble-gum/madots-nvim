return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_session_enable_last_session = false,
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enabled = true,
      auto_save_enabled = false,
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      auto_session_use_git_branch = false,

      -- Session hooks that write commands to the session file
      pre_save_cmds = {},

      -- Save extra session data - this gets written to the session file
      save_extra_cmds = {
        -- Save bufferline pin state
        function()
          local pinned_buffers = {}
          local ok, groups = pcall(require, "bufferline.groups")

          if ok then
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(buf) then
                local path = vim.api.nvim_buf_get_name(buf)
                local element = { id = buf }
                local is_pinned = groups._is_pinned(element)

                if path ~= "" and is_pinned then
                  table.insert(pinned_buffers, path)
                end
              end
            end
          end

          -- Return a vim command that will be written to the session file
          -- This command will set the global variable when the session is restored
          local escaped_buffers = vim.fn.escape(vim.fn.json_encode(pinned_buffers), '"\\')
          return string.format('lua vim.g.session_pinned_buffers = vim.fn.json_decode("%s")', escaped_buffers)
        end,
      },

      post_restore_cmds = {
        -- Restore bufferline pin state
        function()
          if vim.g.session_pinned_buffers then
            vim.defer_fn(function()
              local ok, groups = pcall(require, "bufferline.groups")
              if ok then
                for _, buf_name in ipairs(vim.g.session_pinned_buffers) do
                  local buf = vim.fn.bufnr(buf_name)
                  if buf ~= -1 and vim.api.nvim_buf_is_loaded(buf) then
                    local element = { id = buf, path = buf_name }
                    if not groups._is_pinned(element) then
                      pcall(groups.add_element, "pinned", element)
                    end
                  end
                end
              end
              vim.g.session_pinned_buffers = nil
            end, 100)
          end
        end,
      },
    })

    -- Custom FzfLua session picker
    local function fzf_session_picker()
      local session_dir = vim.fn.stdpath("data") .. "/sessions/"
      local sessions = vim.fn.glob(session_dir .. "*.vim", false, true)

      if #sessions == 0 then
        vim.notify("No sessions found", vim.log.levels.WARN)
        return
      end

      local session_names = {}
      for _, session in ipairs(sessions) do
        local name = vim.fn.fnamemodify(session, ":t:r")
        -- Decode session name (auto-session uses encoded names)
        name = name:gsub("%%(%x%x)", function(hex)
          return string.char(tonumber(hex, 16))
        end)
        table.insert(session_names, name)
      end

      require("fzf-lua").fzf_exec(session_names, {
        prompt = "Sessions> ",
        actions = {
          ["default"] = function(selected)
            if selected and #selected > 0 then
              -- Encode the name back
              local encoded = selected[1]:gsub("([^%w])", function(c)
                return string.format("%%%02X", string.byte(c))
              end)
              vim.cmd("SessionRestore " .. vim.fn.fnameescape(encoded))
            end
          end,
          ["ctrl-d"] = function(selected)
            if selected and #selected > 0 then
              local encoded = selected[1]:gsub("([^%w])", function(c)
                return string.format("%%%02X", string.byte(c))
              end)
              vim.cmd("SessionDelete " .. vim.fn.fnameescape(encoded))
              vim.notify("Session deleted: " .. selected[1], vim.log.levels.INFO)
            end
          end,
        },
      })
    end

    vim.keymap.set("n", "<leader>qs", "<CMD>AutoSession save<CR>", {
      desc = "[s]ave session",
    })
    vim.keymap.set("n", "<leader>qr", "<CMD>AutoSession search<CR>", {
      desc = "[r]estore session",
    })
    vim.keymap.set("n", "<leader>qd", "<CMD>AutoSession delete<CR>", {
      desc = "[d]elete session",
    })
    vim.keymap.set("n", "<leader>qf", fzf_session_picker, {
      desc = "search sessions ([f]zf)",
    })
  end,
}

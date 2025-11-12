return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })

      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = "<module",
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end

      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      if vim.fn.executable("netcoredbg") == 1 then
        dap.adapters.coreclr = {
          type = "executable",
          command = "netcoredbg",
          args = { "--interpreter=vscode" },
        }

        dap.adapters.netcoredbg = {
          type = "executable",
          command = "netcoredbg",
          args = { "--interpreter=vscode" },
        }

        dap.configurations.cs = {
          {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
              local cwd = vim.fn.getcwd()
              local dll_path = vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/", "file")
              return dll_path
            end,
          },
          {
            type = "coreclr",
            name = "attach - netcoredbg",
            request = "attach",
            processId = require("dap.utils").pick_process,
          },
        }
      end

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug toggle [B]reakpoint" })
      vim.keymap.set("n", "<leader>dbc", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "[D]ebug [B]reakpoint [C]ondition" })
      vim.keymap.set("n", "<leader>dbl", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "[D]ebug [B]reakpoint [L]og" })

      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })
      vim.keymap.set("n", "<leader>dv", dap.step_over, { desc = "[D]ebug step o[V]er" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug step [I]nto" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "[D]ebug step [O]ut" })
      vim.keymap.set("n", "<leader>dB", dap.step_back, { desc = "[D]ebug step [B]ack" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "[D]ebug [R]estart" })

      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "[D]AP [U]I toggle" })
      vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "[D]AP [E]val" })
    end,
  },
}

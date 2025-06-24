return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'wojciech-kulik/xcodebuild.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local xcodebuild = require 'xcodebuild.integrations.dap'
    local codelldbPath = '/Users/drewjohnson/.local/extension/adapter/codelldb'
    local dotnetDebuggerPath = '/usr/local/bin/netcoredbg/netcoredbg'
    local dotnet = require 'easy-dotnet'

    local function rebuild_project(co, path)
      local spinner = require('easy-dotnet.ui-modules.spinner').new()
      spinner:start_spinner 'Building'
      vim.fn.jobstart(string.format('dotnet build %s', path), {
        on_exit = function(_, return_code)
          if return_code == 0 then
            spinner:stop_spinner 'Built successfully'
          else
            spinner:stop_spinner('Build failed with exit code ' .. return_code, vim.log.levels.ERROR)
            error 'Build failed'
          end
          coroutine.resume(co)
        end,
      })
      coroutine.yield()
    end

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

    xcodebuild.setup(codelldbPath)

    local function file_exists(path)
      local stat = vim.loop.fs_stat(path)
      return stat and stat.type == 'file'
    end

    local debug_dll = nil

    local function ensure_dll()
      if debug_dll ~= nil then
        return debug_dll
      end
      local dll = dotnet.get_debug_dll()
      debug_dll = dll
      return dll
    end

    for _, value in ipairs { 'cs', 'fsharp' } do
      dap.configurations[value] = {
        {
          type = 'coreclr',
          name = 'Program',
          request = 'launch',
          env = function()
            local dll = ensure_dll()
            local vars = dotnet.get_environment_variables(dll.project_name, dll.absolute_project_path)
            return vars or nil
          end,
          program = function()
            local dll = ensure_dll()
            local co = coroutine.running()
            rebuild_project(co, dll.project_path)
            if not file_exists(dll.target_path) then
              error('Project has not been built, path: ' .. dll.target_path)
            end
            return dll.target_path
          end,
          cwd = function()
            local dll = ensure_dll()
            return dll.absolute_project_path
          end,
        },
      }

      dap.listeners.before['event_terminated']['easy-dotnet'] = function()
        debug_dll = nil
      end
      dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' },
      }
    end

    vim.keymap.set('n', '<leader>dr', xcodebuild.debug_without_build, { desc = 'Debug Without Building' })
    vim.keymap.set('n', '<leader>dt', xcodebuild.debug_tests, { desc = 'Debug Tests' })
    vim.keymap.set('n', '<leader>dT', xcodebuild.debug_class_tests, { desc = 'Debug Class Tests' })
    vim.keymap.set('n', '<leader>b', xcodebuild.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', xcodebuild.toggle_message_breakpoint, { desc = 'Toggle Message Breakpoint' })
    vim.keymap.set('n', '<leader>dx', xcodebuild.terminate_session, { desc = 'Terminate Debugger' })
    vim.keymap.set('n', '<F5>', function()
      require('dap').continue()
    end)
    vim.keymap.set('n', '<F10>', function()
      require('dap').step_over()
    end)
    vim.keymap.set('n', '<F11>', function()
      require('dap').step_into()
    end)
    vim.keymap.set('n', '<F12>', function()
      require('dap').step_out()
    end)

    vim.keymap.set('n', '<leader>df', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end, { desc = 'Show Frames' })
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      require('dap.ui.widgets').preview().toggle()
    end, { desc = 'Show Preview' })
    vim.keymap.set('n', '<Leader>dc', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
    end, { desc = 'Show Scopes' })
  end,
}

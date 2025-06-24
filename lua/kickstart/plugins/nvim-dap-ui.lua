return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  lazy = true,
  config = function()
    require('dapui').setup {
      element_mappings = {},
      expand_lines = true,
      force_buffers = true,
      render = {
        indent = 1,
        max_value_lines = 100,
      },
      mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = 't',
      },
      controls = {
        element = 'repl',
        enabled = true,
        icons = {},
      },
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      icons = { collapsed = '', expanded = '', current_frame = '' },
      layouts = {
        {
          elements = {
            --{ id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'console', size = 0.50 },
            --{ id = 'watches', size = 0.25 },
            --{ id = 'repl', size = 0.50 },
          },
          position = 'left',
          size = 60,
        },
        {
          elements = {
            { id = 'repl', size = 0.99 },
          },
          position = 'bottom',
          size = 30,
        },
      },
    }

    local dap, dapui = require 'dap', require 'dapui'

    -- vim.keymap.set('n', '<leader>co', function()
    --   local dapConsole = dapui.elements.console
    --   dapConsole.
    -- end, { desc = 'Dap Console' })
    vim.keymap.set('n', '<leader>du', function()
      dapui.toggle()
    end, { desc = 'Dap-UI Toggle' })

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
}

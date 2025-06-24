return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>nh',
      function()
        ---@param id? number|string
        Snacks.notifier.hide(id)
      end,
      desc = 'Dismiss Notification',
    },
    {
      '<leader>bl',
      function()
        ---@param opts? snacks.terminal.Opts | { count?: number }
        Snacks.git.blame_line(opts)
      end,
      desc = 'Blame Line',
    },
    {
      '<leader>tt',
      function()
        ---@param cmd? string | string[]
        ---@param opts? snacks.terminal.Opts
        Snacks.terminal.toggle(cmd, opts)
      end,
      desc = 'Open Terminal',
    },
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
    { '<leader>gg', function() Snacks.picker.git_diff() end, desc = 'Git Diff' },
    { '<leader>lf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = 'Search Open Buffers' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'Resume Search' },
    { '<leader>gr', function() Snacks.picker.lsp_references() end, desc = 'Get References' },
    { '<leader>gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
    { '<leader>gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    { '<leader>ds', function() Snacks.picker.lsp_symbols() end, desc = 'Document Symbols' },
    { '<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'Workspace Symbols' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Search Word' },
    { '<leader>ch', function() Snacks.picker.command_history() end, desc = 'Command Histroy' },
    { '<leader>nn', function() Snacks.picker.notifications() end, desc = 'Notifications' },
    { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
    { '<leader>/', function() Snacks.picker.lines() end, desc = 'Search in Buffer' },
    { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = 'Search in Buffer' },
    {
      '<leader>se',
      function()
        ---@param opts? snacks.picker.explorer.Config|()
        Snacks.explorer()
      end,
      desc = 'Open Explorer',
    },
  },
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true },
    dashboard = {},
    git = { enabled = true },
    terminal = {},
    picker = {
      sources = {
        grep = {
          layout = {
            layout = { position = 'bottom', height = 30 },
          },
        },
        grep_word = {
          layout = { position = 'bottom', height = 30 },
        },
        lines = {
          layout = { preset = 'vscode' },
        },
      },
    },
  },
}

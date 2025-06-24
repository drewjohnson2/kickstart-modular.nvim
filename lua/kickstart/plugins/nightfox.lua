return {
  'EdenEast/nightfox.nvim',
  priority = 1000,
  config = function()
    local palettes = {
      terafox = {
        orange = { base = '#6fa6a6', bright = '#78b5b5', dim = '#5d8c8c' },
        yellow = { base = '#6fa6a6', bright = '#78b5b5', dim = '#5d8c8c' },
        --red = { base = '#6fa6a6', bright = '#78b5b5', dim = '#5d8c8c' },
        magenta = { base = '#8a5c6e', bright = '#966578', dim = '#8a5c6e' },
        white = { base = '#d3d0c2', bright = '#d3d0c2', dim = '#d3d0c2' },
      },
    }

    local spec = {
      terafox = {
        syntax = {
          builtin0 = 'cyan.base',
          builtin3 = 'green.base',
        },
      },
    }

    local groups = {
      terafox = {
        NormalFloat = { bg = 'palette.bg1', fg = 'palette.green' },
      },
    }

    require('nightfox').setup { palettes = palettes, specs = spec, groups = groups }

    vim.cmd.colorscheme 'terafox'
  end,
}

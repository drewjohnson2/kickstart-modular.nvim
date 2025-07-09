return {
  'EdenEast/nightfox.nvim',
  priority = 1000,
  config = function()
    local palettes = {
      terafox = {
        orange = { base = '#DBCBD8', bright = '#DBCBD8', dim = '#DBCBD8' },
        yellow = { base = '#6fa6a6', bright = '#78b5b5', dim = '#5d8c8c' },
        red = { base = '#8a5c6e', bright = '#966578', dim = '#8a5c6e' },
        magenta = { base = '#8a5c6e', bright = '#966578', dim = '#8a5c6e' },
        white = { base = '#d3d0c2', bright = '#d3d0c2', dim = '#d3d0c2' },
	fg1 = '#d3d0c2',
	fg2 = '#d3d0c2'
      },
    }

    local spec = {
      terafox = {
        syntax = {
          builtin0 = 'cyan.base',
          builtin3 = 'blue.dim',
	  string = 'green.dim',
	  number = 'yellow.base',
	  const = 'magenta.base',
	  field = 'yellow.base',
	  type = 'blue.dim'
        },
	diff = {
	    change = '#234a3e',
	    add = '#234a3e',
	    delete = '#5e3142'
	}
      },
    }

    local groups = {
      terafox = {
        NormalFloat = { bg = '#131f22', fg = 'palette.blue.base' },
        FloatTitle = { bg = '#131f22', fg = 'palette.blue.base' },
	FloatBorder = { bg = '#131f22', fg = 'palette.green' },
	WinSeparator = { bg = 'palette.bg1', fg = 'palette.blue' },
	CmpNormal = { bg = '#131f22', fg = 'palette.blue.base' },
	BorderBg = { bg = '#131f22', fg = 'palette.green' },
	TabLine = { bg = 'palette.bg0', fg = 'palette.white' },
	--TabLineSel = { bg = 'palette.yellow.dim', fg = 'palette.bg0' }
      },
    }

    require('nightfox').setup { palettes = palettes, specs = spec, groups = groups }

    vim.cmd.colorscheme 'terafox'
  end,
}

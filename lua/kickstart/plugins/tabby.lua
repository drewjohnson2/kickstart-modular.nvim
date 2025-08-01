return {
'nanozuki/tabby.nvim',
    config = function()
    local theme = {
      fill = 'TabLineFill',
      -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
      head = 'TabLine',
      current_tab = 'TabLineSel',
      tab = { fg = '#d3d0c2', bg = '#254147' },
      win = 'TabLine',
      tail = 'TabLine',
      files_in_buffer = { fg = '#d3d0c2', bg = '#613d42'}
    }
    require('tabby').setup({
      line = function(line)
        return {
          {
            line.sep('', theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep('', hl, theme.fill),
              tab.is_current() and '',
              tab.number(),
              tab.name(),
              tab.close_btn(''),
              line.sep('', hl, theme.fill),
              hl = hl,
              margin = ' ',
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
              line.sep('', theme.files_in_buffer, theme.fill),
              win.is_current() and '',
              win.buf_name(),
              line.sep('', theme.files_in_buffer, theme.fill),
              hl = theme.files_in_buffer,
              margin = ' ',
            }
          end),
          {
            line.sep('', theme.tail, theme.fill),
            { '  ', hl = theme.tail },
          },
          hl = theme.fill,
        }
      end,
      -- option = {}, -- setup modules' option,
    })
    end
}

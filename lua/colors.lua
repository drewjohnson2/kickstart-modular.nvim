function setTransparent()
    -- setting transparency

    vim.api.nvim_set_hl(0, "Normal", { bg = 'none' })

    -- for some reason this is the bg of the Snacks Picker. 
    vim.api.nvim_set_hl(0, "NormalNC", { bg = 'none' }) 
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = 'none' })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = '#7aa4a1', bg = 'none' })
end

setTransparent()

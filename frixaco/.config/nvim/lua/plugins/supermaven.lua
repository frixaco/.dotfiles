return {
  {
    'supermaven-inc/supermaven-nvim',
    lazy = false,
    config = function()
      require('supermaven-nvim').setup({
        keymaps = {
          accept_suggestion = '<M-a>',
          clear_suggestion = '<C-]>',
          accept_word = '<C-j>',
        },
        ignore_filetypes = { cpp = true },
        log_level = 'off',
        color = {
          suggestion_color = '#ffffff',
          cterm = 244,
        },
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
      })
    end,
  },
}

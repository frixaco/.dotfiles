return {
  {
    'numToStr/Navigator.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<C-h>',
        mode = { 'n', 't' },
        '<CMD>NavigatorLeft<CR>',
        desc = 'Switch to the left pane',
        silent = true,
      },
      {
        '<C-l>',
        mode = { 'n', 't' },
        '<CMD>NavigatorRight<CR>',
        desc = 'Switch to the right pane',
        silent = true,
      },
      {
        '<C-k>',
        mode = { 'n', 't' },
        ':NavigatorUp<CR>',
        desc = 'Switch to the upper pane',
        silent = true,
      },
      {
        '<C-j>',
        mode = { 'n', 't' },
        '<CMD>NavigatorDown<CR>',
        desc = 'Switch to the lower pane',
        silent = true,
      },
      {
        '<C-p>',
        mode = { 'n', 't' },
        '<CMD>NavigatorPrevious<CR>',
        desc = 'Switch to the previous pane',
        silent = true,
      },
    },
    opts = {
      -- Save modified buffer(s) when moving to mux
      -- nil - Don't save (default)
      -- 'current' - Only save the current modified buffer
      -- 'all' - Save all the buffers
      auto_save = nil,

      -- Disable navigation when the current mux pane is zoomed in
      disable_on_zoom = false,

      -- Multiplexer to use
      -- 'auto' - Chooses mux based on priority (default)
      -- table - Custom mux to use
      mux = 'auto',
    },
  },
}

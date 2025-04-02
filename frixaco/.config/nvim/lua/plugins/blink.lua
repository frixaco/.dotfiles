return {
  {
    'saghen/blink.cmp',
    event = 'VeryLazy',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'Kaiser-Yang/blink-cmp-avante',
    }, -- 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Enables keymaps, completions and signature help when true (doesn't apply to cmdline or term)
      --
      -- If the function returns 'force', the default conditions for disabling the plugin will be ignored
      -- Default conditions: (vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false)
      -- Note that the default conditions are ignored when `vim.b.completion` is explicitly set to `true`
      --
      -- Exceptions: vim.bo.filetype == 'dap-repl'
      enabled = function()
        return not vim.tbl_contains({ 'lua', 'markdown' }, vim.bo.filetype)
      end,

      -- Disable cmdline
      cmdline = { enabled = true },

      completion = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before _and_ after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        keyword = { range = 'full' },

        -- Disable auto brackets
        -- NOTE: some LSPs may add auto brackets themselves anyway
        accept = { auto_brackets = { enabled = true } },

        -- Don't select by default, auto insert on selection
        list = { selection = { preselect = true, auto_insert = true } },
        -- or set via a function
        -- list = { selection = {
        --   preselect = function(ctx)
        --     return vim.bo.filetype ~= 'markdown'
        --   end,
        -- } },

        menu = {
          -- Don't automatically show the completion menu
          auto_show = true,

          -- nvim-cmp style menu
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind' },
            },
          },
        },

        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 500 },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },
      },

      sources = {
        -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
        default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
      },

      -- Use a preset for snippets, check the snippets documentation for more information
      -- snippets = { preset = 'default' | 'luasnip' | 'mini_snippets' },

      -- Experimental signature help support
      signature = { enabled = true },
    },
  },
}

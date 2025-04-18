return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        'stylua',
        'prettier',
        'clang-format',
        'goimports',
        'shfmt',
        'shellcheck',
        -- 'sonarlint-language-server',
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },

      'williamboman/mason.nvim',
      -- 'mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },

      -- {
      --   'hrsh7th/nvim-cmp',
      --   dependencies = {
      --     { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' }, -- Snippet Engine &
      --     'saadparwaiz1/cmp_luasnip', -- its associated nvim-cmp source
      --     'hrsh7th/cmp-nvim-lsp', -- Adds LSP completion capabilities
      --     'hrsh7th/cmp-cmdline',
      --     -- 'hrsh7th/cmp-buffer',
      --   },
      -- },
      'saghen/blink.cmp',
    },
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = true,
        virtual_lines = true,
        signs = true,
        underline = false,
      },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
      servers = {
        clangd = {},
        gopls = {},
        -- basedpyright = {},
        pyright = {},
        ruff = {},
        -- eslint = {},
        rust_analyzer = {},
        ts_ls = {},
        svelte = {},
        astro = {
          astro = {
            contentIntellisense = true,
            trace = {
              server = 'on',
            },
            updateImportsOnFileMove = {
              enabled = true,
            },
            experimental = {
              contentCollectionIntellisense = true,
            },
          },
        },
        html = {},
        emmet_language_server = {},
        graphql = {},
        cssls = {},
        tailwindcss = {
          root_dir = function(fname)
            return require('lspconfig').util.root_pattern('.git')(fname) or require('lspconfig').util.path.dirname(fname)
          end,
          tailwindCSS = {
            classAttributes = {
              'class',
              'className',
              'class:list',
              'classList',
              'ngClass',
              'containerClassname',
            },
            validate = true,
            experimental = {
              classRegex = {
                { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
                { 'cx\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              },
            },
          },
        },
        jsonls = {
          json = {
            schemas = {
              {
                fileMath = { 'package.json' },
                url = 'https://json.schemastore.org/package.json',
              },
              {
                fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
                url = 'https://json.schemastore.org/tsconfig.json',
              },
              {
                fileMath = {
                  '.prettierrc',
                  '.prettierrc.json',
                  'prettier.config.json',
                },
                url = 'https://json.schemastore.org/prettierrc.json',
              },
              {
                fileMath = { '.eslintrc', '.eslintrc.json' },
                url = 'https://json.schemastore.org/eslintrc.json',
              },
              {
                fileMatch = { 'pyrightconfig.json' },
                url = 'https://raw.githubusercontent.com/microsoft/pyright/main/packages/vscode-pyright/schemas/pyrightconfig.schema.json',
              },
              {
                fileMatch = { 'manifest.json' },
                url = 'https://json.schemastore.org/chrome-manifest',
              },
            },
          },
        },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
    },
    config = function(_, opts)
      local servers = opts.servers

      local on_attach = function(_, bufnr)
        local nnoremap = function(keys, func, desc)
          if desc then
            desc = 'LSP:  ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, desc = desc })
        end

        -- TODO: Find good alternative for Colemak layout
        nnoremap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
        nnoremap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
        nnoremap('<leader>e', vim.diagnostic.open_float, 'Open floating diagnostic message')
        nnoremap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')

        nnoremap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nnoremap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        nnoremap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [d]efinition')
        nnoremap('gD', require('telescope.builtin').lsp_type_definitions, '[G]oto [D]eclaration')
        nnoremap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nnoremap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nnoremap('K', vim.lsp.buf.hover, 'Hover documentation')
        -- nnoremap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nnoremap('<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'List [W]orkspace [F]olders')
        nnoremap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nnoremap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        -- nnoremap('<leader>f', function()
        --   vim.lsp.buf.format({ async = true })
        -- end, 'Format current buffer')
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, noremap = true, desc = 'LSP:  [C]ode [A]ction' })
      end

      local lspconfig = require('lspconfig')
      local util = require('lspconfig.util')
      local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server_name)
        local server_opts = {
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = (servers[server_name] or {}).filetypes,
        }
        lspconfig[server_name].setup(server_opts)
      end

      local mlsp = require('mason-lspconfig')
      local available = mlsp.get_available_servers()

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
      })
      require('mason-lspconfig').setup_handlers({ setup })

      require('lspconfig').gdscript.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'gd', 'gdscript', 'gdscript3' },
      })

      -- Full build should be installed, via Cargo e.g.
      require('lspconfig').taplo.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'toml' },
      })

      local function custom_root_dir(fname)
        -- Then pyrightconfig.json
        local pyright_config_root = util.root_pattern('pyrightconfig.json')(fname)
        if pyright_config_root then
          return pyright_config_root
        end

        -- Prioritize .git
        local git_root = util.find_git_ancestor(fname)
        if git_root then
          return git_root
        end

        -- Fallback markers (no .git needed here)
        local fallback_markers = {
          'requirements.txt',
          'pyproject.toml',
        }
        return util.root_pattern(unpack(fallback_markers))(fname) or util.path.dirname(fname)
      end
      require('lspconfig').pyright.setup({ root_dir = custom_root_dir })
    end,
  },
}

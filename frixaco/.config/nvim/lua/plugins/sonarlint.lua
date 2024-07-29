return {
  {
    'https://gitlab.com/schrieveslaach/sonarlint.nvim.git',
    event = 'VeryLazy',
    opts = {
      server = {
        cmd = {
          'sonarlint-language-server',
          '-stdio',
          '-analyzers',
          vim.fn.expand('~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjs.jar'),
        },
        settings = {
          sonarlint = {
            rules = {
              ['typescript:S101'] = { level = 'on' },
              ['typescript:S107'] = { level = 'on' },
              ['typescript:S1481'] = { level = 'on' },
              ['typescript:S1172'] = { level = 'on' },
              ['typescript:S4144'] = { level = 'on' },
              ['typescript:S3504'] = { level = 'on' },
              ['typescript:S3800'] = { level = 'on' },
              ['typescript:S2259'] = { level = 'on' },
              ['typescript:S3004'] = { level = 'on' },
              ['javascript:S2714'] = { level = 'on' },
              ['javascript:S3533'] = { level = 'on' },
              ['javascript:S1442'] = { level = 'on' },
              ['javascript:S1523'] = { level = 'on' },
              ['javascript:S1525'] = { level = 'on' },
              ['javascript:S1526'] = { level = 'on' },
              ['javascript:S3523'] = { level = 'on' },
              ['javascript:S3531'] = { level = 'on' },
              ['typescript:S134'] = { level = 'on' },
              ['typescript:S138'] = { level = 'on' },
              ['typescript:S103'] = { level = 'on' },
              ['typescript:S3776'] = { level = 'on' },
              ['typescript:S109'] = { level = 'on' },
              ['typescript:S1192'] = { level = 'on' },
              ['typescript:S106'] = { level = 'on' },
              ['typescript:S125'] = { level = 'on' },
              ['typescript:S108'] = { level = 'on' },
              ['typescript:S104'] = { level = 'on' },
              ['typescript:S1200'] = { level = 'on' },
              ['typescript:S1144'] = { level = 'on' },
              ['typescript:S1301'] = { level = 'on' },
              ['typescript:S2326'] = { level = 'on' },
              ['typescript:S4326'] = { level = 'on' },
              ['typescript:S100'] = { level = 'on' },
            },
          },
        },
      },
      filetypes = {
        'javascript',
        'typescript',
        'typescriptreact',
        'javascriptreact',
      },
    },
  },
}

vim.pack.add {
  {
    src = 'https://github.com/olimorris/codecompanion.nvim',
    version = vim.version.range('^19.0.0'),
  },
}

-- looking for env variables:
--   $DEEPSEEK_API_KEY
--   $GLM_API_KEY
--   $GLM_BASE_URL
require('codecompanion').setup {
  adapters = {
    http = {
      openai_compatible = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          env = {
            api_key = 'GLM_API_KEY',
            url = 'GLM_BASE_URL',
          },
        })
      end,
    },
  },
  interactions = {
    chat = {
      -- adapter = {
      --   name = 'deepseek',
      --   model = 'deepseek-v4-flash',
      -- }
      adapter = {
        name = 'openai_compatible',
        model = 'GLM-4.7',
      },
    },
    inline = {
      adapter = {
        name = 'openai_compatible',
        model = 'GLM-4.7',
      },
    },
    cli = {
      agent = 'claude_code',
      agents = {
        claude_code = {
          cmd = 'claude',
          args = {},
          description = 'Claude Code CLI',
          provider = 'terminal',
        },
      },
    },
  },
  opts = {
    log_level = 'INFO',
    language = 'chinese',
  },
}

vim.keymap.set('n', '<leader>cc', function()
  require('codecompanion').toggle_chat()
end, { desc = 'Toggle CodeCompanion Chat' })

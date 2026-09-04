# 😽 Neovim lua config

Neovim 0.12+ configuration.

## TODO

- [x] markdown 渲染 latex
- [x] `vim._core.ui2` 替代 `noice.nvim`
- [x] lsp progress
- [ ] 内置 catppuccin 主题适配 或者 尝试 rose-pine
- [x] 原生 comment 替代 ts-comments
- [ ] 原生 `an`/`in` 被 `mini.ai` 覆盖
- [ ] linter

## plugin manager

use native `vim.pack`.

running `vim.pack.update()` to open a buffer for managing plugins:

- `[[` and `]]` to navigate between plugin sections.
- `gO` to list all plugins.
- `K` to show diff details.
- `gra` to perform actions(update, skip or delete plugins)
- confirm changes with `:w` and discard with `:q`


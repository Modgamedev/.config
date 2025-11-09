-- =====================================================================
-- 🧩 ИНИЦИАЛИЗАЦИЯ lazy.nvim
-- =====================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Если lazy.nvim ещё не установлен — клонируем его
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- стабильная ветка
    lazypath,
  })
end
-- Добавляем в runtime path
vim.opt.rtp:prepend(lazypath)

-- Настройка lazy.nvim
require("lazy").setup({
  spec = "plugins",                              -- Где ищет плагины
  defaults = { lazy = true, version = false },   -- Ленивая загрузка, последние версии
  checker = { enabled = true },                  -- Автопроверка обновлений плагинов
})

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  -- Конфигурация neo-tree
  opts = {
    close_if_last_window = true, -- закрывать Neo-tree, если больше нет окон
    enable_git_status = true,    -- показывать git-статус
    -- Настройки окна neo-tree
    window = {
      position = "left",
      width = 35,
    },
    -- Настройки внешнего вида компонентов
    default_component_configs = {
      container = {
        enable_character_fade = true, -- края длинных файлов "затухают"
      },
      file_size = {
        enabled = true,          -- показывать колонку с размером файла
        width = 7,              -- ширина колонки в символах
        required_width = 35,     -- минимальная ширина окна, чтобы колонка отображалась
      },
    },
    -- Настройки буфера обмена
    clipboard = {
      sync = "universal", -- копирование доступно во всех Neovim и в системе
    },
  },
}

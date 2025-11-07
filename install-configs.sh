#!/usr/bin/env bash
# -e — остановить скрипт, если любая команда вернёт ошибку
# -u — остановить скрипт, если используем несуществующую переменную
# pipefail — остановить скрипт, если любая команда в пайпе вернёт ошибку
set -euo pipefail

# Папка, где лежит скрипт
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Папка по умолчанию для конфигов пакетов
CONFIG_DIR="$HOME/.config"

echo "=== ⚙ Установка конфигов из $SRC_DIR ⚙ ==="

# Копируем bash-файлы
cp -f "$SRC_DIR/.bashrc" "$HOME/.bashrc" || { echo "❌ Не удалось скопировать .bashrc"; exit 1; }
cp -f "$SRC_DIR/.bash_profile" "$HOME/.bash_profile" || { echo "❌ Не удалось скопировать .bash_profile"; exit 1; }
cp -f "$SRC_DIR/.dircolors" "$HOME/.dircolors" || { echo "❌ Не удалось скопировать .dircolors"; exit 1; }
echo "✅ Bash конфиги успешно установлены!"

# Копируем конфиги lsd
mkdir -p "$CONFIG_DIR/lsd" || { echo "❌ Не удалось создать папку $CONFIG_DIR/lsd"; exit 1; }
cp -rf "$SRC_DIR/lsd/"* "$CONFIG_DIR/lsd/" || { echo "❌ Ошибка при копировании LSD конфигов"; exit 1; }
echo "✅ LSD конфиги успешно установлены!"

# Возвращаемся в домашнюю директорию
cd "$HOME"

# Безопасно удаляем папку с репозиторием
if [[ "$SRC_DIR" == "$HOME/temp-config" ]]; then
    rm -rf "$SRC_DIR"
fi


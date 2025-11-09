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
cp -rf "$SRC_DIR/lsd/"* "$CONFIG_DIR/lsd/" || { echo "❌ Ошибка при копировании lsd конфигов"; exit 1; }
echo "✅ lsd конфиги успешно установлены!"

# Копируем конфиг bat
mkdir -p "$CONFIG_DIR/bat" || { echo "❌ Не удалось создать папку $CONFIG_DIR/bat"; exit 1; }
cp -rf "$SRC_DIR/bat/"* "$CONFIG_DIR/bat/" || { echo "❌ Ошибка при копировании bat конфига"; exit 1; }
echo "✅ bat конфиг успешно установлен!"

# Копируем конфиг niri
mkdir -p "$CONFIG_DIR/niri" || { echo "❌ Не удалось создать папку $CONFIG_DIR/niri"; exit 1; }
cp -rf "$SRC_DIR/niri/"* "$CONFIG_DIR/niri/" || { echo "❌ Ошибка при копировании niri конфига"; exit 1; }
echo "✅ niri конфиг успешно установлен!"

# Копируем конфиг foot
mkdir -p "$CONFIG_DIR/foot" || { echo "❌ Не удалось создать папку $CONFIG_DIR/foot"; exit 1; }
cp -rf "$SRC_DIR/foot/"* "$CONFIG_DIR/foot/" || { echo "❌ Ошибка при копировании foot конфига"; exit 1; }
echo "✅ foot конфиг успешно установлен!"

# Возвращаемся в домашнюю директорию
cd "$HOME" || { echo "❌ Не удалось перейти в домашнюю директорию"; exit 1; }

# Удаляем папку с репозиторием
rm -rf "$SRC_DIR"



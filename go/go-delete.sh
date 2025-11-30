#!/bin/bash
set -euo pipefail

echo "Go cleanup script..."

# 1. Проверяем, установлен ли Go
if ! command -v go &>/dev/null; then
    echo "Go не установлен на системе."
    exit 0
fi

GO_PATH=$(which go)
echo "Найден Go: $GO_PATH"

# 2. Проверяем, установлен ли через Homebrew
if brew list --formula | grep -q '^go$'; then
    echo "Go установлен через Homebrew."
    echo "Удаляем через brew..."
    brew uninstall go
    brew cleanup -s
    echo "Go удалён через Homebrew."
else
    # Предполагаем, что Go установлен через официальный дистрибутив
    echo "Go установлен напрямую (не через Homebrew)."
    # Обычно директория /usr/local/go
    if [ -d "/usr/local/go" ]; then
        echo "Удаляем /usr/local/go ..."
        sudo rm -rf /usr/local/go
        echo "Go удалён из /usr/local/go"
    else
        echo "Не удалось найти директорию /usr/local/go, удаление вручную."
    fi

    # Проверяем и чистим бинарники из PATH, если есть
    GO_BIN_DIR=$(dirname "$GO_PATH")
    if [[ "$GO_BIN_DIR" == "/usr/local/go/bin" ]]; then
        echo "Бинарники Go удалены вместе с /usr/local/go"
    else
        echo "В PATH остались бинарники Go, проверьте вручную: $GO_BIN_DIR"
    fi
fi

echo "Cleanup finished!"

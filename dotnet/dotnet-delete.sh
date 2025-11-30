#!/bin/bash
set -euo pipefail

echo ".NET cleanup script..."

# Проверяем, установлен ли dotnet
if ! command -v dotnet &>/dev/null; then
    echo ".NET не установлен на системе."
    exit 0
fi

DOTNET_PATH=$(which dotnet)
echo "Найден dotnet: $DOTNET_PATH"

# Проверяем, установлен ли через Homebrew
if brew list --formula | grep -q '^dotnet$'; then
    echo ".NET установлен через Homebrew."
    echo "Удаляем через brew..."
    brew uninstall --ignore-dependencies dotnet
    brew cleanup -s
    echo ".NET удалён через Homebrew."
else
    # Предполагаем, что .NET установлен напрямую
    if [ -d "/usr/local/share/dotnet" ]; then
        echo "Удаляем /usr/local/share/dotnet ..."
        sudo rm -rf /usr/local/share/dotnet
        echo ".NET удалён из /usr/local/share/dotnet"
    else
        echo "Не удалось найти директорию /usr/local/share/dotnet, удаление вручную."
    fi

    # Проверяем и чистим бинарники из PATH, если они остались
    DOTNET_BIN_DIR=$(dirname "$DOTNET_PATH")
    if [[ "$DOTNET_BIN_DIR" == "/usr/local/share/dotnet" ]] || [[ "$DOTNET_BIN_DIR" == "/usr/local/bin" ]]; then
        echo "Бинарники dotnet удалены вместе с /usr/local/share/dotnet или Homebrew symlinks."
    else
        echo "В PATH остались бинарники dotnet, проверьте вручную: $DOTNET_BIN_DIR"
    fi
fi

echo "Cleanup finished!"

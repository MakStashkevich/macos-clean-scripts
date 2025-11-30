#!/bin/bash
set -euo pipefail

echo "=== Flutter cleanup script ==="

# 1. Удаляем Flutter SDK
FLUTTER_DIRS=(
    "$HOME/flutter"
    "/usr/local/flutter"
)
for dir in "${FLUTTER_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "Removing Flutter SDK: $dir"
        rm -rf "$dir"
    fi
done

# 2. Удаляем pub-cache
if [ -d "$HOME/.pub-cache" ]; then
    echo "Removing Dart/Flutter pub-cache"
    rm -rf "$HOME/.pub-cache"
fi

# 3. Удаляем flutter/bin из PATH, если это символическая ссылка
if [ -d "/usr/local/bin" ]; then
    for bin in flutter dart; do
        if [ -L "/usr/local/bin/$bin" ]; then
            echo "Removing symlink: /usr/local/bin/$bin"
            sudo rm -f "/usr/local/bin/$bin"
        fi
    done
fi

# 4. VS Code плагины Flutter и Dart (опционально)
# VSCODE_EXT_DIR="$HOME/.vscode/extensions"
# ALLOWED_EXTENSIONS=() # Если хочешь оставить другие расширения
# if [ -d "$VSCODE_EXT_DIR" ]; then
#     for ext in "$VSCODE_EXT_DIR"/*; do
#         ext_name=$(basename "$ext")
#         if [[ "$ext_name" =~ ^(dart|flutter) ]]; then
#             echo "Removing VS Code extension: $ext_name"
#             rm -rf "$ext"
#         fi
#     done
# fi

echo "Flutter cleanup finished!"

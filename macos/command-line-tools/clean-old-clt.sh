#!/bin/bash
set -euo pipefail

SDK_DIR="/Library/Developer/CommandLineTools/SDKs"

# Получаем текущую версию macOS
MACOS_VERSION=$(sw_vers -productVersion)
echo "Current macOS version: $MACOS_VERSION"

# Формируем название нужного SDK
REQUIRED_SDK="MacOSX${MACOS_VERSION}.sdk"
echo "Required SDK: $REQUIRED_SDK"

# Проверяем, есть ли SDK
if [ ! -d "$SDK_DIR/$REQUIRED_SDK" ]; then
    echo "Required SDK not found: $REQUIRED_SDK"
    echo "You need to install Command Line Tools or download SDK manually."
    exit 1
fi

echo "Required SDK exists. Cleaning old SDKs..."

# Удаляем всё кроме нужного SDK
for sdk in "$SDK_DIR"/MacOSX*.sdk; do
    sdk_name=$(basename "$sdk")
    if [ "$sdk_name" != "$REQUIRED_SDK" ]; then
        echo "Removing old SDK: $sdk_name"
        sudo rm -rf "$sdk"
    fi
done

echo "SDK cleanup finished!"

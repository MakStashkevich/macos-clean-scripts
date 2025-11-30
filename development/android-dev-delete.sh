#!/bin/bash
set -euo pipefail

echo "Android development cleanup"

# 1. Android SDK
SDK_DIRS=(
    "$HOME/Library/Android/sdk"
    "/usr/local/share/android-sdk"
)
for dir in "${SDK_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "Removing Android SDK: $dir"
        rm -rf "$dir"
    fi
done

# 2. Android Studio
AS_APP="/Applications/Android Studio.app"
if [ -d "$AS_APP" ]; then
    echo "Removing Android Studio: $AS_APP"
    sudo rm -rf "$AS_APP"
fi

# 3. Android Studio configuration, plugins, caches
AS_SUPPORT="$HOME/Library/Application Support/AndroidStudio*"
AS_CACHES="$HOME/Library/Caches/AndroidStudio*"
AS_PREFS="$HOME/Library/Preferences/AndroidStudio*"
for path in $AS_SUPPORT $AS_CACHES $AS_PREFS; do
    if [ -e $path ]; then
        echo "Removing $path"
        rm -rf "$path"
    fi
done

# 4. Gradle cache
if [ -d "$HOME/.gradle" ]; then
    echo "Removing Gradle cache: ~/.gradle"
    rm -rf "$HOME/.gradle"
fi

# 5. Android AVDs and settings
if [ -d "$HOME/.android" ]; then
    echo "Removing Android virtual devices and settings: ~/.android"
    rm -rf "$HOME/.android"
fi

# 6. Flutter pub-cache (если используется для Android)
if [ -d "$HOME/.pub-cache" ]; then
    echo "Removing Flutter/Dart pub-cache: ~/.pub-cache"
    rm -rf "$HOME/.pub-cache"
fi

# 7. VS Code extensions Android-related (опционально)
VSCODE_EXT_DIR="$HOME/.vscode/extensions"
for ext in "$VSCODE_EXT_DIR"/*; do
    ext_name=$(basename "$ext")
    if [[ "$ext_name" =~ (dart|flutter|android) ]]; then
        echo "Removing VS Code extension: $ext_name"
        rm -rf "$ext"
    fi
done

echo "Android development cleanup finished"

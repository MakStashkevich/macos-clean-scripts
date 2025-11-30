#!/bin/bash
set -euo pipefail

echo "Starting macOS cleanup..."

# ----------------------------
# 1. Пользовательские кеши
# ----------------------------
echo "Cleaning user caches..."
rm -rf ~/Library/Caches/* 2>/dev/null || true
rm -rf ~/Library/Logs/*
rm -rf ~/Library/Application\ Support/CrashReporter/*

# ----------------------------
# 2. Системные временные файлы (безопасные)
# ----------------------------
echo "Cleaning system tmp directories..."
sudo rm -rf /tmp/*
sudo rm -rf /private/var/folders/*/*/*/C/com.apple.* 
sudo rm -rf /private/var/folders/*/*/*/T/*

# ----------------------------
# 3. User Downloads Cleanup (опционально)
# ----------------------------
# echo "Cleaning Downloads folder..."
# rm -rf ~/Downloads/*

# ----------------------------
# 4. Trash
# ----------------------------
echo "Emptying Trash..."
sudo rm -rf ~/.Trash/*

echo "Cleanup finished!"
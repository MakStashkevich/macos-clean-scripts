#!/bin/bash
set -euo pipefail

echo "Node.js / npm cleanup"

# 1. Очистка npm кеша
if command -v npm &>/dev/null; then
    echo "Cleaning npm cache..."
    npm cache clean --force
fi

# 2. Удаляем глобальные node_modules (опционально)
GLOBAL_NODE_MODULES=$(npm root -g 2>/dev/null || echo "")
if [ -n "$GLOBAL_NODE_MODULES" ] && [ -d "$GLOBAL_NODE_MODULES" ]; then
    echo "Removing global node_modules at $GLOBAL_NODE_MODULES..."
    rm -rf "$GLOBAL_NODE_MODULES"/*
fi

echo "Node.js / npm cleanup finished."

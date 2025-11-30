#!/usr/bin/env bash
set -e

LOCKFILE="brew-lock.json"

if [ ! -f "$LOCKFILE" ]; then
    echo "Нет $LOCKFILE. Создай его командой brew-lock-save.sh"
    exit 1
fi

# Чтение lock-файла
FORMULAE_LOCK=$(jq -r '.formulae[]' "$LOCKFILE")
CASKS_LOCK=$(jq -r '.casks[]' "$LOCKFILE")

brew update

# Удаление лишних formulae
INSTALLED_FORMULAE=$(brew list --formula)
for pkg in $INSTALLED_FORMULAE; do
    if ! grep -qx "$pkg" <<< "$FORMULAE_LOCK"; then
        echo "[Удаление formula] $pkg"
        brew uninstall --force --ignore-dependencies "$pkg" || true
    fi
done

# Удаление лишних casks
INSTALLED_CASKS=$(brew list --cask)
for pkg in $INSTALLED_CASKS; do
    if ! grep -qx "$pkg" <<< "$CASKS_LOCK"; then
        echo "[Удаление cask] $pkg"
        brew uninstall --cask --force "$pkg" || true
    fi
done

# Установка и обновление нужных formulae
for pkg in $FORMULAE_LOCK; do
    if brew list --formula | grep -q "^$pkg\$"; then
        echo "[Обновление] $pkg"
        brew upgrade "$pkg" || true
    else
        echo "[Установка] $pkg"
        brew install "$pkg"
    fi
done

# Установка и обновление casks
for pkg in $CASKS_LOCK; do
    if brew list --cask | grep -q "^$pkg\$"; then
        echo "[Обновление] $pkg"
        brew upgrade --cask "$pkg" || true
    else
        echo "[Установка] $pkg"
        brew install --cask "$pkg"
    fi
done

# Очистка мусора
brew autoremove || true
brew cleanup --prune=all
rm -rf "$(brew --cache)"/*

echo "Система приведена к состоянию lock-файла."

# Для проверки верной установки пакетов и их зависимостей
# brew doctor

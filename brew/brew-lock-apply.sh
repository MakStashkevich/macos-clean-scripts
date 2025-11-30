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

    # Получение пути к приложению через brew info --cask
    APP_NAME=$(brew info --cask "$pkg" | grep -E '\.app|\.prefPane' | head -n 1 | awk -F'(' '{print $1}' | xargs | awk -F'/' '{print $NF}')
    if [ -n "$APP_NAME" ]; then
        # Поиск приложения в /Applications, учитывая возможные различия в регистре и именах
        # Например, для "chromium" может быть "Chromium.app"
        APP_PATH=$(find /Applications -maxdepth 2 -iname "$APP_NAME" -print -quit)
    fi
    
    if [ -n "$APP_PATH" ] && [ -d "$APP_PATH" ]; then
        echo "[Применение xattr -cr] $APP_PATH"
        xattr -cr "$APP_PATH"
    else
        echo "[Предупреждение] Не удалось найти путь к приложению для '$pkg' через brew info --cask или приложение не существует. Пропуск xattr -cr."
    fi
done

# Очистка мусора
brew autoremove || true
brew cleanup --prune=all
rm -rf "$(brew --cache)"/*

echo "Система приведена к состоянию lock-файла."

# Для проверки верной установки пакетов и их зависимостей
# brew doctor

#!/bin/bash
set -euo pipefail

# ----------------------------
# Список разрешённых helper tools
# Здесь нужно указать демоны приложений которые тебе нужны
# ----------------------------
ALLOWED_HELPERS=(
    # Mac Fun Control
    "com.crystalidea.macsfancontrol.smcwrite"
    # Proxyman
    "com.proxyman.NSProxy.HelperTool"
)

HELPER_DIR="/Library/PrivilegedHelperTools"

echo "Scanning $HELPER_DIR ..."

# Проверяем и удаляем все файлы, которых нет в ALLOWED_HELPERS
for helper in "$HELPER_DIR"/*; do
    helper_name=$(basename "$helper")

    if [[ ! " ${ALLOWED_HELPERS[*]} " =~ " ${helper_name} " ]]; then
        echo "Unallowed helper found: $helper_name"

        # Останавливаем launchd job, если он существует
        if launchctl list | grep -q "$helper_name"; then
            echo "Stopping launchd job for $helper_name"
            sudo launchctl remove "$helper_name" || true
        fi

        echo "Deleting $helper_name"
        sudo rm -f "$helper"
    else
        echo "Allowed helper: $helper_name → keeping"
    fi
done

echo "Cleanup finished."

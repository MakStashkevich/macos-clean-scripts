# Сборник личных Bash-скриптов для macOS

Этот репозиторий содержит коллекцию моих личных Bash-скриптов, предназначенных для очистки кешей, удаления сред разработки и выполнения различных утилит на macOS.

## Содержание:

-   [**brew/**](brew/README.md)
    -   `brew-lock-save.sh`: Сохраняет список установленных Homebrew пакетов.
    -   `brew-lock-apply.sh`: Применяет сохранённый список Homebrew пакетов.
-   [**development/**](development/README.md)
    -   `android-dev-delete.sh`: Удаляет компоненты Android-разработки.
    -   `ios-dev-delete.sh`: Удаляет компоненты iOS-разработки.
-   [**dotnet/**](dotnet/README.md)
    -   `dotnet-delete.sh`: Удаляет .NET SDK.
-   [**flutter/**](flutter/README.md)
    -   `flutter-delete.sh`: Удаляет Flutter SDK.
-   [**go/**](go/README.md)
    -   `go-delete.sh`: Удаляет Go SDK.
-   [**java/**](java/README.md)
    -   `java-delete-jdk.sh`: Удаляет Java Development Kit (JDK).
-   [**macos/**](macos/README.md)
    -   `clean-cache-trash.sh`: Очищает пользовательские кеши и корзину.
    -   `clean-helper-tools.sh`: Удаляет неразрешенные вспомогательные инструменты.
-   [**macos/command-line-tools/**](macos/command-line-tools/README.md)
    -   `clean-old-clt.sh`: Удаляет старые SDK Command Line Tools.
    -   `force-update-clt.sh`: Принудительно переустанавливает Command Line Tools.
-   [**npm/**](npm/README.md)
    -   `npm-delete.sh`: Очищает кеш npm и глобальные `node_modules`.
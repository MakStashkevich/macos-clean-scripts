# Скрипты для очистки сред разработки

Эта папка содержит скрипты для удаления кешей и временных файлов, связанных с различными средами разработки.

## Скрипты:

- [`android-dev-delete.sh`](development/android-dev-delete.sh): Удаляет Android SDK, Android Studio, его конфигурационные файлы, кеши Gradle, Android AVDs и связанные расширения VS Code.
- [`ios-dev-delete.sh`](development/ios-dev-delete.sh): Удаляет DerivedData, архивы Xcode, симуляторы iOS, старые SDK Command Line Tools, кеши Xcode и Swift пакетов.

## Использование:

Для использования скриптов просто запустите соответствующий файл:

```bash
./android-dev-delete.sh
./ios-dev-delete.sh
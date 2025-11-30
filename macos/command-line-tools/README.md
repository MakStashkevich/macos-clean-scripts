# Скрипты для управления Command Line Tools

Эта папка содержит скрипты для управления Command Line Tools (CLT) в macOS.

## Скрипты:

- [`clean-old-clt.sh`](macos/command-line-tools/clean-old-clt.sh): Удаляет старые версии SDK из Command Line Tools, оставляя только SDK, соответствующий текущей версии macOS.
- [`force-update-clt.sh`](macos/command-line-tools/force-update-clt.sh): Принудительно удаляет и переустанавливает Command Line Tools. Это может быть полезно для решения проблем с CLT или для обновления до последней версии.

## Использование:

Для очистки старых SDK:

```bash
./clean-old-clt.sh
```

Для принудительного обновления CLT:

```bash
./force-update-clt.sh
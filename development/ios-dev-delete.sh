#!/bin/bash
set -euo pipefail

echo "iOS development cleanup"

# 1. DerivedData (проекты Xcode)
DERIVED_DATA="$HOME/Library/Developer/Xcode/DerivedData"
if [ -d "$DERIVED_DATA" ]; then
    echo "Removing DerivedData..."
    rm -rf "$DERIVED_DATA"
fi

# 2. Archives (сборки проектов)
ARCHIVES="$HOME/Library/Developer/Xcode/Archives"
if [ -d "$ARCHIVES" ]; then
    echo "Removing Xcode Archives..."
    rm -rf "$ARCHIVES"
fi

# 3. iOS Simulators (device support, runtimes)
SIMULATORS="$HOME/Library/Developer/CoreSimulator/Devices"
if [ -d "$SIMULATORS" ]; then
    echo "Removing iOS simulators..."
    rm -rf "$SIMULATORS"
fi

# 4. Command Line Tools old SDKs
SDK_DIR="/Library/Developer/CommandLineTools/SDKs"
if [ -d "$SDK_DIR" ]; then
    echo "Cleaning old CommandLineTools SDKs..."
    # Оставляем только SDK текущей macOS
    MACOS_VERSION=$(sw_vers -productVersion)
    REQUIRED_SDK="MacOSX${MACOS_VERSION}.sdk"
    for sdk in "$SDK_DIR"/MacOSX*.sdk; do
        sdk_name=$(basename "$sdk")
        if [ "$sdk_name" != "$REQUIRED_SDK" ]; then
            echo "Removing old SDK: $sdk_name"
            sudo rm -rf "$sdk"
        fi
    done
fi

# 5. Device Support (старые версии iOS для Xcode)
DEVICE_SUPPORT="$HOME/Library/Developer/Xcode/iOS DeviceSupport"
if [ -d "$DEVICE_SUPPORT" ]; then
    echo "Removing old iOS Device Support..."
    rm -rf "$DEVICE_SUPPORT"
fi

# 6. Xcode caches
XCODE_CACHES="$HOME/Library/Caches/com.apple.dt.Xcode"
if [ -d "$XCODE_CACHES" ]; then
    echo "Cleaning Xcode caches..."
    rm -rf "$XCODE_CACHES"
fi

# 7. Swift package caches
SWIFT_PACKAGES="$HOME/Library/Developer/Xcode/DerivedData/*/SourcePackages"
if [ -d "$SWIFT_PACKAGES" ]; then
    echo "Cleaning Swift package caches..."
    rm -rf "$SWIFT_PACKAGES"
fi

echo "iOS development cleanup finished"

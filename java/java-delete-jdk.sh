#!/usr/bin/env bash
set -e

# Удаление всех JDK
sudo rm -rf /Library/Java/JavaVirtualMachines/jdk*.jdk

# Удаление плагинов Oracle Java
sudo rm -rf /Library/PreferencePanes/JavaControlPanel.prefPane
sudo rm -rf /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin
sudo rm -rf /Library/LaunchAgents/com.oracle.java.Java-Updater.plist
sudo rm -rf /Library/PrivilegedHelperTools/com.oracle.java.JavaUpdateHelper
sudo rm -rf /Library/LaunchDaemons/com.oracle.java.Helper-Tool.plist
sudo rm -rf /Library/Preferences/com.oracle.java.Helper-Tool.plist

# Удаление остаточных папок
sudo rm -rf /Library/Java/*
sudo rm -rf /Library/PreferencePanes/Java*
sudo rm -rf /Library/Internet\ Plug-Ins/Java*

echo "JDK Java полностью удалены"
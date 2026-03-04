#!/bin/bash
set -euo pipefail

echo "Starting macOS Mail cleanup..."

rm -rf ~/Library/Mail                     
rm -rf ~/Library/Containers/com.apple.mail

echo "Cleanup finished!"
#!/usr/bin/env bash
set -e

LOCKFILE="brew-lock.json"

FORMULAE=$(brew list --formula)
CASKS=$(brew list --cask)

{
  echo "{"
  echo '  "formulae": ['
  for f in $FORMULAE; do
    echo "    \"${f}\","
  done | sed '$ s/,$//'
  echo '  ],'
  echo '  "casks": ['
  for c in $CASKS; do
    echo "    \"${c}\","
  done | sed '$ s/,$//'
  echo '  ]'
  echo "}"
} > "$LOCKFILE"

echo "Lock-файл сохранён: $LOCKFILE"

#!/usr/bin/env bash
# Refuses a commit that stages .env, even via `git add -f`.
set -euo pipefail

staged=$(git diff --cached --name-only --diff-filter=ACM)

if printf '%s\n' "${staged}" | grep -qxE '\.env|.*/\.env'; then
  echo "error: .env is staged. It holds the Algolia admin key and must not be committed."
  echo "       Unstage it with: git restore --staged .env"
  exit 1
fi

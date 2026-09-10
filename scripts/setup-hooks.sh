#!/usr/bin/env bash
#
# One-time per clone: installs the pre-commit hooks and registers the
# git-secrets patterns.
#
# git-secrets keeps its patterns in .git/config, which is not shared between
# clones, so they are stored in .gitsecrets / .gitsecrets-allowed and loaded
# from here.
#
set -euo pipefail

cd "$(dirname "$0")/.."

missing=()
for tool in pre-commit trufflehog git; do
  command -v "${tool}" >/dev/null 2>&1 || missing+=("${tool}")
done
git secrets --list >/dev/null 2>&1 || command -v git-secrets >/dev/null 2>&1 || missing+=("git-secrets")

if [[ ${#missing[@]} -gt 0 ]]; then
  echo "error: missing required tools: ${missing[*]}"
  echo "  pre-commit  : pipx install pre-commit"
  echo "  trufflehog  : brew install trufflehog"
  echo "  git-secrets : brew install git-secrets"
  exit 1
fi

echo "Installing pre-commit hooks..."
pre-commit install

echo "Registering git-secrets patterns..."
# Clear previous registrations so re-running stays idempotent.
git config --remove-section secrets 2>/dev/null || true

while IFS= read -r pattern; do
  [[ -z "${pattern}" || "${pattern}" == \#* ]] && continue
  git secrets --add -- "${pattern}"
done < .gitsecrets

while IFS= read -r pattern; do
  [[ -z "${pattern}" || "${pattern}" == \#* ]] && continue
  git secrets --add --allowed --literal -- "${pattern}"
done < .gitsecrets-allowed

echo
echo "Done. Registered patterns:"
git secrets --list

echo
echo "Run the full suite against every file with:  pre-commit run --all-files"

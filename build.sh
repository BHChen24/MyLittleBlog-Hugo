#!/usr/bin/env bash
#
# Builds the site on Vercel. Vercel's Hugo preset pins a very old version, so
# Hugo is downloaded explicitly here and kept in step with local development.
#
set -euo pipefail

HUGO_VERSION=0.166.0

# Match the local toolchain: extended adds WebP encoding, which PaperMod's
# profile partial uses when resizing the avatar.
HUGO_ARCHIVE="hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"

# Vercel persists .vercel/cache between builds; keeping Hugo's cache there makes
# image processing and remote fetches survive rebuilds.
export HUGO_CACHEDIR="${PWD}/.vercel/cache/hugo"

build_temp_dir=$(mktemp -d)
trap 'rm -rf "${build_temp_dir}"' EXIT SIGINT SIGTERM

echo "Installing Hugo ${HUGO_VERSION} (extended)..."
curl -sfL --output-dir "${build_temp_dir}" -O \
  "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ARCHIVE}"
mkdir -p "${HOME}/.local/hugo"
tar -C "${HOME}/.local/hugo" -xf "${build_temp_dir}/${HUGO_ARCHIVE}"
export PATH="${HOME}/.local/hugo:${PATH}"

hugo version

# HUGO_PARAMS_ALGOLIA_APPID and HUGO_PARAMS_ALGOLIA_SEARCHAPIKEY come from the
# Vercel project environment and override params.algolia in hugo.yaml. They must
# be set for Preview as well, or preview deployments render an inert search page.
echo "Building site..."
hugo --gc --minify

# Push the search index only from production deployments. Preview builds share
# the same Algolia credentials, so pushing from them would overwrite the live
# index with branch content.
if [[ "${VERCEL_ENV:-}" == "production" ]]; then
  if [[ -n "${ALGOLIA_APP_ID:-}" && -n "${ALGOLIA_ADMIN_KEY:-}" ]]; then
    echo "Pushing Algolia index..."
    node scripts/algolia-push.mjs
  else
    echo "Algolia credentials not set — skipping index push."
  fi
else
  echo "VERCEL_ENV=${VERCEL_ENV:-unset} — skipping index push (production only)."
fi

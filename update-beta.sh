#!/usr/bin/env bash
# update-beta.sh — promote a QA-verified Android APK to the stable `beta` channel.
#
# The permanent download URL never changes:
#   https://github.com/KostaAmigo/nido-apk-distribution/releases/download/beta/NIDO-arm64-preview.apk
#
# This script is the ONLY way a build reaches `beta`, and it is run manually
# AFTER QA. Experimental/unverified builds (published under their commit tag by
# scripts/build-android.sh) never touch `beta`.
#
# Usage:
#   ./update-beta.sh <APK_PATH> <VERSION> <COMMIT_SHA>
#   e.g. ./update-beta.sh NIDO-a39822d-arm64-preview.apk 0.1.0 a39822d
set -euo pipefail

APK="${1:?usage: update-beta.sh <APK_PATH> <VERSION> <COMMIT_SHA>}"
VERSION="${2:?version (e.g. 0.1.0)}"
COMMIT="${3:?commit short sha}"

REPO="KostaAmigo/nido-apk-distribution"
ASSET_NAME="NIDO-arm64-preview.apk"
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/beta/${ASSET_NAME}"
GH="${GH:-$HOME/bin/gh}"
APKSIGNER="${APKSIGNER:-$HOME/Library/Android/sdk/build-tools/36.0.0/apksigner}"

# 1. Refuse to promote a build that does not verify (signature / integrity).
if ! "$APKSIGNER" verify "$APK" >/dev/null 2>&1; then
  echo "ERROR: apksigner verify failed for: $APK" >&2
  echo "Refusing to promote an unverified build to the beta channel." >&2
  exit 1
fi

# 2. Compute SHA-256 and today's date.
SHA="$(shasum -a 256 "$APK" | awk '{print $1}')"
DATE="$(date '+%Y-%m-%d')"

# 3. Upload under the STABLE asset name (overwrites the previous beta asset,
#    keeping the permanent URL unchanged).
TMP_ASSET="$(mktemp -d)/${ASSET_NAME}"
cp "$APK" "$TMP_ASSET"
"$GH" release upload beta "$TMP_ASSET" --repo "$REPO" --clobber
rm -rf "$(dirname "$TMP_ASSET")"

# 4. Refresh the release notes.
NOTES="$(mktemp)"
cat > "$NOTES" <<EOF
# NIDO Android Beta (verified)

This \`beta\` tag points to the current **QA-verified** Android beta build.
It is only updated after a build passes QA — experimental/unverified builds never land here.

- **Version:** ${VERSION}
- **Build / commit:** ${COMMIT}
- **SHA-256:** ${SHA}
- **Published:** ${DATE}
EOF
"$GH" release edit beta --repo "$REPO" --notes-file "$NOTES" >/dev/null
rm -f "$NOTES"

# 5. Regenerate the README metadata block between the beta-meta markers.
META_BLOCK="| Параметр | Значение |
|---|---|
| **Версия** | ${VERSION} |
| **Сборка (commit)** | \`${COMMIT}\` |
| **SHA-256** | \`${SHA}\` |
| **Опубликовано** | ${DATE} |"
perl -0pi -e "s{<!-- beta-meta:start -->.*?<!-- beta-meta:end -->}{<!-- beta-meta:start -->\n${META_BLOCK}\n<!-- beta-meta:end -->}s" README.md

# 6. Commit and push.
git add README.md
git commit -m "beta: promote ${VERSION} (${COMMIT})" --quiet
git push origin main --quiet

echo "Done."
echo "  Permanent URL: ${DOWNLOAD_URL}"
echo "  Version:       ${VERSION}"
echo "  Commit:        ${COMMIT}"
echo "  SHA-256:       ${SHA}"

#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "$(readlink -f "$0")")"

DIR_ROOT="$(readlink -f "$(pwd)/..")"
DIR_ICONPACK="${DIR_ROOT}/iconpack"
DIR_STYLE="${DIR_ROOT}/style"
DIR_DIST="${DIR_ROOT}/dist"
ARCHIVE_ICONPACK='dark_extended.ts3_iconpack'
ARCHIVE_STYLE='dark_extended.ts3_style'
ARCHIVE_ADDON='dark_extended.ts3_addon'

pushd() {
    command pushd "$@" >/dev/null
}

popd() {
    command popd "$@" >/dev/null
}

# ------------------------------------
#  Cleanup
# ------------------------------------

echo
echo 'Running cleanup tasks'
echo

echo ' - Removing old icon pack archive...'
rm -f "${DIR_DIST}/${ARCHIVE_ICONPACK}"
echo ' - Removing old style archive...'
rm -f "${DIR_DIST}/${ARCHIVE_STYLE}"
echo ' - Removing old addon archive...'
rm -f "${DIR_DIST}/${ARCHIVE_ADDON}"

# ------------------------------------
#  Build Packages
# ------------------------------------

echo
echo 'Building packages'
echo
pushd "$DIR_ROOT"

echo ' - Building icon pack archive...'
pushd "$DIR_ICONPACK"
zip -r "${DIR_DIST}/${ARCHIVE_ICONPACK}" -- 'package.ini' 'gfx'
popd
echo

echo ' - Building style archive...'
pushd "$DIR_STYLE"
zip -r "${DIR_DIST}/${ARCHIVE_STYLE}" -- 'package.ini' 'styles'
popd
echo

echo ' - Building addon archive...'
pushd "$DIR_ICONPACK"
zip -r "${DIR_DIST}/${ARCHIVE_ADDON}" -- 'gfx'
popd
pushd "$DIR_STYLE"
zip -r "${DIR_DIST}/${ARCHIVE_ADDON}" -- 'styles'
popd
zip -r "${DIR_DIST}/${ARCHIVE_ADDON}" -- 'package.ini'
echo

exit 0

#!/usr/bin/env sh

# Updates version of ms-edge dev

set -euo pipefail

# figuring out a path to ms-edge subdir
script_dir=$(dirname $(realpath $0))
edge_dir="${script_dir}/../general/microsoft-edge-dev-bin"

latest=$(curl --silent https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/ | xmllint --html --xpath '//a/text()' - | grep 'microsoft-edge-dev.*deb' | tail -n 1 | sed 's/microsoft-edge-dev_//g; s/-1_amd64.deb//g' )
current=$(cat ${edge_dir}/PKGBUILD | grep pkgver= | sed 's/pkgver=//g')

if [[ "$latest" > "$current" ]];then
  echo "An update available: [${latest}] over [${current}]"
  cd "$edge_dir"
  sed -i "s/${current}/${latest}/g" PKGBUILD
  updpkgsums
  makepkg --printsrcinfo > .SRCINFO
  makepkg
  git commit PKGBUILD .SRCINFO -m "ms-edge: ${latest} version bump"
elif [[ "$latest" == "$current" ]];then
  echo "Current version is up to date at $current"
else
  echo "WTF?! [latest: ${latest}] & [current: ${current}]"
fi

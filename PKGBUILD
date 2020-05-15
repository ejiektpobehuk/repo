# Maintainer: ml <ml@visu.li>
pkgname=sonobuoy
pkgver=0.18.2
pkgrel=1
pkgdesc='Diagnostic tool for Kubernetes clusters'
arch=('x86_64')
url='https://github.com/vmware-tanzu/sonobuoy'
license=('Apache')
depends=('glibc')
optdepends=(
  'docker: sonobuoy images subcommand'
  'kubectl: advances workflows')
makedepends=('go' 'gzip' 'git')
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha256sums=('9f84bbb7d443684f008e99c233f4ed6da23e142ddb25818842786357efd1c078')

prepare() {
  cd "${pkgname}-${pkgver}"
  go mod download
}

build() {
  local _commit _defines
  # illegal packaging technique
  _commit=$(zcat "${pkgname}-${pkgver}.tar.gz" | git get-tar-commit-id)
  cd "${pkgname}-${pkgver}"
  export CGO_ENABLED=1
  export CGO_LDFLAGS="$LDFLAGS"
  export CGO_CFLAGS="$CFLAGS"
  export CGO_CPPFLAGS="$CPPFLAGS"
  export CGO_CXXFLAGS="$CXXFLAGS"
  export GOFLAGS='-buildmode=pie -modcacherw -mod=readonly -trimpath'
  _defines=(
    "github.com/vmware-tanzu/sonobuoy/pkg/buildinfo.Version=v${pkgver}"
    "github.com/vmware-tanzu/sonobuoy/pkg/buildinfo.GitSHA=${_commit}"
  )
  go build -o "$pkgname" -ldflags "${_defines[*]/#/-X=}"
}

check() {
  cd "${pkgname}-${pkgver}"
  go test ./cmd/... ./pkg/...
}

package() {
  cd "${pkgname}-${pkgver}"
  install -Dm755 "$pkgname" -t "${pkgdir}/usr/bin"
}

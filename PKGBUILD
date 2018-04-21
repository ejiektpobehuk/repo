# Maintainer: Tom Wadley <tom@tomwadley.net>

pkgname=nvm
pkgver=0.33.9
pkgrel=1
pkgdesc="Node Version Manager - Simple bash script to manage multiple active node.js versions"
url="https://github.com/creationix/nvm"
arch=('any')
license=('MIT')
optdepends=('bash: bash completion')
install="${pkgname}.install"
source=("https://github.com/creationix/nvm/archive/v${pkgver}.zip"
        "init-nvm.sh"
        "install-nvm-exec")
sha256sums=('206c1388d1a845f3bbfeed18a1399581f7e811b28a5c694671b1193d23bcb4c4'
            '692317bfd036557f59543fef9b67ff38de68208d30361fe385291f58d3ac0425'
            'a0d249e4a906b0406cc5867c86b9860b820a4ad5f29e37f377349c1d5b6eba51')

build() {
  cd "${pkgname}-${pkgver}"
}

package() {
  cd "${srcdir}"

  # convenience script
  install -Dm644 init-nvm.sh "$pkgdir/usr/share/$pkgname/init-nvm.sh"

  # companion script which installs nvm-exec in NVM_DIR where upstream expects it
  install -Dm644 install-nvm-exec "$pkgdir/usr/share/$pkgname/install-nvm-exec"

  cd "${pkgname}-${pkgver}"

  # nvm itself
  install -Dm644 nvm.sh "$pkgdir/usr/share/$pkgname/nvm.sh"

  # nvm-exec script for 'nvm exec' command
  install -Dm755 nvm-exec "$pkgdir/usr/share/$pkgname/nvm-exec"

  # bash completion
  install -Dm644 bash_completion "$pkgdir/usr/share/$pkgname/bash_completion"

  # license
  install -Dm644 LICENSE.md "$pkgdir/usr/share/licenses/$pkgname/LICENSE.md"
}

# vim:set ts=2 sw=2 et:

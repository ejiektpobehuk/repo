# Maintainer: Bert Peters <bert@bertptrs.nl>
# Contributor: Alexander Schäferdiek <alexander@schaeferdiek.eu>
# Contributor: Florian Klink <flokli@flokli.de>

pkgbase=spotifyd
pkgname=('spotifyd' 'spotifyd-pulseaudio')
pkgver=0.2.2
pkgrel=1
arch=('x86_64' 'armv7h' 'aarch64')
license=('GPL3')
depends=('alsa-lib' 'libogg' 'gcc-libs')
makedepends=('cargo' 'libpulse')
pkgdesc="A spotify playing daemon"
url="https://github.com/Spotifyd/$pkgbase"
source=("$pkgbase-$pkgver.tar.gz::https://github.com/Spotifyd/$pkgbase/archive/v$pkgver.tar.gz")
sha256sums=('6b79072efbfe1f3c831e898da2c340d806f778d598e6797347e5605d2201ec43')

build() {
  cd "$srcdir/spotifyd-$pkgver"
  cargo build --release
  # Compile any remaining libraries for pulseaudio
  cargo build --release --features pulseaudio_backend
}

package_spotifyd() {
  cargo install --root "$pkgdir/usr" --path "$srcdir/$pkgbase-$pkgver"
  rm "$pkgdir/usr/.crates.toml"
  install -D -m 644 "$srcdir/$pkgbase-$pkgver/contrib/spotifyd.service" "$pkgdir/usr/lib/systemd/user/spotifyd.service"
}

package_spotifyd-pulseaudio() {
  depends=(libpulse)
  conflicts=(spotifyd)
  pkgdesc="$pkgdesc, with pulseaudio support"
  cargo install --root "$pkgdir/usr" --path "$srcdir/$pkgbase-$pkgver" --features pulseaudio_backend
  rm "$pkgdir/usr/.crates.toml"
  install -D -m 644 "$srcdir/$pkgbase-$pkgver/contrib/spotifyd.service" "$pkgdir/usr/lib/systemd/user/spotifyd.service"
}

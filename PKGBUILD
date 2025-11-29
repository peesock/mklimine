pkgname=mklimine-git
pkgver=r4.16922dd
pkgrel=1
pkgdesc="Scriptable Limine config file generator"
arch=('any')
url="https://github.com/peesock/mklimine.git"
#url="file://$PWD"
license=('GPL')
depends=('awk' 'sh')
source=("${pkgname}::git+${url}")
sha256sums=('SKIP')

pkgver() {
	cd "${pkgname}"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
}

package() {
	cd "${pkgname}"
	make PREFIX=/usr DESTDIR="${pkgdir}"
}

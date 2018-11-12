# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="deoplete-jedi"
HOMEPAGE="https://github.com/zchee/deoplete-jedi"
EGIT_REPO_URI="https://github.com/zchee/deoplete-jedi.git"
EGIT_COMMIT="4ffb3a5ace39143813d63c7f78137bf8478b91e9"
SRC_URI=""
KEYWORDS="~amd64 ~x86 ~arm"

PROPERTIES="live"
LICENSE="MIT"
SLOT="0"
IUSE="+doc"

DEPEND=""
RDEPEND="app-vim/deoplete"

src_compile() {
	true
}

src_install() {
	insinto /usr/share/vim/vimfiles
	doins -r rplugin
	use doc && dodoc README.md
	find "${D}" -name ".git*" -exec rm -rf {} +
	find "${D}" -name .travis.yml -exec rm -rf {} +
	use doc || find "${D}" -name LICENSE.txt -exec rm -rf {} +
	use doc || find "${D}" -name README.rst -exec rm -rf {} +
	use doc || find "${D}" -name AUTHORS.txt -exec rm -rf {} +
	use doc || find "${D}" -name README.md -exec rm -rf {} +
	use doc || find "${D}" -name CHANGELOG.rst -exec rm -rf {} +
	use doc || find "${D}" -name CONTRIBUTING.md -exec rm -rf {} +
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="deoplete-jedi"
HOMEPAGE="https://github.com/zchee/deoplete-jedi"
EGIT_REPO_URI="https://github.com/zchee/deoplete-jedi.git"
EGIT_COMMIT="ba16d628484c3ba2c86f3a3350f3c12fd9df283b"
SRC_URI=""
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="app-nvim/deoplete
		 dev-python/jedi"

src_compile() {
	true
}

src_install() {
	insinto /usr/share/nvim/runtime
	doins -r rplugin
	dodoc README.md LICENSE
}

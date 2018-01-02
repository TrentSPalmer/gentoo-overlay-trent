# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils vim-plugin

DESCRIPTION="vimscripts plugin: open-close pair of characters"
HOMEPAGE="https://github.com/vim-scripts/AutoClose"
SRC_URI="https://github.com/vim-scripts/AutoClose/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv AutoClose-1.2 "${P}"
}

src_prepare() {
	default
}

src_install() {
	insinto /usr/share/nvim/runtime
	doins -r plugin
	vim-plugin_src_install
}

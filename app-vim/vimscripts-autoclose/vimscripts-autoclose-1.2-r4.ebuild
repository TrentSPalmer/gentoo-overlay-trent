# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils vim-plugin

DESCRIPTION="vimscripts plugin: open-close pair of characters"
HOMEPAGE="https://github.com/vim-scripts/AutoClose"
SRC_URI="https://github.com/vim-scripts/AutoClose/archive/${PV}.tar.gz -> ${P}.tar.gz"

# unknown license, actually
LICENSE="vim"
KEYWORDS="~amd64 ~x86 ~arm"

# to enable invented use flags vim and neovim,
# they are described in metadata.xml
IUSE="+doc +vim +neovim"

# runtime dependencies
RDEPEND="
vim? ( app-editors/vim )
neovim? ( app-editors/neovim )
"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv AutoClose-1.2 "${P}"
}

src_prepare() {
	default
}

src_install() {
	use vim && vim-plugin_src_install
	use doc || rm -rf "${D}/usr/share/doc"
}

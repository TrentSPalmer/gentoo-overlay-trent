# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin

DESCRIPTION="Dark powered asynchronous completion framework for neovim"
HOMEPAGE="https://github.com/Shougo/deoplete.nvim"
SRC_URI="https://github.com/Shougo/deoplete.nvim/archive/${PV}-serial.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE="+doc"

DEPEND=""
RDEPEND="app-editors/neovim[python]"

src_compile() {
	true
}

src_install() {
	insinto /usr/share/vim/vimfiles
	doins -r autoload
	use doc && doins -r doc
	doins -r plugin
	doins -r rplugin
	use doc && dodoc README.md
}

pkg_postinst() {
	echo -n "Updating vim help tags..."
	/usr/bin/vim --noplugins -u NONE -U NONE --cmd ":helptags /usr/share/vim/vimfiles/doc" --cmd ":q" > /dev/null 2>&1
	echo "done. "
}

pkg_postrm() {
	echo -n "Updating vim help tags..."
	/usr/bin/vim --noplugins -u NONE -U NONE --cmd ":helptags /usr/share/vim/vimfiles/doc" --cmd ":q" > /dev/null 2>&1
	echo "done. "
}

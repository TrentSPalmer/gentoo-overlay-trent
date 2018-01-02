# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Dark powered asynchronous completion framework for neovim"
HOMEPAGE="https://github.com/Shougo/deoplete.nvim"
EGIT_REPO_URI="https://github.com/Shougo/deoplete.nvim.git"
EGIT_COMMIT="45f23f1586e7edc13c1fafca201a33112a4700f7"
SRC_URI=""
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="app-editors/neovim[python]"

src_compile() {
	true
}

src_install() {
	insinto /usr/share/nvim/runtime
	doins -r autoload
	doins -r doc
	doins -r plugin
	doins -r rplugin
	dodoc README.md LICENSE
}

pkg_postinst() {
	echo -n "Updating neovim (nvim) help tags..."
    /usr/bin/nvim --noplugins -u NONE -U NONE --cmd ":helptags /usr/share/nvim/runtime/doc" --cmd ":q" > /dev/null 2>&1
    echo "done. "
}

pkg_postrm() {
	echo -n "Updating neovim (nvim) help tags..."
    /usr/bin/nvim --noplugins -u NONE -U NONE --cmd ":helptags /usr/share/nvim/runtime/doc" --cmd ":q" > /dev/null 2>&1
    echo "done. "
}

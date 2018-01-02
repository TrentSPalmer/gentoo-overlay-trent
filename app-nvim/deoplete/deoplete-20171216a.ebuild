# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Dark powered asynchronous completion framework for neovim"
HOMEPAGE="https://github.com/Shougo/deoplete.nvim"
EGIT_REPO_URI="https://github.com/Shougo/deoplete.nvim.git"
EGIT_COMMIT="28e2a57d891b69080ddd3a1fc56c69c78b3c21bc"
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

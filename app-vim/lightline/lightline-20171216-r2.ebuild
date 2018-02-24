# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin git-r3

EGIT_REPO_URI="https://github.com/itchyny/lightline.vim.git"
EGIT_COMMIT="b19faca129f7921766c0a32a7c378dc89a61e590"
SRC_URI=""
KEYWORDS="~amd64 ~x86"
PROPERTIES="live"

DESCRIPTION="vim plugin: A light and configurable statusline/tabline"
HOMEPAGE="https://github.com/itchyny/lightline.vim/"
LICENSE="vim.org"
IUSE="+doc"
VIM_PLUGIN_HELPFILES="${PN}"

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="You may have to update \$TERM in your environment,
see https://github.com/itchyny/lightline.vim"

src_prepare() {
	default
}

src_install() {
	insinto /usr/share/nvim/runtime
	doins -r autoload
	doins -r doc
	doins -r plugin
	vim-plugin_src_install
	use doc || rm -rf "${D}/usr/share/doc"
}

pkg_postinst() {
	elog "${DOC_CONTENTS}"
	echo -n "Updating neovim (nvim) help tags..."
	/usr/bin/nvim --noplugins -u NONE -U NONE --cmd ":helptags /usr/share/nvim/runtime/doc" --cmd ":q" > /dev/null 2>&1
	echo "done. "
}

pkg_postrm() {
	echo -n "Updating neovim (nvim) help tags..."
	/usr/bin/nvim --noplugins -u NONE -U NONE --cmd ":helptags /usr/share/nvim/runtime/doc" --cmd ":q" > /dev/null 2>&1
	echo "done. "
}

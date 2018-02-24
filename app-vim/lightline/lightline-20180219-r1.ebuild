# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin git-r3

EGIT_REPO_URI="https://github.com/itchyny/lightline.vim.git"
EGIT_COMMIT="78c43c144643e49c529a93b9eaa4eda12614f923"
SRC_URI=""
KEYWORDS="~amd64 ~x86"
PROPERTIES="live"

DESCRIPTION="vim plugin: A light and configurable statusline/tabline"
HOMEPAGE="https://github.com/itchyny/lightline.vim/"
LICENSE="vim.org"
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

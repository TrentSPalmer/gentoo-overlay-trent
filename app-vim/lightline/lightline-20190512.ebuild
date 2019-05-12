# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin git-r3

EGIT_REPO_URI="https://github.com/itchyny/lightline.vim.git"
EGIT_COMMIT="bb0b4013611e11200d2ae5a65e8804bbd930a770"
SRC_URI=""
KEYWORDS="~amd64 ~x86 ~arm"
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
	vim-plugin_src_install
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin git-r3

EGIT_REPO_URI="https://github.com/itchyny/lightline.vim.git"
EGIT_COMMIT="d70d69b3418957cdf7c4993e484f8b9d3eb1603c"
SRC_URI=""
KEYWORDS="~amd64 ~arm ~x86"
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

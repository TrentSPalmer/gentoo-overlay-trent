# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin git-r3


DESCRIPTION="vim plugin: Next generation completion framework after neocomplcache"
HOMEPAGE="https://github.com/Shougo/neocomplete.vim"
EGIT_REPO_URI="https://github.com/Shougo/neocomplete.vim.git"
EGIT_COMMIT="1401a1c6ab56546c55804ba09e6c9fe87654e954"
SRC_URI=""
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"

IUSE=""

RDEPEND="|| (
>app-editors/vim-7.3.885[lua]
>app-editors/gvim-7.3.885[lua] )
!app-vim/neocomplcache"

VIM_PLUGIN_HELPFILES=""
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI=""
VIM_PLUGIN_MESSAGES=""

src_prepare() {
	default
}

src_install() {
	egit_clean
	vim-plugin_src_install
}

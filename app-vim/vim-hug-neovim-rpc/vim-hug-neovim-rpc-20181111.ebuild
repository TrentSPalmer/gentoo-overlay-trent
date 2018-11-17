# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin git-r3

DESCRIPTION="vim plugin: vim-hug-neovim-rpc"
HOMEPAGE="https://github.com/roxma/vim-hug-neovim-rpc"
EGIT_REPO_URI="https://github.com/roxma/vim-hug-neovim-rpc"
EGIT_COMMIT="a8cdb6b627da3a9c4b8ea85a329112484a857cf1"
SRC_URI=""

RDEPENDS="app-vim/nvim-yarp"

PROPERTIES="live"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

VIM_PLUGIN_HELPFILES=""
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI=""
VIM_PLUGIN_MESSAGES=""
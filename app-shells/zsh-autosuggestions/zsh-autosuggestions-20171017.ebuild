# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3 readme.gentoo-r1

DESCRIPTION="Fish shell like fast/unobtrusive autosuggestions for zsh"
HOMEPAGE="https://github.com/zsh-users/zsh-autosuggestions"
EGIT_COMMIT="d6d9a469819c2bddb4d4f1d0d353070af96226e2"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"

ZSH_DEST="/usr/share/zsh/site-contrib/${PN}"
DISABLE_AUTOFORMATTING="true"

DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add to your ~/.zshrc
source '${ZSH_DEST}/zsh-autosuggestions.zsh'"

src_install() {
	insinto "${ZSH_DEST}"
	doins -r *
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
	elog "${DOC_CONTENTS}"
}

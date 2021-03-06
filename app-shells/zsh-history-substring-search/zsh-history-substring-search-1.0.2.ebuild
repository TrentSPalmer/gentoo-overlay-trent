# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit readme.gentoo-r1

DESCRIPTION="A ZSH plugin to search history, a clean-room impl of the Fish shell feature"
HOMEPAGE="https://github.com/zsh-users/zsh-history-substring-search"
SRC_URI="https://github.com/zsh-users/zsh-history-substring-search/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=BSD
SLOT="0"
KEYWORDS="amd64 x86 ~arm"
IUSE="+doc"

DEPEND=""
RDEPEND="${DEPEND}
		app-shells/zsh"

ZSH_DEST="/usr/share/zsh/site-contrib/${PN}"
DISABLE_AUTOFORMATTING="true"

DOC_CONTENTS="     ********************************
In order to use ${CATEGORY}/${PN} add to your ~/.zshrc
source '${ZSH_DEST}/zsh-history-substring-search.zsh'
************** and also add hotkeys ***************
bindkey '\\\eOA' history-substring-search-up
bindkey '\\\eOB' history-substring-search-down"

src_install() {
	use doc || rm "${S}/README.md"
	insinto "${ZSH_DEST}"
	doins -r *
	use doc && readme.gentoo_create_doc
}

pkg_postinst() {
	use doc && readme.gentoo_print_elog
	elog "${DOC_CONTENTS}"
}

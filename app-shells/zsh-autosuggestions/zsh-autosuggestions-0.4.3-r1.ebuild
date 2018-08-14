# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils readme.gentoo-r1

DESCRIPTION="Fish shell like fast/unobtrusive autosuggestions for zsh"
HOMEPAGE="https://github.com/zsh-users/zsh-autosuggestions"
SRC_URI="https://github.com/zsh-users/zsh-autosuggestions/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="+doc"

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"

ZSH_DEST="/usr/share/zsh/site-contrib/${PN}"
DISABLE_AUTOFORMATTING="true"

DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add to your ~/.zshrc
source '${ZSH_DEST}/zsh-autosuggestions.zsh'"

src_compile() {
	make -B zsh-autosuggestions.zsh
}

src_install() {
	install -d "${D}${ZSH_DEST}"
	cp -a --no-preserve=ownership "zsh-autosuggestions.zsh" "${D}${ZSH_DEST}/"
	use doc && dodoc CHANGELOG.md DESCRIPTION README.md LICENSE VERSION
	use doc && readme.gentoo_create_doc
}

pkg_postinst() {
	use doc && readme.gentoo_print_elog
	elog "${DOC_CONTENTS}"
}

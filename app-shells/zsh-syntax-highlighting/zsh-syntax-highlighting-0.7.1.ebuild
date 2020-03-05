# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils readme.gentoo-r1

DESCRIPTION="Fish shell-like syntax highlighting for Zsh"
HOMEPAGE="https://github.com/zsh-users/zsh-syntax-highlighting"
SRC_URI="https://github.com/zsh-users/zsh-syntax-highlighting/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 arm"
IUSE="+doc"

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"

ZSH_DEST="/usr/share/zsh/site-contrib/${PN}"
DISABLE_AUTOFORMATTING="true"

DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add to your ~/.zshrc
source '${ZSH_DEST}/zsh-syntax-highlighting.zsh'"

MAKE_ARGS=(
	"SHARE_DIR=${ED}/usr/share/zsh/site-contrib/${PN}"
	"DOC_DIR=${ED}/usr/share/doc/${PF}"
)

src_compile() {
	emake "${MAKE_ARGS[@]}"
}

src_install() {
	emake "${MAKE_ARGS[@]}" install
	use doc && dodoc changelog.md COPYING.md HACKING.md INSTALL.md README.md release.md
	use doc && readme.gentoo_create_doc
	use doc || rm -rf "${D}/usr/share/doc"
}

pkg_postinst() {
	use doc && readme.gentoo_print_elog
	elog "${DOC_CONTENTS}"
}

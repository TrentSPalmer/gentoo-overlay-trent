# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="grml's zsh setup"
HOMEPAGE="https://grml.org/zsh/"
SRC_URI="https://deb.grml.org/pool/main/g/grml-etc-core/grml-etc-core_${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc"

DEPEND="doc? ( app-text/txt2tags )"
RDEPEND="${DEPEND}
		app-shells/zsh
		sys-process/procps
		sys-apps/grep
		sys-apps/coreutils
		sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv grml-etc-core-"${PV}" "${P}"
}

src_compile() {
	cd "${S}/doc"
	use doc && make
}

src_install() {
	install -D -m644 "${S}/etc/skel/.zshrc" "${D}/etc/skel/.zshrc"
	install -D -m644 "${S}/etc/zsh/keephack" "${D}/etc/zsh/keephack"
	install -D -m644 "${S}/etc/zsh/zshrc" "${D}/etc/zsh/zshrc"
	use doc && install -D -m644 "${S}/doc/grmlzshrc.5" "${D}/usr/share/man/man5/grmlzshrc.5"
}

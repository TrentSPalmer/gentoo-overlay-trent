# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit readme.gentoo-r1

DESCRIPTION="DuckDuckGo from the terminal"
HOMEPAGE="https://github.com/jarun/ddgr"
SRC_URI="https://github.com/jarun/ddgr/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=GPL-3
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc"

DEPEND=""
# RDEPEND="${DEPEND}"
RDEPEND="dev-lang/python"

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="     ********************************
All configuration is from the environment, so i.e.
\`export BROWSER=w3m\` or \`export BROWSER=firefox\`
in your bashrc or whatever, and also \`ddgr -h\`
as well as \`man ddgr\` do what you expect
man page requires USE="doc"
*************************************************"

src_install() {
	install -Dm755 "${S}/ddgr" "${D}/usr/bin/ddgr"
	use doc && install -Dm644 "${S}/ddgr.1" "${D}/usr/share/man/man1/ddgr.1"
	install -Dm644 "${S}/auto-completion/fish/ddgr.fish" "${D}/usr/share/fish/vendor_completions.d/ddgr.fish"
	install -Dm644 "${S}/auto-completion/bash/ddgr-completion.bash" "${D}/usr/share/bash-completion/completions/ddgr"
	install -Dm644 "${S}/auto-completion/zsh/_ddgr" "${D}/usr/share/zsh/site-functions/_ddgr"
	use doc && readme.gentoo_create_doc
	use doc && dodoc CHANGELOG LICENSE README.md
}

pkg_postinst() {
	use doc && readme.gentoo_print_elog
	elog "${DOC_CONTENTS}"
}

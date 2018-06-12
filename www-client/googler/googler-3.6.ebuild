# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit readme.gentoo-r1

DESCRIPTION="Google from the terminal"
HOMEPAGE="https://github.com/jarun/googler"
SRC_URI="https://github.com/jarun/googler/archive/v${PV}.tar.gz -> ${P}.tar.gz"

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
in your bashrc or whatever, and also \`googler -h\`
as well as \`man googler\` do what you expect
man page requires USE="doc"
*************************************************"

src_install() {
	install -Dm755 "${S}/googler" "${D}/usr/bin/googler"
	use doc && install -Dm644 "${S}/googler.1" "${D}/usr/share/man/man1/googler.1"
	install -Dm644 "${S}/auto-completion/fish/googler.fish" "${D}/usr/share/fish/vendor_completions.d/googler.fish"
	install -Dm644 "${S}/auto-completion/bash/googler-completion.bash" "${D}/usr/share/bash-completion/completions/googler"
	install -Dm644 "${S}/auto-completion/zsh/_googler" "${D}/usr/share/zsh/site-functions/_googler"
	use doc && readme.gentoo_create_doc
	use doc && dodoc CHANGELOG LICENSE README.md
}

pkg_postinst() {
	use doc && readme.gentoo_print_elog
	elog "${DOC_CONTENTS}"
}

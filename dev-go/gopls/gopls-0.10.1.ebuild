# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module
EGO_PN="github.com/golang/tools/archive/gopls"
SRC_URI="https://${EGO_PN}/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

DESCRIPTION="official language server for the go language"
HOMEPAGE="https://github.com/golang/tools"

LICENSE="MIT BSD BSD-2 Apache-2.0"
SLOT="0"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv tools-${PN}-v${PV} ${P}
}

src_compile() {
	cd ${S}/gopls
	go build
}

src_install() {
	# dodoc README.md CONTRIBUTING.md CONTRIBUTORS AUTHORS LICENSE PATENTS
	dodoc README.md CONTRIBUTING.md LICENSE PATENTS
	dobin gopls/gopls
}

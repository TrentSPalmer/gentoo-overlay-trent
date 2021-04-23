# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python3_{8,9})

inherit distutils-r1

DESCRIPTION="Asynchronous HTTP for Humans"
HOMEPAGE="https://github.com/ross/requests-futures"
SRC_URI="https://github.com/ross/requests-futures/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x64-solaris"
IUSE=""

RDEPEND="
	>=dev-python/requests-2.21.0[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

# tests connect to various remote sites
RESTRICT="test"

python_test() {
	py.test || die
}

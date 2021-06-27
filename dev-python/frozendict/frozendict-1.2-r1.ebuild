# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python3_{7,8,9})

inherit distutils-r1

DESCRIPTION="immutable wrapper around dictionaries"
HOMEPAGE="https://pypi.org/project/frozendict/"
SRC_URI="https://files.pythonhosted.org/packages/4e/55/a12ded2c426a4d2bee73f88304c9c08ebbdbadb82569ebdd6a0c007cfd08/frozendict-1.2.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x64-solaris"

RDEPEND="
	dev-lang/python
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

# tests connect to various remote sites
RESTRICT="test"

python_test() {
	py.test || die
}

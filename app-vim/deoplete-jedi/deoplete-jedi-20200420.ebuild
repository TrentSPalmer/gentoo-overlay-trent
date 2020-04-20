# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="deoplete-jedi"
HOMEPAGE="https://github.com/zchee/deoplete-jedi"
EGIT_REPO_URI="https://github.com/zchee/deoplete-jedi.git"
EGIT_COMMIT="2d2ff2382fd67574c233d0ce48150b26eb7f6809"
SRC_URI=""
EGIT_SUBMODULES=()
KEYWORDS="~amd64 ~arm ~x86"

PROPERTIES="live"
LICENSE="MIT"
SLOT="0"
IUSE="+doc"

DEPEND=""
RDEPEND="
	app-vim/deoplete
	dev-python/jedi
"

src_compile() {
	true
}

src_install() {
	rm -rf rplugin/python3/deoplete/vendored
	# pushd rplugin/python3/deoplete/vendored/jedi
	# ls | grep -v '^jedi$' | xargs rm -rf; popd
	# pushd rplugin/python3/deoplete/vendored/parso
	# ls | grep -v '^parso$' | xargs rm -rf; popd
	# pushd rplugin/python3/deoplete/vendored/jedi/jedi/third_party/typeshed/
	# ls | grep -v '\(^stdlib$\|^third_party$\)' | xargs rm -rf; popd

	insinto /usr/share/vim/vimfiles
	doins -r rplugin
	use doc && dodoc README.md
	find "${D}" -name ".git*" -exec rm -rf {} +
	find "${D}" -name .travis.yml -exec rm -rf {} +
	find "${D}" -name .coveragerc -exec rm -rf {} +
	find "${D}" -name .flake8 -exec rm -rf {} +
	use doc || find "${D}" -name LICENSE.txt -exec rm -rf {} +
	use doc || find "${D}" -name README.rst -exec rm -rf {} +
	use doc || find "${D}" -name AUTHORS.txt -exec rm -rf {} +
	use doc || find "${D}" -name README.md -exec rm -rf {} +
	use doc || find "${D}" -name CHANGELOG.rst -exec rm -rf {} +
	use doc || find "${D}" -name CONTRIBUTING.md -exec rm -rf {} +
}

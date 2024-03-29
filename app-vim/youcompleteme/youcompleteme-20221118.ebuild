# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_10 )

inherit eutils cmake git-r3 multilib python-single-r1 vim-plugin

DESCRIPTION="vim plugin: a code-completion engine for Vim"
HOMEPAGE="https://github.com/Valloric/YouCompleteMe"
EGIT_REPO_URI="https://github.com/Valloric/YouCompleteMe"
EGIT_COMMIT="1702de03d551317a1bcd94ded2972857ebc16d74"
SRC_URI=""
EGIT_SUBMODULES=(
	'third_party/ycmd'
	)

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clang +doc test go tern +neovim typescript"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	clang? ( >=sys-devel/clang-7.0:= )
	go?   ( dev-go/gopls )
	tern? ( net-libs/nodejs )
	typescript? ( net-libs/nodejs )
	neovim? (
		>=app-editors/neovim-0.5.0
		dev-python/pynvim
	)
	dev-libs/boost[python]
	|| (
		app-editors/vim[python]
		app-editors/gvim[python]
	)
"

RDEPEND="
	${COMMON_DEPEND}
	dev-python/bottle
	dev-python/regex
	dev-python/sh
	dev-python/numpydoc
	>=dev-python/jedi-0.12.1
	dev-python/parso
	dev-python/watchdog
"
DEPEND="
	${COMMON_DEPEND}
	test? (
		>=dev-python/mock-1.0.1
		>=dev-python/nose-1.3.0
		dev-cpp/gmock
		dev-cpp/gtest
	)
"

CMAKE_IN_SOURCE_BUILD=1
CMAKE_USE_DIR=${S}/third_party/ycmd/cpp

VIM_PLUGIN_HELPFILES="${PN}"

src_prepare() {
	default

	if ! use test ; then
		sed -i '/^add_subdirectory( tests )/d' third_party/ycmd/cpp/ycm/CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DUSE_CLANG_COMPLETER="$(usex clang)"
		-DUSE_SYSTEM_LIBCLANG="$(usex clang)"
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_GMOCK=ON
		-DUSE_PYTHON2=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	if use tern;
	then
		cd "${S}/third_party/ycmd/third_party/tern_runtime" || die "no dir third_party/tern_runtime"
		npm install --production --python=python3 || die "npm install failed"
	fi

	if use typescript;
	then
		mkdir -p "${S}/third_party/ycmd/third_party/tsserver" || die "no dir third_party/tsserver"
		npm install -g --prefix third_party/tsserver typescript --python=python3
	fi

}

src_test() {
	cd "${S}/third_party/ycmd/cpp/ycm/tests"
	LD_LIBRARY_PATH="${EROOT}"/usr/$(get_libdir)/llvm \
		./ycm_core_tests || die

	cd "${S}"/python/ycm

	local dirs=( "${S}"/third_party/*/ "${S}"/third_party/ycmd/third_party/*/ )
	local -x PYTHONPATH=${PYTHONPATH}:$(IFS=:; echo "${dirs[*]}")

	nosetests --verbose || die
}

src_install() {

	if use go;
	then
		mkdir -p "${S}/third_party/ycmd/third_party/go/bin"
		ln -s /usr/bin/gopls  "${S}/third_party/ycmd/third_party/go/bin/gopls"
	fi

	cd "${S}"
	use doc && dodoc *.md third_party/ycmd/*.md
	# rm -r *.md *.sh *.py* *.ini *.yml COPYING.txt third_party/ycmd/cpp third_party/ycmd/ci third_party/ycmd/examples/samples || die
	rm -r *.md *.sh *.py* *.ini *.yml COPYING.txt third_party/ycmd/examples/samples || die
	# rm -r third_party/ycmd/{*.md,*.sh,*.yml,.coveragerc,.gitignore,.gitmodules,.travis.yml,build.*,*.txt,run_tests.*,*.ini,update*} || die
	rm -r third_party/ycmd/{*.md,*.sh,*.yml,.coveragerc,.gitignore,.gitmodules,build.*,*.txt,run_tests.*,*.ini,update*} || die
	find python -name *test* -exec rm -rf {} + || die
	find third_party/ycmd/third_party -name test -exec rm -rf {} + || die
	egit_clean
	# use clang && (rm third_party/ycmd/third_party/clang/lib/libclang.so* || die)

	vim-plugin_src_install

	use go || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/ycmd/completers/go"
	use go || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/third_party/go"
	if ! use tern;
	then
		if ! use typescript;
		then
			rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/third_party/tern_runtime"
			rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/ycmd/completers/javascript"
		fi
	fi
	# use tern || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/third_party/tern_runtime"
	# use nodejs || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/ycmd/completers/javascript"
	find "${D}" -name .gitignore -exec rm -rf {} + || die
	find "${D}" -name .travis.yml -exec rm -rf {} + || die
	find "${D}" -name README.rst -exec rm -rf {} + || die

	python_optimize "${ED}"
	python_fix_shebang "${ED}"
}

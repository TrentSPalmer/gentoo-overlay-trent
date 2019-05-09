# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )

inherit eutils cmake-utils git-r3 multilib python-single-r1 vim-plugin

DESCRIPTION="vim plugin: a code-completion engine for Vim"
HOMEPAGE="https://github.com/Valloric/YouCompleteMe"
EGIT_REPO_URI="https://github.com/Valloric/YouCompleteMe"
EGIT_COMMIT="944e7f5383dcc48a6ccfa598f353e6aefe97eb5b"
SRC_URI=""
EGIT_SUBMODULES=(
	'third_party/ycmd'
	'third_party/OmniSharpServer'
	'cecil'
	'NRefactory'
	'third_party/racerd'
	'third_party/go/src/github.com/mdempsky/gocode'
	'third_party/go/src/github.com/rogpeppe/godef'
	)

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clang +doc test mono go rust nodejs +neovim"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	clang? ( >=sys-devel/clang-7.0:= )
	mono? ( dev-lang/mono )
	go?   ( dev-lang/go )
	rust? ( dev-lang/rust
	        app-vim/rust-vim
	)
	nodejs? ( net-libs/nodejs )
	neovim? ( app-editors/neovim[python] )
	dev-libs/boost[python,threads,${PYTHON_USEDEP}]
	|| (
		app-editors/vim[python,${PYTHON_USEDEP}]
		app-editors/gvim[python,${PYTHON_USEDEP}]
	)
"

RDEPEND="
	${COMMON_DEPEND}
	dev-python/bottle[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/frozendict[${PYTHON_USEDEP}]
	dev-python/requests-futures[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/waitress[${PYTHON_USEDEP}]
	dev-python/numpydoc[${PYTHON_USEDEP}]
	>=dev-python/jedi-0.12.1[${PYTHON_USEDEP}]
	dev-python/parso[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]
"
DEPEND="
	${COMMON_DEPEND}
	test? (
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/nose-1.3.0[${PYTHON_USEDEP}]
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
	# Argparse is included in python 2.7
	rm -r "${S}"/third_party/ycmd/cpp/BoostParts || die "Failed to remove bundled boost"

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

	if use rust;
	then
		cd "${S}"/third_party/ycmd/third_party/racerd || die "no dir third_party/racerd"
		cargo build --release || die "cargo build failed"
	fi

	if use mono;
	then
		cd "${S}/third_party/ycmd/third_party/OmniSharpServer" || die "failed cd to OmniSharpServer"
		xbuild /property:Configuration=Release || die "xbuild command failed"
	fi

	if use go;
	then
		export GOPATH="$GOPATH:${S}/third_party/ycmd/third_party/go"
		cd "${S}/third_party/ycmd/third_party/go/src/github.com/mdempsky/gocode" || die "failed cd to gocode"
		go build || die "failed to go build gocode GOPATH is $GOPATH"
		cd "${S}/third_party/ycmd/third_party/go/src/github.com/rogpeppe/godef" || die "failed cd to godef"
		go build || die "failed to go build godef GOPATH is $GOPATH"
	fi

	if use nodejs;
	then
		cd "${S}/third_party/ycmd/third_party/tern_runtime" || die "no dir third_party/tern_runtime"
		npm install --production --python=python3 || die "npm install failed"
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

	if use rust;
	then
		cd "${S}/third_party/ycmd/third_party/racerd" || die "racerd target wasn't built"
		for f in $(ls -a | tail -n +3 | grep -v target)
		do
			rm -rf "${f}"
		done
		cd "${S}/third_party/ycmd/third_party/racerd/target/release" || die "racerd target wasn't built"
		for f in $(ls -a | tail -n +3 | grep -v '^racerd$')
		do
			rm -rf "${f}"
		done
	fi

	if use mono;
	then
		cd "${S}/third_party/ycmd/third_party/OmniSharpServer"
		for f in $(ls -a | tail -n +3 | grep -v '^OmniSharp$')
		do
			rm -rf "${f}"
		done
		cd "${S}/third_party/ycmd/third_party/OmniSharpServer/OmniSharp"
		for f in $(ls -a | tail -n +3 | grep -v '^bin$')
		do
			rm -rf "${f}"
		done
	fi

	if use go;
	then
		cd "${S}/third_party/ycmd/third_party/go/src/github.com/mdempsky/gocode"
		for f in $(ls -a | tail -n +3 | grep -v '^gocode$')
		do
			rm -rf "${f}"
		done
		cd "${S}/third_party/ycmd/third_party/go/src/github.com/rogpeppe/godef"
		for f in $(ls -a | tail -n +3 | grep -v '^godef$')
		do
			rm -rf "${f}"
		done
	fi

	cd "${S}"
	use doc && dodoc *.md third_party/ycmd/*.md
	rm -r *.md *.sh *.py* *.ini *.yml COPYING.txt third_party/ycmd/cpp third_party/ycmd/ci third_party/ycmd/examples/samples || die
	rm -r third_party/ycmd/{*.md,*.sh,*.yml,.coveragerc,.gitignore,.gitmodules,.travis.yml,build.*,*.txt,run_tests.*,*.ini,update*} || die
	find python -name *test* -exec rm -rf {} + || die
	find third_party/ycmd/third_party -name test -exec rm -rf {} + || die
	egit_clean
	use clang && (rm third_party/ycmd/third_party/clang/lib/libclang.so* || die)

	vim-plugin_src_install

	use mono || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/third_party/OmniSharpServer"
	use rust || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/third_party/racerd"
	use rust || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/ycmd/completers/rust"
	use go || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/ycmd/completers/go"
	use go || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/third_party/go"
	use nodejs || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/third_party/tern_runtime"
	use nodejs || rm -rf "${D}/usr/share/vim/vimfiles/third_party/ycmd/ycmd/completers/javascript"
	find "${D}" -name .gitignore -exec rm -rf {} + || die
	find "${D}" -name .travis.yml -exec rm -rf {} + || die
	find "${D}" -name README.rst -exec rm -rf {} + || die

	python_optimize "${ED}"
	python_fix_shebang "${ED}"
}

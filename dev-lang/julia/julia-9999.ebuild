# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-r3 elisp-common eutils multilib pax-utils

DESCRIPTION="High-level, high-performance dynamic programming language for technical computing"

HOMEPAGE="http://julialang.org/"

if [[ ${PV/9999} != ${PV} ]] ; then
	EGIT_REPO_URI="https://github.com/JuliaLang/julia.git"
	inherit git-r3
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="https://github.com/JuliaLang/julia/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc emacs notebook"

RDEPEND="
	dev-libs/double-conversion
	dev-libs/gmp
	dev-libs/libpcre
	dev-libs/utf8proc
	dev-util/patchelf
	sci-libs/arpack
	sci-libs/fftw
	sci-libs/openlibm
	>=sci-libs/suitesparse-4.0
	sci-mathematics/glpk
	>=sys-devel/llvm-3.0
	>=sys-libs/libunwind-1.1
	sys-libs/readline
	sys-libs/zlib
	virtual/blas
	virtual/lapack
	emacs? ( !app-emacs/ess )
	notebook? ( www-servers/lighttpd )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# /usr/include/suitesparse is for debian only
	# respect prefix, flags
	sed -i \
		-e 's|^\(SUITESPARSE_INC\s*=\).*||g' \
		-e 's|/usr/bin/||g' \
		-e "s|/usr/include|${EROOT%/}/usr/include|g" \
		-e "s|-O3|${CFLAGS}|g" \
		deps/Makefile || die

	# Detect what BLAS and LAPACK implementations are being used
	local blasname="$($(tc-getPKG_CONFIG) --libs-only-l blas | sed 's/ .*$//')"
	local lapackname="$($(tc-getPKG_CONFIG) --libs-only-l lapack | sed 's/ .*$//')"

	sed -i \
		-e 's|\(USE_QUIET\s*\)=.*|\1=0|g' \
		-e 's|\(USE_SYSTEM_.*\)=.*|\1=1|g' \
		-e 's|\(USE_SYSTEM_LIBUV\)=.*|\1=0|g' \
		-e 's|\(USE_SYSTEM_LIBM\)=.*|\1=0|g' \
		-e "s|-lblas|${blasname}|" \
		-e "s|libblas|${blasname/-l/lib}.so|" \
		-e "s|-llapack|${lapackname}|" \
		-e "s|liblapack|${lapackname/-l/lib}.so|" \
		-e 's|\(JULIA_EXECUTABLE = \)\($(JULIAHOME)/julia\)|\1 LD_LIBRARY_PATH=$(BUILD)/$(get_libdir) \2|' \
		-e "s|-O3|${CFLAGS}|g" \
		-e "s|LIBDIR = lib|LIBDIR = $(get_libdir)|" \
		Make.inc || die

	sed -i \
		-e "s|\$(BUILD)/lib|\$(BUILD)/$(get_libdir)|" \
		-e "s|\$(JL_LIBDIR),lib|\$(JL_LIBDIR),$(get_libdir)|" \
		-e "s|\$(JL_PRIVATE_LIBDIR),lib|\$(JL_PRIVATE_LIBDIR),$(get_libdir)|" \
		Makefile || die

	# do not set the RPATH
	sed -e "/RPATH = /d" -e "/RPATH_ORIGIN = /d" -i Make.inc
}

src_compile() {
	emake cleanall
	mkdir -p usr/$(get_libdir) || die
	pushd usr || die
	ln -s $(get_libdir) lib || die
	popd
	emake julia-release
	pax-mark m usr/bin/julia-readline
	pax-mark m usr/bin/julia-basic
	emake
	use doc && make -C doc html
	if use notebook; then
		make -j2 -C ui/webserver
		sed -e "s|etc|/share/julia/etc|" \
		-i usr/bin/launch-julia-webserver ||die
	fi
	use emacs && elisp-compile contrib/julia-mode.el
}

src_install() {
	emake -j2 install prefix="${D}/usr"

	cat > 99julia <<-EOF
		LDPATH=${EROOT%/}/usr/$(get_libdir)/julia
	EOF
	doenvd 99julia
	if use notebook; then
		cp -R ui/website "${D}/usr/share/julia"
		insinto /usr/share/julia/etc
		doins deps/lighttpd.conf
	fi
	if use emacs; then
		elisp-install "${PN}" contrib/julia-mode.el
		elisp-site-file-install "${FILESDIR}"/63julia-gentoo.el
	fi
	use doc && dohtml -r doc/_build/html/*
	dodoc README.md
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

src_test() {
	emake test || die "Running tests failed"
}

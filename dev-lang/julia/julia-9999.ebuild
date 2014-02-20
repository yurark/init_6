# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="High-level, high-performance dynamic programming language for technical computing"

HOMEPAGE="http://julialang.org/"

# uses gfortran in some places, dependencies don't reflect that yet
if [[ ${PV/9999} != ${PV} ]] ; then
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/JuliaLang/julia.git"
	inherit git-2
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="https://github.com/JuliaLang/julia/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT"
SLOT="0"

IUSE=""

S="${WORKDIR}"

# Avoid fragile duplication - see compile and install phases
JULIAMAKEARGS="QUIET_MAKE= USE_SYSTEM_LLVM=1 USE_SYSTEM_READLINE=1 USE_SYSTEM_PCRE=1 USE_SYSTEM_LIBM=1 \
		USE_SYSTEM_GMP=1 USE_SYSTEM_LIBUNWIND=1 USE_SYSTEM_PATCHELF=1 USE_SYSTEM_FFTW=1 USE_SYSTEM_ZLIB=1 \
		USE_SYSTEM_MPFR=1 USE_SYSTEM_SUITESPARSE=1  USE_SYSTEM_ARPACK=1 USE_SYSTEM_BLAS=1 USE_SYSTEM_LAPACK=1 \
		LLVM_CONFIG=/usr/bin/llvm-config"

# scons is a dep of double-conversion
DEPEND=">=sys-devel/llvm-3.3
	dev-lang/perl
	sys-libs/readline
	dev-libs/libpcre
	dev-util/scons
	dev-libs/gmp
	sys-libs/libunwind
	dev-util/patchelf
	sci-libs/fftw
	sys-libs/zlib
	dev-libs/mpfr
	sci-libs/suitesparse
	sci-libs/arpack
	virtual/lapack
	virtual/blas"

RDEPEND="sys-libs/readline"

src_compile() {
	emake $JULIAMAKEARGS || die
	# makefile weirdness - avoid compile in src_install
	emake $JULIAMAKEARGS debug || die
}

src_install() {
	# config goes to /usr/etc/ - should be fixed
	emake $JULIAMAKEARGS PREFIX="${D}/usr" install || die
}

# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fortran-2

DESCRIPTION="High quality system independent, open source libm"
HOMEPAGE="http://julialang.org/"

if [[ ${PV/9999} != ${PV} ]] ; then
    EGIT_REPO_URI="git://github.com/JuliaLang/openlibm.git"
    inherit git-3
    KEYWORDS="~amd64 ~x86"
else
    SRC_URI="https://github.com/JuliaLang/openlibm/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="amd64 x86"
fi

LICENSE="MIT freedist public-domain BSD"
SLOT="0"

IUSE="static-libs"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-respect-toolchain.patch
}

src_compile() {
	emake libopenlibm.so
	use static-libs && emake libopenlibm.a
}

src_test() {
	emake
}

src_install() {
	dolib.so libopenlibm.so*
	use static-libs && dolib.a libopenlibm.a
	doheader include/{cdefs,types}-compat.h src/openlibm.h
	dodoc README.md
}

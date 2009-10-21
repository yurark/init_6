# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="A low level virtual machine and compiler infrastructure"
HOMEPAGE="http://llvm.org/"
SRC_URI="http://llvm.org/releases/${PV}/${P}.tar.gz"

LICENSE="LLVM"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pic doc threads"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_configure() {
	econf \
		$(use_enable pic) \
		$(use_enable threads) \
		$(use_enable doc doxygen) \
		|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools git

DESCRIPTION="A library handling connection to a MPD server"
HOMEPAGE="http://sarine.nl/libmpd"
LICENSE="GPL-2"
EGIT_REPO_URI='git://repo.or.cz/libmpd.git'

KEYWORDS=""
SLOT="0"
IUSE="doc"
DEPEND=">=dev-libs/glib-2"
RDEPEND="doc? ( >=app-doc/doxygen-1.4.6 )"

src_unpack() {
	git_src_unpack
	AT_NOELIBTOOLIZE="yes" eautoreconf
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	use doc && make doc
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	use doc && dohtml -r doc/html/
}

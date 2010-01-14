# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit libtool

MY_PN="blueprint"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Blueprint GTK+2 Engine from Sun JDS"

HOMEPAGE="http://dlc.sun.com/osol/jds/downloads/extras/"
SRC_URI="http://dlc.sun.com/osol/jds/downloads/extras/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6"
DEPEND=">=x11-libs/gtk+-2.6"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	elibtoolize
}

src_compile() {
	econf --disable-dependency-tracking || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Memphis is a map-rendering application and a library for OpenStreetMap written in C using eXpat, Cairo and GLib."
HOMEPAGE="https://trac.openstreetmap.ch/trac/memphis/"
SRC_URI="mirror://wenner.ch/files/public/mirror/memphis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16
>=x11-libs/cairo-1.4
>=dev-libs/expat-2.0"

src_install() {
    emake DESTDIR="${D}" install || die "install failed"

    dodoc AUTHORS NEWS || die
}


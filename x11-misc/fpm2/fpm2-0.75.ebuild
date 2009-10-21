# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A GUI password manager utility with password generator"
HOMEPAGE="http://als.regnet.cz/fpm2/"
SRC_URI="http://als.regnet.cz/${PN}/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-util/pkgconfig"

RDEPEND=">=x11-libs/gtk+-2.10.14
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}

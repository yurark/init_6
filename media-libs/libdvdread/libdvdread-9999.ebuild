# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

WANT_AUTOCONF="2.5"

inherit eutils autotools multilib subversion

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://mplayerhq.hu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

ESVN_REPO_URI="svn://svn.mplayerhq.hu/dvdnav/trunk/libdvdread"
ESVN_PROJECT="libdvdread"

DEPEND="!<=media-libs/libdvdnav-4.1.2"
RDEPEND="$DEPEND"

src_compile() {
	./configure2 --prefix=/usr --libdir=/usr/$(get_libdir) \
		--shlibdir=/usr/$(get_libdir) --enable-static --enable-shared \
		--disable-strip --disable-opts $(use_enable debug) \
		--extra-cflags=${CFLAGS}  --extra-ldflags="${LDFLAGS}" \
		|| die "configure died"
	emake version.h || die "emake version.h died"
	emake || die "emake died"
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "emake install died"
	dodoc AUTHORS DEVELOPMENT-POLICY.txt ChangeLog TODO README
}

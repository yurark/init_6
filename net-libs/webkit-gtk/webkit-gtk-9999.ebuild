# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git autotools

MY_P=webkit-${PV}

DESCRIPTION="Open source web browser engine"
HOMEPAGE="http://www.webkitgtk.org/"

EGIT_REPO_URI="git://git.webkit.org/WebKit.git"
EGIT_PROJECT="webkit"
EGIT_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

LICENSE="LGPL-2 LGPL-2.1 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="3D-transforms coverage -debug -doc filters -geolocation +gstreamer -introspection jit mathml pango shared-workers sqlite svg soup websockets -wml xslt"

RDEPEND="
	>=x11-libs/gtk+-2.8
	>=dev-libs/icu-3.8.1-r1
	>=net-misc/curl-7.15
	media-libs/jpeg
	media-libs/libpng
	dev-libs/libxml2
	sqlite? ( >=dev-db/sqlite-3 )
	gstreamer? (
		>=media-libs/gst-plugins-base-0.10
		>=gnome-base/gnome-vfs-2.0
		)
	soup? ( >=net-libs/libsoup-2.23.1 )
	xslt? ( dev-libs/libxslt )
	pango? ( >=x11-libs/pango-1.12 )
	!pango? (
		media-libs/freetype:2
		media-libs/fontconfig )
	geolocation? ( x11-libs/geoclue )
"
DEPEND="${RDEPEND}
	dev-util/gperf
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.10 )
	virtual/perl-Text-Balanced"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	ewarn "This is a huge package. If you do not have at least 1.25GB of free"
	ewarn "disk space in ${PORTAGE_TMPDIR} and also in ${DISTDIR} then"
	ewarn "you should abort this installation now and free up some space."
}

src_configure() {
	# Add files missing from tarball...
	# https://bugs.webkit.org/show_bug.cgi?id=31102
	#for file in JSCore-1.0.gir JSCore-1.0.typelib; do
	#	cp "${FILESDIR}/$file" "${S}/WebKit/gtk/" || die "Error copying $file"
	#done


	# It doesn't compile on alpha without this in LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	local myconf

	myconf="$(use_enable 3D-transforms) \
		$(use_enable coverage) \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_enable filters) \
		$(use_enable geolocation) \
		$(use_enable gstreamer video) \
		$(use_enable introspection) \
		$(use_enable jit) \
		$(use_enable mathml) \
		$(use_enable shared-workers) \
		$(use_enable sqlite database) \
		$(use_enable sqlite dom-storage) \
		$(use_enable sqlite icon-database) \
		$(use_enable sqlite offline-web-applications) \
		$(use_enable svg) \
		$(use_enable svg filters) \
		$(use_enable websockets web-sockets) \
		$(use_enable wml) \
		$(use_enable xslt) \
"

	# USE-flag controlled font backend because upstream default is freetype
	# Remove USE-flag once font-backend becomes pango upstream
	if use pango; then
		ewarn "You have enabled the incomplete pango backend"
		ewarn "Please file any and all bugs *upstream*"
		myconf="${myconf} --with-font-backend=pango"
	else
		myconf="${myconf} --with-font-backend=freetype"
	fi

	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc WebKit/gtk/{NEWS,ChangeLog} || die "dodoc failed"
}


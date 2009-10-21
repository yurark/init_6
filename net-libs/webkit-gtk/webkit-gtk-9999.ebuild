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
IUSE="coverage debug -doc +gstreamer -geolocation pango ruby websockets"

RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	media-libs/jpeg
	media-libs/libpng
	x11-libs/cairo

	>=x11-libs/gtk+-2.10
	>=dev-libs/icu-3.8.1-r1
	>=net-libs/libsoup-2.27.4
	>=dev-db/sqlite-3
	>=app-text/enchant-0.22
	>=sys-devel/flex-2.5.33

	gnome-keyring? ( >=gnome-base/gnome-keyring-2.26.0 )
	gstreamer? (
		media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10 )
	pango? ( >=x11-libs/pango-1.12 )
	!pango? (
		media-libs/freetype:2
		media-libs/fontconfig )
	geolocation? ( x11-libs/geoclue )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/gperf
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.10 )"

S="${WORKDIR}/${MY_P}"

src_configure() {
	# It doesn't compile on alpha without this in LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	local myconf

	myconf="
		$(use_enable gstreamer video)
		$(use_enable debug)
		$(use_enable coverage)
		$(use_enable ruby)
		$(use_enable websockets web_sockets)
		--enable-filters
		--enable-geolocation
		--enable-3D-transforms
		--enable-shared-workers
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

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git autotools flag-o-matic eutils virtualx

MY_P=webkit-${PV}
DESCRIPTION="Open source web browser engine"
HOMEPAGE="http://www.webkitgtk.org/"

EGIT_REPO_URI="git://git.webkit.org/WebKit.git"
EGIT_PROJECT="webkit"
EGIT_BOOTSTRAP="NOCONFIGURE=1; ./autogen.sh"

LICENSE="LGPL-2 LGPL-2.1 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
#IUSE="coverage debug doc geoclue +gstreamer introspection pango"
IUSE="coverage debug doc +gstreamer introspection pango"

#	geoclue? ( gnome-extra/geoclue )

# use sqlite, svg by default
# dependency on >=x11-libs/gtk+-2.13 for gail
# XXX: Quartz patch does not apply
# >=x11-libs/gtk+-2.13[aqua=]
RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	media-libs/jpeg:0
	media-libs/libpng
	x11-libs/cairo
	>=x11-libs/gtk+-2.13
	>=dev-libs/glib-2.21.3
	>=dev-libs/icu-3.8.1-r1
	>=net-libs/libsoup-2.29.90
	>=dev-db/sqlite-3
	>=app-text/enchant-0.22
	>=x11-libs/pango-1.12

	gstreamer? (
		media-libs/gstreamer:0.10
		>=media-libs/gst-plugins-base-0.10.25:0.10 )
	introspection? (
		>=dev-libs/gobject-introspection-0.6.2
		!!dev-libs/gir-repository[webkit]
		dev-libs/gir-repository[libsoup] )
"

DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.33
	sys-devel/gettext
	dev-util/gperf
	dev-util/pkgconfig
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.10 )"

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

#		$(use_enable geoclue geolocation)
#		--enable-mathml \
	myconf="
		$(use_enable coverage)
		$(use_enable debug)

		$(use_enable gstreamer video)
		$(use_enable introspection)
		--enable-3D-transforms \
		--enable-indexeddb \
		--enable-xhtmlmp \
		--disable-geolocation \
		--disable-mathml \
		--disable-wml \
		--enable-web-sockets \
		--enable-blob-slice\
		--disable-fast-mobile-scrolling \
		--enable-file-reader \
		--enable-file-writer \
		--disable-gtk-doc
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

src_test() {
	unset DISPLAY
	# Tests will fail without it, bug 294691, bug 310695
	Xemake check || die "Test phase failed"
}

src_compile() {
	# Fix sandbox error with USE="introspection"
	addpredict "$(unset HOME; echo ~)/.local"
	emake || die "Compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc WebKit/gtk/{NEWS,ChangeLog} || die "dodoc failed"
}


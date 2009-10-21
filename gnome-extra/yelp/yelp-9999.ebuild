# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /gnome-extra/yelp/yelp-9999.ebuild,v 1.2 2009/06/20 10:54:43 eva Exp $

EAPI="1"

inherit eutils subversion

DESCRIPTION="Help browser for GNOME"
HOMEPAGE="http://www.gnome.org/"
ESVN_REPO_URI="http://svn.gnome.org/svn/yelp/branches/webkit/"
ESVN_PROJECT="yelp"
ESVN_STORE_DIR="${DISTDIR}/svn-src"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 -sparc ~x86"
IUSE="beagle debug"

RDEPEND=">=net-libs/webkit-gtk-1
	>=gnome-base/gconf-2
	>=app-text/gnome-doc-utils-0.11.1
	>=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.16
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=dev-libs/libxml2-2.6.5
	>=dev-libs/libxslt-1.1.4
	>=x11-libs/startup-notification-0.8
	>=dev-libs/dbus-glib-0.8
	beagle? ( >=dev-libs/libbeagle-0.3.0 )
	sys-libs/zlib
	>=app-arch/bzip2-1
	>=app-text/rarian-0.7
	>=app-text/scrollkeeper-9999"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9
	gnome-base/gnome-common"



src_compile() {

	local myconf

        myconf="$(use_enable debug)"

        if use beagle; then
                myconf="${myconf} --with-search=beagle"
        else
                myconf="${myconf} --with-search=auto"
        fi

	./autogen.sh ${myconf} || die

}

src_install()	{

emake DESTDIR="${D}" install || die "install failed"

}

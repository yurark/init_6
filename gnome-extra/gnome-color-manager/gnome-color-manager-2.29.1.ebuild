# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="Gnome Color Manager"
HOMEPAGE="http://projects.gnome.org/gnome-color-manager/"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.19.7
	>=x11-libs/gtk+-2.16
	>=gnome-base/gconf-2
        "

DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	gnome-base/gnome-common
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="README NEWS MAINTAINERS ChangeLog AUTHORS"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-hardware-detection
		"
}

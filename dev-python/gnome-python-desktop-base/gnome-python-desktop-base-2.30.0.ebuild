# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

GCONF_DEBUG="no"

inherit eutils gnome2 versionator

# This ebuild does nothing -- we just want to get the pkgconfig file installed
MY_PN="gnome-python-desktop"
PVP="$(get_version_component_range 1-2)"

DESCRIPTION="Provides python the base files for the Gnome Python Desktop bindings"
HOMEPAGE="http://pygtk.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP}/${MY_PN}-${PV}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"

# From the gnome-python-desktop eclass
RDEPEND="virtual/python
	>=dev-python/pygtk-2.17.0
	>=dev-libs/glib-2.24.0
	>=x11-libs/gtk+-2.20.0
	!<dev-python/gnome-python-extras-${PV}
	!<dev-python/gnome-python-desktop-${PV}"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7"

RESTRICT="test"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	G2CONF="${G2CONF} --disable-allbindings"
}

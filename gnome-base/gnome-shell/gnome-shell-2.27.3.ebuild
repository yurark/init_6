# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit gnome2

DESCRIPTION="The GNOME Shell for GNOME 3.0"
HOMEPAGE="http://live.gnome.org/GnomeShell"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/gnome-desktop-2.26.0
	>=dev-libs/glib-2.18.0
	>=x11-libs/gtk+-2.15.1
	>=x11-wm/mutter-2.27.3
	>=dev-libs/gjs-0.4
	>=dev-libs/gobject-introspection-0.6.5
	>=dev-libs/gir-repository-0.6.4[pango]
	>=gnome-base/gconf-2.6.1
	>=gnome-base/gnome-menus-2.11.1
	gnome-base/librsvg
	>=dev-libs/dbus-glib-0.71
	>=sys-apps/dbus-1.1.2
	x11-libs/libXau
	x11-apps/mesa-progs
	>=x11-libs/startup-notification-0.10"
DEPEND="${RDEPEND}
	>=dev-lang/python-2.5
	gnome-base/gnome-common
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40
	~app-text/docbook-xml-dtd-4.1.2
	>=dev-util/gtk-doc-am-1"

DOCS="AUTHORS README"

pkg_postinst() {

	elog " Start with 'gnome-shell --replace' "
	elog " or add gnome-shell.desktop to ~/.config/autostart/ "

	gnome2_pkg_postinst

}

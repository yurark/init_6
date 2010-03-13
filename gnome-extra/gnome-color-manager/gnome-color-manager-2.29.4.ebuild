# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools gnome2

DESCRIPTION="Color management framework for the GNOME desktop"
HOMEPAGE="http://projects.gnome.org/gnome-color-manager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.14
	>=x11-libs/gtk+-2.14
	>=gnome-base/gnome-desktop-2.14
	>=gnome-base/gconf-2.0
	>=dev-libs/libunique-1.0
	>=x11-libs/vte-0.22.2
	>=sys-fs/udev-145[extras]
	>=dev-libs/dbus-glib-0.73
	>=x11-apps/xrandr-1.2
	x11-libs/libXxf86vm
	x11-libs/libX11"

DEPEND="${RDEPEND}"

DOCS="AUTHORS MAINTAINERS NEWS README"


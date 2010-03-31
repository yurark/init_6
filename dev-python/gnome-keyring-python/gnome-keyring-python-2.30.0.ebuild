# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="gnomekeyring"

inherit gnome-python-common

DESCRIPTION="Python bindings for the interfacing with the GNOME keyring"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=gnome-base/gnome-keyring-${PV}
	!<dev-python/gnome-python-desktop-${PV}"
DEPEND="${RDEPEND}"

EXAMPLES="examples/keyring*"

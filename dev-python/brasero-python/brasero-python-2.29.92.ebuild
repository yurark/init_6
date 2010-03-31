# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="braseroburn braseromedia"

inherit gnome-python-common

DESCRIPTION="Python bindings for Brasero CD/DVD burning"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=app-cdr/brasero-${PV}
	!<dev-python/gnome-python-desktop-${PV}"
DEPEND="${RDEPEND}"

EXAMPLES="examples/braseroburn/*
	examples/braseromedia/*"

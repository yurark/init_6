# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git

DESCRIPTION="Oxygen cursors set."
HOMEPAGE="http://gitweb.freedesktop.org/?p=users/ruphy/oxy-cursors.git;a=summary"

EGIT_REPO_URI="git://people.freedesktop.org/~ruphy/oxy-cursors"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="media-gfx/inkscape
	x11-apps/xcursorgen"

COLORS="blue yellow brown grey green violet viorange red purple navy sea_blue emerald hot_orange white black red-argentina"

src_unpack() {
	git_src_unpack
}

src_compile() {
	emake themes || die "Unable to make the themes"
}

src_install() {
	insinto /usr/share/cursors/xorg-x11
	doins -r cursors/oxy-*
}

pkg_postinst() {
	elog "To use this set of cursors, edit or create the file ~/.Xdefaults"
	elog "and add the following line:"
	elog "Xcursor.theme: oxy-\$color"
	elog ""
	elog "where \$color can be one of: ${COLORS}"
	elog ""
	elog "You can change the size by adding a line like:"
	elog "Xcursor.size: 48"
	elog ""
	elog "Also, to globally use this set of mouse cursors edit the file:"
	elog "   /usr/share/cursors/xorg-x11/default/index.theme"
	elog "and change the line:"
	elog "    Inherits=[current setting]"
	elog "to"
	elog "    Inherits=oxy-\$color"
	elog ""
	elog "Note this will be overruled by a user's ~/.Xdefaults file."
	elog ""
	ewarn "If you experience flickering, try setting the following line in"
	ewarn ""
	ewarn "the Device section of your xorg.conf file:"
	ewarn "    Option  \"HWCursor\"  \"false\""
}

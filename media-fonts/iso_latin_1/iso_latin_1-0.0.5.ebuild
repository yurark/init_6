# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="iso-latin-1"

if [[ ${PV} = 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/init6/${MY_PN}.git"
else
	SRC_URI="https://github.com/init6/${MY_PN}/archive/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
fi

DESCRIPTION="iso-latin-1 based linux console font"
HOMEPAGE="https://github.com/init6/iso-latin-1"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
# Only installs fonts.
RESTRICT="mirror strip binchecks"

DEPEND="media-gfx/psftools"

FONTDIR="/usr/share/consolefonts"

S="${WORKDIR}/iso-latin-1-${PV}"

src_compile() {
	emake || die "Build failed!"
}

src_install() {
	cd "${S}/${MY_PN}-8x16-${PV}"
	insinto ${FONTDIR}
	doins "${MY_PN}-8x16.psfu.gz"
}

pkg_postinst() {
	font_pkg_postinst

	echo
	elog "To use iso-latin-1 instead of the default console font:"
	elog "   set FONT=iso-latin-1-8x16 in /etc/vconsole.conf"
	echo
}

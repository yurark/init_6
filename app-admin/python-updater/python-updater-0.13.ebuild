# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
fi


DESCRIPTION="Script used to reinstall Python packages after changing of active Python versions"
HOMEPAGE="http://www.gentoo.org/proj/en/Python/"
if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/python-updater.git"
else
	SRC_URI="http://dev.gentoo.org/~floppym/dist/${P}.tar.bz2"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

if [[ ${PV} == 9999 ]]; then
	DEPEND="
		sys-libs/core-functions
		sys-apps/help2man
	"
fi
RDEPEND="
	sys-libs/core-functions
	|| ( >=sys-apps/portage-2.1.6 >=sys-apps/paludis-0.56.0 sys-apps/pkgcore )
"

src_compile() {
	[[ ${PV} == 9999 ]] && emake python-updater
	default
}

src_install() {
	dosbin ${PN}
	doman ${PN}.1
	dodoc AUTHORS

	sed -i -e \
	"s:. \"\"/lib/gentoo/functions.sh:. \"\"/usr/$(get_libdir)/misc/core-functions.sh:g" \
	"${D}/usr/sbin/${PN}"
}

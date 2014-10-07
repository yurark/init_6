# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/init6/${PN}.git"
else
	SRC_URI="https://github.com/init6/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

DESCRIPTION="Portage's intelligent bashrc."
HOMEPAGE="https://github.com/init6/ibashrc"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="sys-apps/portage
	sys-devel/ipatch::init6"
RDEPEND="${DEPEND}"

src_install() {
	test -d "${D}/etc/portage" >/dev/null 2>&1 && cd "${D}/etc/portage" || mkdir -p "${D}/etc/portage"; cd "${D}/etc/portage"
	cp "${S}/bashrc" "${D}/etc/portage/ibashrc" || die
}

pkg_postinst() {
	echo
	einfo
	einfo "In order to enable ibashrc go to /etc/portage and do:"
	einfo "ln -s ibashrc bashrc"
	einfo
	echo
}

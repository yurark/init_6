# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == "9999" ]] ; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/init6/${PN}.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/init6/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

DESCRIPTION="Intelligent patch wrapper."
HOMEPAGE="https://github.com/init6/ipatch"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="|| ( sys-libs/core-functions::init6 sys-apps/gentoo-functions )
	sys-apps/coreutils
	dev-perl/File-MimeInfo
	sys-devel/patch
	app-arch/bzip2
	app-arch/gzip
	app-arch/lrzip
	app-arch/unzip
	app-arch/xz-utils"
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

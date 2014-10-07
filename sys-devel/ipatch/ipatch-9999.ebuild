# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/init6/${PN}.git"
else
	SRC_URI="https://github.com/init6/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

DESCRIPTION="Intelligent patch wrapper."
HOMEPAGE="https://github.com/init6/ipatch"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="sys-apps/coreutils
	sys-apps/file
	sys-devel/patch
	app-arch/bzip2
	app-arch/gzip
	app-arch/lrzip
	app-arch/unzip
	app-arch/xz-utils"
RDEPEND="${DEPEND}"

src_install() {
	dobin ipatch || die "dobin failed"
	insinto /usr/share/man/man1
	doins ipatch.1 || die "doins failed"
}

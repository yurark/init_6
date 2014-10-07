# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

if [[ ${PV} = 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/init6/${PN}.git"
else
	SRC_URI="https://github.com/init6/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
fi

inherit eutils multilib

DESCRIPTION="base functions required by all gentoo systems"
HOMEPAGE="https://github.com/init6/core-functions"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
RESTRICT="mirror"

DEPEND="!sys-apps/gentoo-functions"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/$(get_libdir)/misc
	doins "${PN}.sh"
}

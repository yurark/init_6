# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bash-completion-r1 eutils

DESCRIPTION="A Portage analysis toolkit"
HOMEPAGE="https://github.com/init6/udept/wiki"
SRC_URI="https://github.com/init6/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~mips ~sparc ~x86"
IUSE="bash-completion"

DEPEND="app-shells/bash
	sys-apps/portage"
RDEPEND="${DEPEND}"

BASH_COMPLETION_NAME="dep"

src_configure() {
	econf $(use_enable bash-completion) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog*
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib

DESCRIPTION="${PN} provide alternative for /etc/init.d/functions.sh so that openrc is not required"
HOMEPAGE="https://github.com/init6/core-functions"
SRC_URI="https://github.com/init6/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""
RESTRICT="mirror"

RDEPEND="app-shells/bash"

src_install() {
	insinto /usr/$(get_libdir)/misc
	doins "${PN}.sh"
}

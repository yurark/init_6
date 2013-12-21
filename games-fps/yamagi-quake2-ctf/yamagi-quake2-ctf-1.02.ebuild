# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="Three Wave Caputure The Flag."
HOMEPAGE="http://www.yamagi.org/quake2/ https://github.com/yquake2/yquake2"
SRC_URI="http://deponie.yamagi.org/quake2/quake2-ctf-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"

DEPEND="games-fps/yamagi-quake2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/quake2-ctf-${PV}

src_compile() {
	emake
}

src_install() {
	# Install shared libraries and config file.
	insinto ${GAMES_DATADIR}/yamagi-quake2/ctf
	doins release/game.so

	# Install wrapper scripts for binaries
	dogamesbin ${FILESDIR}/yq2-ctf

	# Install documentation
	dodoc CHANGELOG LICENSE README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog
	elog "For convenience, you may use the wrapper scripts \"yq2\" and \"yq2-server\""
	elog "to run the game or the server, respectively."
	elog
}

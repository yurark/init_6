# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Quake II Mission Pack 1 - The Reckoning."
HOMEPAGE="http://www.yamagi.org/quake2/ https://github.com/yquake2/yquake2"
SRC_URI="http://deponie.yamagi.org/quake2/quake2-xatrix-${PV}.tar.xz"

LICENSE="id-Software-SDK-license"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"

RESTRICT="mirror"

# DEPEND="games-fps/yamagi-quake2"
RDEPEND="${DEPEND}
	games-fps/quake2-reckoning-data"

S=${WORKDIR}/quake2-xatrix-${PV}

src_compile() {
	emake
}

src_install() {
	# Install shared libraries and config file.
	insinto ${GAMES_DATADIR}/yamagi-quake2/xatrix
	doins release/game.so

	# Install wrapper scripts for binaries
	dogamesbin ${FILESDIR}/yq2-xatrix

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

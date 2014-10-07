# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $


DESCRIPTION="Open Source Jedi Academy and Jedi Outcast games engine"
HOMEPAGE="https://github.com/JACoders/OpenJK"

if [[ ${PV/9999} != ${PV} ]] ; then
	SRC_URI=""
	EGIT_REPO_URI="git://github.com/JACoders/OpenJK.git"
	inherit git-r3
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="https://github.com/JACoders/OpenJK/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL2"
SLOT="0"
IUSE=""

DEPEND="media-libs/glu
	media-libs/libpng
	media-libs/libsdl2
	media-libs/openal
	sys-libs/zlib
	virtual/jpeg
	virtual/opengl"

RDEPEND="${DEPEND}"

dir=${GAMES_PREFIX_OPT}/${PN}

src_configure() {
	cmake -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=${dir} \
#	-DCMAKE_CXX_FLAGS=-m32 \
#	-DCMAKE_C_FLAGS=-m32 \
#	-DCMAKE_SHARED_LINKER_FLAGS=-m32 \
#	-DCMAKE_SIZEOF_VOID_P=4
}

src_compile() {
	emake VERBOSE=1 all
}

src_install() {
	emake DESTDIR="${D}" install

	exeinto "${dir}"

	if use x86; then
		local ext="i386"
	fi

	if use amd64; then
		local ext="x86_64"
	fi

	doexe openjk.${ext} || die
	doexe openjk_sp.${ext} || die
	doexe openjkded.${ext} || die
	dosym "${dir}/openjk.${ext}" "${GAMES_BINDIR}/openjk" || die
	dosym "${dir}/openjk_sp.${ext}" "${GAMES_BINDIR}/openjk_sp" || die
	dosym "${dir}/openjkded.${ext}" "${GAMES_BINDIR}/openjkded" || die

	newicon "${FILESDIR}"/openjkmp.png openjkmp.png || die "newicon failed"
	make_desktop_entry ${PN} "OpenJK Multi Player" /usr/share/pixmaps/openjkmp.png Game
	newicon "${FILESDIR}"/openjksp.png openjksp.png || die "newicon failed"
	make_desktop_entry ${PN}_sp "OpenJK Single Player" /usr/share/pixmaps/openjksp.png Game

	prepgamesdirs

#	dodoc "${dir}"/readme || die
}

pkg_postinst() {
	games_pkg_postinst

#	if ! use cdinstall; then
		elog "You need to copy GameData/base/*.{pk3,cfg} from either your installation media or your hard drive to"
		elog "~/.local/share/openjk/base before running the game,"
		elog "or 'emerge games-fps/${PN}-data' to install from CD." # <- TODO make it
		echo
#	fi

	echo
	elog "To play the game, run:"
	elog " ${PN} or ${PN}_sp"
	echo
	echo
	elog "To start the game server, run:"
	elog " ${PN}ded"
	echo
}

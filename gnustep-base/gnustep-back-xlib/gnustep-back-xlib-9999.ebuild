# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-base subversion

S=${WORKDIR}/gnustep-back-${PV}

DESCRIPTION="Default X11 back-end component for the GNUstep GUI Library"
HOMEPAGE="http://www.gnustep.org"
SRC_URI=""

ESVN_REPO_URI="http://svn.gna.org/svn/gnustep/libs/back/trunk/"
ESVN_PROJECT="gnustep-back"

KEYWORDS="amd64 ppc ~sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="LGPL-2.1"

IUSE="opengl xim"
DEPEND="${GNUSTEP_CORE_DEPEND}
	~gnustep-base/gnustep-gui-${PV}
	opengl? ( virtual/opengl virtual/glu )
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXft
	x11-libs/libXrender
	dev-libs/expat
	media-libs/fontconfig
	>=media-libs/freetype-2.1.9
	!gnustep-base/gnustep-back-art
	!gnustep-base/gnustep-back-cairo"
RDEPEND="${DEPEND}"

src_compile() {
	egnustep_env

	use opengl && myconf="--enable-glx"
	myconf="$myconf `use_enable xim`"
	myconf="$myconf --enable-server=x11"
	myconf="$myconf --enable-graphics=xlib"
	econf $myconf || die "configure failed"

	egnustep_make
}

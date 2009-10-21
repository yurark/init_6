# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tango-icon-theme/tango-icon-theme-0.8.1.ebuild,v 1.8 2008/03/21 06:18:04 drac Exp $

inherit eutils gnome2-utils

MY_PV=${PV/rc/RC}
MY_PV1=${PV/rc?/RC}
DESCRIPTION="Mac OS X theme for Gnome enviroment"
HOMEPAGE="http://sourceforge.net/projects/mac4lin/"
SRC_URI="mirror://sourceforge/mac4lin/Mac4Lin_v${MY_PV}.tar.gz
		 mirror://sourceforge/mac4lin/Leopard_Wallpapers.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="awn grub emerald"

RESTRICT="binchecks strip"

RDEPEND=">=x11-misc/icon-naming-utils-0.8.2
	media-gfx/imagemagick
	>=gnome-base/librsvg-2.12.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_unpack() {
	unpack  ${A}
	
	#Unpacking GTK-Themes
	cd ${WORKDIR}/Mac4Lin_v${MY_PV}/GTK
	for gtk_tarball in *.tar.gz ; do
		tar -xf "${gtk_tarball}"
	done
	
	#Unpacking cursor themes
	cd ${WORKDIR}/Mac4Lin_v${MY_PV}/Cursors
	tar -xf "Mac4Lin_Cursors_v${MY_PV1}.tar.gz"

	#Unpacking icon themes
	cd ${WORKDIR}/Mac4Lin_v${MY_PV}/Icons
	tar -xf "Mac4Lin_Icons_v${MY_PV1}.tar.gz"       
}
	
src_install() {
	dodir /usr/share/pixmaps/backgrounds/osx
	insinto /usr/share/pixmaps/backgrounds/osx
	doins ${WORKDIR}/Leopard_Wallpapers/*
	doins ${WORKDIR}/Mac4Lin_v${MY_PV}/Wallpapers/*
	
	dodir /usr/share/themes
	mv ${WORKDIR}/Mac4Lin_v${MY_PV}/GTK/Mac4Lin_GTK_Graphite_v${MY_PV1}	"${D}"/usr/share/themes
	mv ${WORKDIR}/Mac4Lin_v${MY_PV}/GTK/Mac4Lin_GTK_v${MY_PV1}	"${D}"/usr/share/themes
	mv ${WORKDIR}/Mac4Lin_v${MY_PV}/GTK/Mac4Lin_MacMenu_Graphite_v${MY_PV1}	"${D}"/usr/share/themes
	mv ${WORKDIR}/Mac4Lin_v${MY_PV}/GTK/Mac4Lin_MacMenu_v${MY_PV1}	"${D}"/usr/share/themes
	
	dodir /usr/share/icons
	mv ${WORKDIR}/Mac4Lin_v${MY_PV}/Icons/Mac4Lin_Icons_v${MY_PV1} "${D}"/usr/share/icons
	mv ${WORKDIR}/Mac4Lin_v${MY_PV}/Cursors/Mac4Lin_Cursors_v${MY_PV1} "${D}"/usr/share/icons
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}


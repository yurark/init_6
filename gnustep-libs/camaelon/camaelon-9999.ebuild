# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-2 subversion

S="${WORKDIR}/Etoile-${PV}/Bundles/${PN/c/C}"

DESCRIPTION="Camaelon allows you to load theme bundles for GNUstep."

HOMEPAGE="http://etoileos.com"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/trunk/Etoile"
ESVN_PROJECT="etoile"

KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND=">=gnustep-base/gnustep-gui-0.16.0"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}

	cd "${WORKDIR}/Etoile-${PV}"
	sed -i -e "s/-Werror//" etoile.make || die "sed failed"
}

src_install() {
	gnustep-base_src_install

	#Link default theme
	dodir ${GNUSTEP_SYSTEM_LIBRARY}/Themes
	dosym ${GNUSTEP_SYSTEM_LIBRARY}/Bundles/Camaelon.themeEngine/Resources/Nesedah.theme ${GNUSTEP_SYSTEM_LIBRARY}/Themes/
}

gnustep_config_script() {
	echo "gnustep_append_default NSGlobalDomain GSAppKitUserBundles \"${GNUSTEP_SYSTEM_LIBRARY}/Bundles/Camaelon.themeEngine\""
	echo "gnustep_set_default Camaelon Theme Nesedah"
}

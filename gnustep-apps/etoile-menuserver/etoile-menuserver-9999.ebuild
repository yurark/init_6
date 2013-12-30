# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit gnustep-2 subversion 

S="${WORKDIR}/Etoile-${PV}/Services/Private/MenuServer"

DESCRIPTION="Menubar for the Etoile environment"
HOMEPAGE="http://etoileos.com"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/trunk/Etoile"
ESVN_PROJECT="etoile"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

DEPEND=">=gnustep-base/gnustep-gui-0.16.0
	>=gnustep-libs/systemconfig-${PV}
	>=gnustep-libs/xwindowserverkit-${PV}"
RDEPEND="${DEPEND}"
# Not available in current stable
#	gnustep-libs/service-menulet
#	gnustep-libs/volumecontrol-menulet"

src_prepare() {
	cd "${WORKDIR}/Etoile-${PV}"
	sed -i -e "s/-Werror//" etoile.make || die "sed failed"
}

# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-2 subversion

S="${WORKDIR}/Etoile-${PV}/Services/Private/Corner"

DESCRIPTION="A simple 'hot-corners' implementation"
HOMEPAGE="http://etoileos.com"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/trunk/Etoile"
ESVN_PROJECT="etoile"

LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

DEPEND=">=gnustep-base/gnustep-gui-0.16.0
	>=gnustep-libs/scriptkit-${PV}
	>=gnustep-libs/smalltalkkit-${PV}"
RDEPEND="${DEPEND}"

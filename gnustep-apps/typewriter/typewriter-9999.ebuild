# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-2 subversion

S="${WORKDIR}/Etoile-${PV}/Services/User/${PN/t/T}"

DESCRIPTION="Etoilé general text editor for plain and rich format text"

HOMEPAGE="http://www.etoile-project.org"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/stable"
ESVN_PROJECT="etoile"

LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

DEPEND=">=gnustep-libs/ogrekit-${PV}
	>=gnustep-libs/scriptkit-${PV}"
RDEPEND="${DEPEND}"

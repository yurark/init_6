# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-2 subversion

S="${WORKDIR}/Etoile-${PV}/Frameworks/LuceneKit"

DESCRIPTION="GNUstep port of Lucene"
HOMEPAGE="http://etoileos.com"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/trunk/Etoile"
ESVN_PROJECT="etoile"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

DEPEND=">=gnustep-base/gnustep-gui-0.16.0
	>=gnustep-libs/ogrekit-${PV}"
RDEPEND="${DEPEND}"

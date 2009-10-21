# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-2 subversion

S="${WORKDIR}/Etoile-${PV}/Bundles/EtoileWildMenus"

DESCRIPTION="provides horizontal menu display to Etoile applications"
HOMEPAGE="http://www.etoile-project.org"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/stable"
ESVN_PROJECT="etoile"

LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

gnustep_config_script() {
	echo "gnustep_append_default NSGlobalDomain GSAppKitUserBundles \"${GNUSTEP_SYSTEM_LIBRARY}/Bundles/EtoileMenus.bundle\""
}

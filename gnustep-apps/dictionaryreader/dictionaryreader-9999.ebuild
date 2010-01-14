# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-2 subversion

S="${WORKDIR}/Etoile-${PV}/Services/User/DictionaryReader"

DESCRIPTION="Dictionary application that queries Dict servers"
HOMEPAGE="http://www.etoile-project.org"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/stable"
ESVN_PROJECT="etoile"

LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

DEPEND=">=gnustep-libs/etoile-ui-${PV}"
RDEPEND="${DEPEND}"

src_compile() {
	egnustep_env
	egnustep_make etoile=yes || die "compilation failed"
}

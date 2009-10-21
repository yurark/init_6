# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-2 subversion

S="${WORKDIR}/Etoile-${PV}/Languages/LanguageKit"

DESCRIPTION="a compiler kit built on top of LLVM for creating dynamic language implementations using an Objective-C runtime for the object model"
HOMEPAGE="http://www.etoile-project.org"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/stable"
ESVN_PROJECT="etoile"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=gnustep-base/gnustep-gui-0.16.0
	>=sys-devel/llvm-2.4"
RDEPEND="${DEPEND}"

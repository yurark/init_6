# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnustep-2 subversion

S="${WORKDIR}/Etoile-${PV}/Frameworks/MediaKit"

DESCRIPTION="a common backend engine to play multimedia stream"
HOMEPAGE="http://etoileos.com"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/etoile/trunk/Etoile"
ESVN_PROJECT="etoile"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

DEPEND=">=gnustep-base/gnustep-gui-0.16.0
	>=gnustep-libs/etoile-foundation-${PV}
	>=gnustep-libs/systemconfig-${PV}
	>=media-video/ffmpeg-0.4.9_p20080326"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/Etoile-${PV}"

	cd "${S}"
	sed -i -e "s#avcodec.h#libavcodec/avcodec.h#" \
		-e "s#avformat.h#libavformat/avformat.h#" \
		MKMediaFile.h || die "ffmpeg sed failed"
}

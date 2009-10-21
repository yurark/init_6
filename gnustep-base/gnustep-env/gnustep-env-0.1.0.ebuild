# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="This is a convience package that installs all base GNUstep libraries, convenience scripts, and environment settings for use on Gentoo."

# These are support files for GNUstep on Gentoo, so setting
#   homepage thusly
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

KEYWORDS="~x86"
SLOT="0"

LICENSE="GPL-2"
IUSE=""

DEPEND="gnustep-base/gnustep-make
	gnustep-base/gnustep-base
	gnustep-base/gnustep-gui
	virtual/gnustep-back"
RDEPEND="gnustep-base/gnustep-make
	gnustep-base/gnustep-base
	gnustep-base/gnustep-gui
	virtual/gnustep-back
	sys-apps/baselayout"

src_install() {
	exeinto /etc/init.d
	newexe ${FILESDIR}/gnustep.runscript gnustep
	insinto /etc/env.d
	newins ${FILESDIR}/gnustep.env 99gnustep
}

pkg_postinst() {
	einfo "Make sure to check: "
	einfo " /usr/GNUstep/System/Tools/Gentoo"
	einfo "for helper shell scripts to ease your GNUstep configuration."
	einfo "RUN THEM AS THE USER YOU WILL BE RUNNING GNUstep AS!"
}


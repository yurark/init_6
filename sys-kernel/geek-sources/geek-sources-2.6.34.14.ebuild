# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

BFQ_VER="2.6.34"
REISER4_VER="2.6.34"
REISER4_SRC="mirror://sourceforge/project/reiser4/reiser4-for-linux-2.6/reiser4-for-${REISER4_VER}.patch.gz"
SUSE_VER="7a744773dd7c2539b7757435d0108cb701dd0165" # rpm-2.6.34-12
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.40"

SUPPORTED_USES="bfq -build reiser4 suse symlink"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

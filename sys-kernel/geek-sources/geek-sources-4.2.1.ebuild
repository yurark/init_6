# Copyright 2009-2015 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="0"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

#AUFS_VER="${KMV}"
BFQ_VER="${KMV}.0-v7r9"
BLD_VER="${KMV}"
#CK_VER="${KMV}-ck1"
#BFS_VER="462"
ICE_VER="for-linux-${KMV}.1-2015-09-23"
FEDORA_VER="f23"
#GRSEC_VER="3.1-${KSV}-201504190814" # 19/04/15 08:14
#GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
LQX_VER="${KMV}.1-1"
#MAGEIA_VER="releases/${KSV}/1.mga5"
#PAX_VER="${KSV}-test2"
#PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="${KMV}.1"
#RT_VER="${KSV}-rt17"
#SUSE_VER="next"
UKSM_VER="0.1.2.4"
UKSM_NAME="uksm-${UKSM_VER}-beta-for-linux-v4.0"

SUPPORTED_USES="bfq bld brand -build -deblob fedora gentoo ice lqx reiser4 symlink uksm"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

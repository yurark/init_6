# Copyright 2009-2015 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="0"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="${KMV}"
BFQ_VER="${KMV}.0-v7r8"
BLD_VER="${KMV}"
# 2015-07-01 :
# Currently no 4.1 support.
#CK_VER="${KMV}-ck1"
#BFS_VER="462"
ICE_VER="for-linux-head-${KMV}.0-rc8-2015-06-17"
FEDORA_VER="f22"
#GRSEC_VER="3.1-${KSV}-201504190814" # 19/04/15 08:14
#GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
LQX_VER="${KSV}-1"
MAGEIA_VER="releases/${KSV}/1.mga5"
PAX_VER="${KSV}-test2"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
# reiser4 has a new subdirectory at:
# https://sourceforge.net/projects/reiser4/files/reiser4-for-linux-4.x/
# 2015-07-01 :
# It only supports up to 4.0.4, yet.
#REISER4_VER="${KMV}.5"
# RT_VER="${KSV}-rt17"
SUSE_VER="stable"
UKSM_VER="beta"
UKSM_NAME="uksm-0.1.2.4-${UKSM_VER}-for-linux-v4.0"

SUPPORTED_USES="aufs bfq bld brand -build -deblob fedora ice gentoo optimize pax pf suse symlink uksm zen"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

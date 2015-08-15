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
CK_VER="${KMV}-ck2"
BFS_VER="464"
ICE_VER="for-linux-${KMV}.3-2015-07-23"
FEDORA_VER="f22"
GRSEC_VER="3.1-${KSV}-201507261932" # 26/07/15 19:32
GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
LQX_VER="${KSV}-1"
MAGEIA_VER="releases/${KSV}/1.mga5"
PAX_VER="${KMV}.3-test10"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="${KMV}.4"
# RT_VER="${KSV}-rt17"
SUSE_VER="stable"
UKSM_VER="beta"
UKSM_NAME="uksm-0.1.2.4-${UKSM_VER}-for-linux-v4.0"

SUPPORTED_USES="aufs bfs bfq bld brand -build ck -deblob fedora ice gentoo optimize pax pf reiser4 suse symlink uksm zen"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

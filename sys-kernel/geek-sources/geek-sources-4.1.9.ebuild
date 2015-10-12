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
ICE_VER="for-linux-${KMV}.9-2015-10-02"
FEDORA_VER="f22"
GRSEC_VER="3.1-${KMV}.7-201509201149" # 20/09/15 11:49
GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
LQX_VER="${KMV}.10-2"
MAGEIA_VER="releases/${KMV}.8/1.mga6"
PAX_VER="${KMV}.9-test21"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="${KMV}.7"
RT_VER="${KMV}.7-rt8"
SUSE_VER="stable"
UKSM_VER="beta"
UKSM_NAME="uksm-0.1.2.4-${UKSM_VER}-for-linux-v4.0"

SUPPORTED_USES="aufs bfs bfq bld brand -build ck -deblob fedora gentoo grsec ice lqx optimize pax pf reiser4 suse symlink uksm zen"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

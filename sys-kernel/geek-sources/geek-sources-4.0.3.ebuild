# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="0"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="${KMV}"
BFQ_VER="${KMV}.0-v7r7"
#BLD_VER="${KMV}"
BFS_VER="462"
CK_VER="${KMV}-ck1"
#ICE_VER="for-linux-head-${KMV}.0-2015-02-10"
FEDORA_VER="master"
GRSEC_VER="3.1-${KMV}.2-201505072057" # 07/05/15 20:57
GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
LQX_VER="${KMV}.2-2"
MAGEIA_VER="releases/${KSV}/1.mga5"
PAX_VER="${KMV}.2-test10"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
# REISER4_VER="3.14.1"
# RT_VER="${KSV}-rt17"
SUSE_VER="stable"
UKSM_VER="beta"
UKSM_NAME="uksm-0.1.2.4-${UKSM_VER}-for-linux-v${KMV}"

SUPPORTED_USES="aufs bfq bfs brand -build ck -deblob fedora gentoo grsec lqx mageia pax pf suse symlink uksm zen"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="0"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="3.18.1+"
BFQ_VER="${KMV}.0-v7r7"
BLD_VER="${KMV}"
CK_VER="${KMV}-ck1"
BFS_VER="460"
ICE_VER="for-linux-${KMV}.7-2015-02-14"
FEDORA_VER="f21"
#GRSEC_VER="3.1-${KSV}-201502271843" # 27/02/15 18:43
#GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
#LQX_VER="${KMV}.9-1"
MAGEIA_VER="releases/${KMV}.3/2.mga5"
PAX_VER="${KMV}.9-test15"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="${KMV}.6"
# RT_VER="${KSV}-rt17"
SUSE_VER="stable"
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}"

SUPPORTED_USES="aufs bfq bfs bld brand -build ck -deblob ice fedora gentoo mageia optimize pax reiser4 suse symlink uksm zen"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

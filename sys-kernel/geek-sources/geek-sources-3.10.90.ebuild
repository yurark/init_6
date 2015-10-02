# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="${KMV}"
BFQ_VER="${KMV}.8+-v7r8"
BLD_VER="${KMV}.0"
CK_VER="${KMV}-ck1"
BFS_VER="440"
# HARDENED_VER="3.10.11"
ICE_VER="for-linux-${KMV}.90-2015-10-02"
# LQX_VER="3.10.22-1"
MAGEIA_VER="releases/${KMV}.10/3.mga4"
PAX_VER="${KMV}.12-test26"
REISER4_VER="${KMV}"
# RT_VER="3.10.44-rt46-rc1"
RSBAC_VER="1.4.9"
RSBAC_NAME="patch-linux-${KMV}.64-rsbac-${RSBAC_VER}.diff.xz"
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.46"

SUPPORTED_USES="aufs bfq bfs bld brand -build cjktty ck deblob fedora gentoo ice mageia openwrt pax pf reiser4 rsbac suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="amd64 x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

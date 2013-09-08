# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

#AUFS_VER="$KMV"
BFQ_VER="3.9.0-v6r2"
#BLD_VER="${KMV}-rc4"
CJKTTY_VER="3.9"
CK_VER="${KMV}-ck1"
#FEDORA_VER="f19"
#GENTOO_VER="$KMV"
GRSEC_VER="${PV}"
#ICE_VER="$KMV"
#LQX_VER="3.9.11-1"
#LQX_SRC="http://liquorix.net/sources/${LQX_VER}.patch.gz"
MAGEIA_VER="releases/3.9.8/1.mga4"
OPTIMIZATION_VER="2"
PAX_VER="3.9.9-test14"
#PF_VER="3.9.5-pf"
REISER4_VER="3.9.2"
#SUSE_VER="stable"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.1"
ZEN_VER="3.9"

SUPPORTED_USES="aufs bfq brand -build cjktty ck fedora gentoo grsec ice mageia optimization pax pf reiser4 suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

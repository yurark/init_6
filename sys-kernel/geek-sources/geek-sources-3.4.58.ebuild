# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

#AUFS_VER="$KMV"
BFQ_VER="3.4.0-v6r1"
#BLD_VER="${KMV}-rc4"
CK_VER="${KMV}-ck3"
FEDORA_VER="d0633aed96aaed8d8996ecec7213ad2bf1a819df" # Linux v3.4-10115-g829f51d
#GENTOO_VER="$KMV"
#GRSEC_VER="${PV}"
#ICE_VER="$KMV"
LQX_VER="3.4.35-1"
LQX_SRC="http://liquorix.net/sources/${LQX_VER}.patch.gz"
MAGEIA_VER="releases/3.4.6/1.mga3"
PAX_VER="3.4.8-test32"
#PF_VER="3.4.6-pf"
SUSE_VER="259fc874ec90b84ca02ad1c1ae186989c83bb2fa" # rpm-3.4.11-2.16
RT_VER="3.4.47-rt62"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.36"
ZEN_VER="3.4"

SUPPORTED_USES="aufs bfq -build ck fedora gentoo ice lqx mageia pax pf rt suse symlink uksm zen"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

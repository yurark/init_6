# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

# AUFS_VER="3.x-rcN"
BFQ_VER="3.14.0-v7r2" # BFQ_VER="${KSV}-v7r2"
# BLD_VER="3.13-rc1"
# CK_VER="3.12-ck2"
FEDORA_VER="master"
GRSEC_VER="3.0-${KSV}-201404192355" # 04/19/14 23:55
GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
ICE_VER="for-linux-${KSV}-2014-04-18"
# LQX_VER="${KSV}-1"
# MAGEIA_VER="releases/${KSV}/1.mga5"
OPENELEC_VER="${KMV}"
PAX_VER="${KSV}-test5" # PAX_VER="${KSV}-test3"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
# REISER4_VER="3.12.6"
RT_VER="3.14.0-rt1" # RT_VER="${KSV}-rt1"
SUSE_VER="linux-next"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}"

SUPPORTED_USES="aufs bfq brand -build deblob fedora gentoo ice openelec openwrt optimize pax pf rt suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

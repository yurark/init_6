# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

# AUFS_VER="3.x-rcN"
BFQ_VER="3.14.0-v7r5"
# BLD_VER="3.13-rc1"
CK_VER="3.14-ck1"
FEDORA_VER="master"
# GRSEC_VER="3.0-${KSV}-201401281848" # 01/28/14 18:49
# GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
ICE_VER="for-linux-3.14.2-2014-04-28"
# LQX_VER="${KSV}-1"
# MAGEIA_VER="releases/${KSV}/1.mga5"
OPENELEC_VER="${KSV}"
PAX_VER="${KMV}-test3" # PAX_VER="${KSV}-test3"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="3.14.1"
# RT_VER="${KSV}-rt17"
SUSE_VER="linux-next"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}"

SUPPORTED_USES="aufs bfq brand -build ck -deblob exfat fedora gentoo ice openelec optimize pax reiser4 suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

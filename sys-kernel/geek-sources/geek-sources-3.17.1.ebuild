# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="3.x-rcN"
BFQ_VER="${KSV}-v7r6"
# BLD_VER="3.16"
# CK_VER="3.16-ck1"
FEDORA_VER="master"
GRSEC_VER="3.0-${KSV}-201410192051" # 10/19/14 20:56
GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
# LQX_VER="${KSV}-1"
MAGEIA_VER="releases/3.17.0/3.mga5"
PAX_VER="3.17-test1"
# PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="3.17"
# RT_VER="${KSV}-rt17"
SUSE_VER="linux-next"
# UKSM_VER="0.1.2.3"
# UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.1"

SUPPORTED_USES="aufs brand bfq -build -deblob fedora gentoo grsec mageia pax reiser4 suse symlink zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS=""

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

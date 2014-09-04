# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="${KMV}"
BFQ_VER="3.15.0-v7r5"
# BLD_VER="3.13-rc1"
CK_VER="3.15-ck1"
FEDORA_VER="f20"
# GRSEC_VER="3.0-${KSV}-201408212335" # 07/07/14 20:47
# GRSEC_SRC="https://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
ICE_VER="for-linux-3.15.8-2014-08-07"
LQX_VER="3.15.10-1"
MAGEIA_VER="releases/3.15.6/1.mga5"
OPENELEC_VER="${KSV}"
OPTIMIZATION_SRC="https://raw.githubusercontent.com/graysky2/kernel_gcc_patch/master/enable_additional_cpu_optimizations_for_gcc_v4.9+_kernel_v${KMV}+.patch"
PAX_VER="3.15.10-test7"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="3.15.2"
# RT_VER="${KSV}-rt17"
SUSE_VER="stable"
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.3"

SUPPORTED_USES="aufs bfq brand -build ck deblob exfat fedora gentoo ice lqx mageia openwrt openelec optimize pax pf reiser4 suse symlink uksm zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

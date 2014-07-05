# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

# Kernel major revision
MAJREV="$(echo $PV | cut -f 2 -d .)"
# Kernel minor revision
MINREV="$(echo $PV | cut -f 3 -d .)"

# Kernel Version (Short)
KVS="$(echo $PV | cut -f 1-2 -d .)"
# Kernel version (Long)
KVL="$(echo $PV | cut -f 1-3 -d .)"

# AUFS_VER="3.x-rcN"
BFQ_VER="${KVS}.0-v7r5"
BLD_VER="${KVS}-rc1"
CK_VER="${KVS}-ck1"
FEDORA_VER="f20"
#GRSEC_VER="3.0-${KVL}-201404141717" # 04/14/14 17:18
#GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
ICE_VER="for-linux-${KVL}-2014-04-24"
LQX_VER="${KVS}.9-1"
MAGEIA_VER="releases/${KSV}/1.mga5"
OPENELEC_VER="${KVS}.7"
PAX_VER="${KVL}-test21"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="${KVS}.6"
# RT_VER="3.12.6-rt9"
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KVS}.ge.${MINREV}"

SUPPORTED_USES="aufs bfq bld brand -build ck -deblob exfat fedora gentoo hardened ice lqx mageia openwrt optimize pax pf reiser4 suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="amd64 x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

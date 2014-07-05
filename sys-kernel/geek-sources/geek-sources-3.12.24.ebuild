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
BLD_VER="${KVS}.0"
CK_VER="444"
FEDORA_VER="f19"
ICE_VER="for-linux-${KVS}.20-2014-06-02"
# LQX_VER="3.12.11-1" # LQX_VER="${KSV}-1"
MAGEIA_VER="releases/${KVS}.13/2.mga5"
PAX_VER="${KVS}.8-test15"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="${KVS}.6"
# RT_VER="${KSV}-rt17"
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KVS}.ge.23"

SUPPORTED_USES="aufs bfq bld brand -build ck -deblob exfat fedora gentoo ice mageia openwrt optimize pax pf reiser4 suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="amd64 x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

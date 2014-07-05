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

BFQ_VER="${KVS}.8+-v7r5"
BLD_VER="${KVS}.0"
BLD_SRC="https://bld.googlecode.com/files/bld-${BLD_VER}.patch"
CK_VER="440"
# HARDENED_VER="3.10.11"
ICE_VER="for-linux-${KVS}.45-2014-06-27"
LQX_VER="${KVS}.22-1"
MAGEIA_VER="releases/${KVS}.10/3.mga4"
OPTIMIZE_VER="2"
PAX_VER="${KVS}.12-test26"
REISER4_VER="${KVS}"
# RT_VER="${KSV}-rt25"
RSBAC_VER="1.4.7"
RSBAC_NAME="patch-linux-${KVS}.7-rsbac-${RSBAC_VER}.diff.xz"
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KVS}.ge.${MINREV}"

SUPPORTED_USES="aufs bfq bld brand -build cjktty ck fedora gentoo ice lqx mageia openwrt optimize pax pf reiser4 rh rsbac suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="amd64 x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

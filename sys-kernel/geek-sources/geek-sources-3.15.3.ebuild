# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="0"

# Kernel major revision
MAJREV="$(echo $PV | cut -f 2 -d .)"
# Kernel minor revision
MINREV="$(echo $PV | cut -f 3 -d .)"

# Kernel Version (Short)
KVS="$(echo $PV | cut -f 1-2 -d .)"
# Kernel version (Long)
KVL="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="3.x-rcN"
BFQ_VER="${KVS}.0-v7r5"
# BLD_VER="3.13-rc1"
CK_VER="${KVS}-ck1"
FEDORA_VER="master"
# GRSEC_VER="3.0-${KVL}-201401281848" # 01/28/14 18:49
# GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"
ICE_VER="for-linux-${KVS}.2-2014-06-27"
# LQX_VER="${KVL}-1"
# MAGEIA_VER="releases/${KVL}/1.mga5"
OPENELEC_VER="${KVL}"
PAX_VER="${KVL}-test2"
PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
# REISER4_VER="3.12.6"
# RT_VER="${KVL}-rt17"
SUSE_VER="linux-next"
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KVS}.ge.${MINREV}"

SUPPORTED_USES="aufs bfq brand -build ck -deblob fedora gentoo ice openelec optimize pax suse symlink uksm zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

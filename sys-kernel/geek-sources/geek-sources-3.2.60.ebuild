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

BFQ_VER="${KVS}.0-v7r5"
CK_VER="416"
FEDORA_VER="8959a0e95fa1ab409603d38059342e7a99668418" # 3.2
GRSEC_VER="3.0-${KVL}-201407012149" # 07/01/14 21:51
ICE_VER="for-linux-${KVS}.59-2014-06-02"
LQX_VER="${KVS}.28-1"
LQX_SRC="http://liquorix.net/sources/legacy/${LQX_VER}.patch.gz"
MAGEIA_VER="releases/3.2.9/2.mga2"
PAX_VER="${KVS}.60-test153"
PAX_SRC="https://grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
RSBAC_VER="1.4.7"
RSBAC_NAME="patch-linux-${KVS}.50-rsbac-${RSBAC_VER}.diff.xz"
# RT_VER="${KSV}-rt77"
SUSE_VER="2206a5c5b9aa64bd9a741830257f184818a0f6ee" # rpm-3.2.0-2
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KVS}.ge.${MINREV}"

SUPPORTED_USES="aufs bfq brand -build ck fedora gentoo grsec hardened ice lqx mageia optimize pax pf rsbac suse symlink uksm"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="amd64 x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

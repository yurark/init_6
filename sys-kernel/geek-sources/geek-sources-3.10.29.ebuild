# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

BFQ_VER="3.10.0-v7r1"
BLD_VER="3.10.0"
BLD_SRC="https://bld.googlecode.com/files/bld-${BLD_VER}.patch"
FEDORA_VER="f20"
# HARDENED_VER="3.10.11"
LQX_VER="3.10.22-1"
MAGEIA_VER="releases/3.10.10/3.mga4"
OPTIMIZE_VER="2"
PAX_VER="3.10.12-test26"
REISER4_VER="3.10"
# RT_VER="${KSV}-rt25"
RSBAC_VER="1.4.7"
RSBAC_NAME="patch-linux-3.10.7-rsbac-${RSBAC_VER}.diff.xz"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}"

SUPPORTED_USES="aufs bfq bld brand -build cjktty ck fedora gentoo ice lqx mageia openwrt optimize pax pf reiser4 rsbac suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="amd64 x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

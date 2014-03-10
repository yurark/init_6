# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

BFQ_VER="3.11.0-v7r2"
BLD_VER="3.11.0"
ICE_VER="for-linux-3.11.10-2013-11-30"
MAGEIA_VER="releases/3.11.4/1.mga4"
PAX_VER="3.11.9-test14"
REISER4_VER="3.11.1"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v3.10"

SUPPORTED_USES="aufs bfq bld brand -build cjktty ck exfat fedora gentoo ice mageia optimize pax pf reiser4 suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

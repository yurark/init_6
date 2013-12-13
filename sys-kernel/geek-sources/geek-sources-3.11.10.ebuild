# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

BFQ_VER="3.11.0-v6r2"
BLD_VER="3.11.0"
FEDORA_VER="f20"
LQX_VER="3.11.7-1"
LQX_SRC="http://liquorix.net/sources/${LQX_VER}.patch.gz"
MAGEIA_VER="releases/3.11.4/1.mga4"
PAX_VER="3.11.8-test13"
REISER4_VER="3.11.1"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v3.10"

#SUPPORTED_USES="aufs bfq bld brand -build cjktty ck exfat fedora gentoo hardened ice lqx mageia optimization pax pf reiser4 -rt suse symlink uksm zen zfs"
SUPPORTED_USES="aufs bfq bld brand -build cjktty ck exfat fedora gentoo hardened ice lqx mageia optimization pax pf reiser4 suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

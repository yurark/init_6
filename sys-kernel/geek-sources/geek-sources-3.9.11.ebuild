# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

BFQ_VER="3.9.0-v6r2"
FEDORA_VER="f19"
MAGEIA_VER="releases/3.9.8/1.mga4"
OPTIMIZATION_VER="2"
PAX_VER="3.9.9-test14"
REISER4_VER="3.9.2"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.1"

SUPPORTED_USES="aufs bfq brand -build cjktty ck fedora gentoo grsec ice mageia openwrt optimization pax pf reiser4 suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

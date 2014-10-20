# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="${KMV}"
BFQ_VER="${KMV}.0-v7r5"
BLD_VER="3.16"
CK_VER="3.16-ck2"
FEDORA_VER="f21"
#GRSEC_VER="3.0-3.16.5-201410132000" # 18/10/14 9.30
#GRSEC_SRC="https://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch" 
ICE_VER="for-linux-head-3.16.0-2014-08-07"
LQX_VER="3.16.4-1"
MAGEIA_VER="releases/3.15.6/1.mga5"
PAX_VER="3.16.4-test11"
# PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"
REISER4_VER="3.16.2"
# RT_VER="${KSV}-rt17"
SUSE_VER="stable"
UKSM_VER="0.1.2.3"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.1"

SUPPORTED_USES="aufs bfq brand -build ck -deblob fedora ice lqx mageia pax pf reiser4 suse symlink uksm zen zfs"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

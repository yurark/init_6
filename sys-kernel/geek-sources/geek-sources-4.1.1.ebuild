# Copyright 2009-2015 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="0"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

AUFS_VER="${KMV}"

# 2015-07-01 :
# Currently only up to 4.0
#BFQ_VER="${KMV}.0-v7r7"

# 2015-07-01 :
# Currently only up to 3.19
#BLD_VER="${KMV}"


# 2015-07-01 :
# Currently no 4.1 support.
#CK_VER="${KMV}-ck1"
#BFS_VER="461"

ICE_VER="for-linux-head-${KMV}.0-rc8-2015-06-17"
FEDORA_VER="f22"

#GRSEC_VER="3.1-${KSV}-201504190814" # 19/04/15 08:14
#GRSEC_SRC="http://grsecurity.net/test/grsecurity-${GRSEC_VER}.patch"

LQX_VER="${KSV}-1"
MAGEIA_VER="releases/${KSV}/1.mga5"

# 2015-07-01 :
# Currently only up to 4.0.7
#PAX_VER="${KMV}.7-test24"
#PAX_SRC="http://www.grsecurity.net/~paxguy1/pax-linux-${PAX_VER}.patch"

# reiser4 has a new subdirectory at:
# https://sourceforge.net/projects/reiser4/files/reiser4-for-linux-4.x/
# 2015-07-01 :
# It only supports up to 4.0.4, yet.
#REISER4_VER="${KMV}.5"

# RT_VER="${KSV}-rt17"
SUSE_VER="stable"

# 2015-07-01 :
# Only supported up to 4.0, yet.
#UKSM_VER="0.1.2.4"
#UKSM_NAME="uksm-${UKSM_VER}-beta-for-linux-v4.0"

# 2015-07-01 :
# ZEN is still empty for 4.1

SUPPORTED_USES="aufs brand -build -deblob fedora ice gentoo pf suse symlink"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

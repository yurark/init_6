# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"
KSV="$(echo $PV | cut -f 1-3 -d .)"

BFQ_VER="3.0.0-v6r2"
FEDORA_VER="fac491b47c9f0425a5067566dfbd5103af89a7d0" # 3.0-git21
MAGEIA_VER="releases/3.0.0/0.rc7.5.1.mga2"
SUSE_VER="f25ce3ee68e7642e2394493bc6385e018dee1030" # rpm-3.0.0-4
RT_VER="${KSV}-rt130"
UKSM_VER="0.1.2.2"
UKSM_NAME="uksm-${UKSM_VER}-for-v${KMV}.ge.84"

SUPPORTED_USES="aufs bfq -build fedora gentoo ice mageia pf rt suse symlink uksm"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

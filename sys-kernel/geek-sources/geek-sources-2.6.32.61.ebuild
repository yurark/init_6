# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

BFQ_VER="2.6.32"
GRSEC_VER="2.9.1-2.6.32.61-201312262018" # 12/26/13 20:18
PAX_VER="2.6.32.60-test215"
REISER4_VER="2.6.32"
REISER4_SRC="mirror://sourceforge/project/reiser4/reiser4-for-linux-2.6/reiser4-for-${REISER4_VER}.patch.gz"
RH_VER="19"
RH_NAME="kernel-2.6.32-${RH_VER}.el6"
RH_SRC="http://people.redhat.com/arozansk/el6/19.el6/src/${RH_NAME}.src.rpm"
OPENVZ_VER="042stab084.12"
SUSE_VER="3811b6910313cc9564c3e893d6ba75645ee38a6b" # rpm-2.6.32.45-0.3

SUPPORTED_USES="bfq brand -build grsec hardened openvz pax reiser4 rh suse symlink"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

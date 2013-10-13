# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

BFQ_VER="2.6.32"
GRSEC_VER="2.6.32"
SUSE_VER="3811b6910313cc9564c3e893d6ba75645ee38a6b" # rpm-2.6.32.45-0.3

SUPPORTED_USES="bfq -build grsec suse symlink"

inherit geek-sources

HOMEPAGE="https://github.com/init6/init_6/wiki/${PN}"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

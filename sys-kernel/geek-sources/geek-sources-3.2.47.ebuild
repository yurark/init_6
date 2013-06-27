# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

#user_aufs_ver="$KMV"
user_bfq_ver="3.2.0-v6r1"
#user_bld_ver="${KMV}-rc4"
user_ck_ver="${KMV}-ck1"
user_fedora_ver="8959a0e95fa1ab409603d38059342e7a99668418" # 3.2
#user_gentoo_ver="$KMV"
user_grsec_ver="${PV}"
#user_ice_ver="$KMV"
user_lqx_ver="3.2.28-1"
user_lqx_src="http://liquorix.net/sources/legacy/${user_lqx_ver}.patch.gz"
user_mageia_ver="releases/3.2.9/2.mga2"
user_pax_ver="3.2.47-test109"
user_pf_ver="3.2.7-pf"
user_suse_ver="2206a5c5b9aa64bd9a741830257f184818a0f6ee" # rpm-3.2.0-2
user_rt_ver="3.2.46-rt67"
user_uksm_ver="0.1.2.2"
user_uksm_name="uksm-${user_uksm_ver}-for-v${KMV}.ge.40"

SUPPORTED_USES="aufs bfq -build ck fedora gentoo grsec ice lqx mageia pax pf rt suse symlink uksm"

inherit geek-sources

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

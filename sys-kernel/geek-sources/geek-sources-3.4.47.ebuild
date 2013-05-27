# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="1"

KMV="$(echo $PV | cut -f 1-2 -d .)"

#user_aufs_ver="$KMV"
user_bfq_ver="3.4.0-v6r1"
user_bld_ver="${KMV}-rc4"
user_ck_ver="${KMV}-ck3"
#user_fedora_ver="f19"
#user_gentoo_ver="$KMV"
#user_grsec_ver="${PV}"
#user_ice_ver="$KMV"
user_lqx_ver="3.4.35-1"
user_lqx_src="http://liquorix.net/sources/${user_lqx_ver}.patch.gz"
user_mageia_ver="releases/3.4.6/1.mga3"
user_pax_ver="3.4.8-test32"
user_pf_ver="3.4.6-pf"
#user_suse_ver="stable"
user_rt_ver="3.4.45-rt60"
user_uksm_ver="0.1.2.2"
user_uksm_name="uksm-${user_uksm_ver}-for-v${KMV}.ge.36"

SUPPORTED_USES="aufs bfq bld -build ck gentoo ice lqx mageia pax pf rt symlink uksm"

inherit geek-sources

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

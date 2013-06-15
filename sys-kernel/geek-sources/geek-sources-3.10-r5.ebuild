# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DEBLOB_AVAILABLE="0"

KMV="$(echo $PV | cut -f 1-2 -d .)"

user_aufs_ver="3.x-rcN"
#user_bfq_ver="3.9.0-v6r1"
user_bld_ver="${KMV}-rc5"
#user_ck_ver="${KMV}-ck1"
user_fedora_ver="master"
#user_gentoo_ver="$KMV"
#user_grsec_ver="${PV}"
#user_ice_ver="$KMV"
#user_lqx_ver="3.9.5-1"
#user_lqx_src="http://liquorix.net/sources/${user_lqx_ver}.patch.gz"
#user_mageia_ver="releases/3.9.4/1.mga4"
#user_pax_ver="3.9.4-test8"
#user_pf_ver="3.9.4-pf"
#user_reiser4_ver="3.9.2"
user_suse_ver="master"
#user_uksm_ver="0.1.2.2"
#user_uksm_name="uksm-${user_uksm_ver}-for-v${KMV}.ge.1"

SUPPORTED_USES="aufs bld branding -build fedora suse symlink"

inherit geek-sources

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources for the Linux kernel including: fedora, grsecurity, mageia and other patches"

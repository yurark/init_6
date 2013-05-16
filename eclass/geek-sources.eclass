# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
#  Copyright © 2011-2013 Andrey Ovcharov <sudormrfhalt@gmail.com>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#  The latest version of this software can be obtained here:
#
#  https://github.com/init6/init_6/blob/master/eclass/geek-sources.eclass
#
#  Wiki: https://github.com/init6/init_6/wiki/geek-sources.eclass
#

#
#  May 02, 2011 Add sys-kernel/fc-sources-2.6.38.4
#  February 05, 2012 sys-kernel/fc-sources -> sys-kernel/geek-sources
#

# Logical part
# Purpose: Installing geek-sources
# Uses: linux-geek.eclass
#
# Bugs to sudormrfhalt@gmail.com
#

inherit linux-geek

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install pkg_postinst

KNOWN_USES="aufs bfq bld branding build ck deblob fedora gentoo grsec ice lqx mageia pax pf reiser4 rt suse symlink uksm zfs";

# @FUNCTION: geek-sources__init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all git variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-sources_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${GEEK_STORE_DIR:="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/geek"}

	# Disable the sandbox for this dir
	addwrite "${GEEK_STORE_DIR}"
}

# internal function
#
# @FUNCTION: USEKnown
# @USAGE:
# @DESCRIPTION:
USEKnown() {
	local USE=$1
	[ "${USE}" == "" ] && die "Feature not defined!"

	expr index "${SUPPORTED_USES}" "${USE}" >/dev/null || die "${USE} is not supported in current kernel"
	expr index "${KNOWN_USES}" "${USE}" >/dev/null || die "${USE} is not known"
	IUSE="${IUSE} ${USE}"
	case ${USE} in
		aufs)	aufs_ver=${user_aufs_ver:-$KMV}
			aufs_def_src="git://git.code.sf.net/p/aufs/aufs3-standalone"
			aufs_src=${user_aufs_src:-$aufs_def_src}
			aufs_url="http://aufs.sourceforge.net"
			aufs_inf="Another UnionFS - ${aufs_url}"
			HOMEPAGE="${HOMEPAGE} ${aufs_url}"
			;;
		bfq)	bfq_ver=${user_bfq_ver:-$KMV}
			bfq_def_src="http://algo.ing.unimo.it/people/paolo/disk_sched/patches"
			bfq_src=${user_bfq_src:-$bfq_def_src}
			bfq_url="http://algo.ing.unimo.it/people/paolo/disk_sched/"
			bfq_inf="Budget Fair Queueing Budget I/O Scheduler - ${bfq_url}"
			HOMEPAGE="${HOMEPAGE} ${bfq_url}"
			;;
		bld)	bld_ver=${user_bld_ver:-$KMV}
			bld_def_src="http://bld.googlecode.com/files/bld-${bld_ver/KMV/$KMV}.tar.bz2"
			bld_src=${user_bld_src:-$bld_def_src}
			bld_url="http://code.google.com/p/bld"
			bld_url="Alternate CPU load distribution technique for Linux kernel scheduler - ${bld_url}"
			HOMEPAGE="${HOMEPAGE} ${bld_url}"
			SRC_URI="${SRC_URI}
				bld?		( ${bld_src} )"
			;;
		ck)	ck_ver=${user_ck_ver:-$KMV-ck1}
			ck_def_src="http://ck.kolivas.org/patches/3.0/${KMV}/${ck_ver/KMV/$KMV}/patch-${ck_ver/KMV/$KMV}.lrz"
			ck_src=${user_ck_src:-$ck_def_src}
			ck_url="http://users.on.net/~ckolivas/kernel"
			ck_inf="Con Kolivas high performance patchset - ${ck_url}"
			HOMEPAGE="${HOMEPAGE} ${ck_url}"
			DEPEND="${DEPEND} >=app-arch/lrzip-0.614"
			SRC_URI="${SRC_URI}
				ck?		( ${ck_src} )"
			;;
		fedora)	fedora_ver=${user_fedora_ver:-f19}
			fedora_def_src="git://pkgs.fedoraproject.org/kernel.git"
			fedora_src=${user_fedora_src:-$fedora_def_src}
			fedora_url="http://fedoraproject.org"
			fedora_inf="Fedora - ${fedora_url}"
			HOMEPAGE="${HOMEPAGE} ${fedora_url}"
			;;
		gentoo)	gentoo_ver=${user_gentoo_ver:-$KMV}
			gentoo_def_src="svn://anonsvn.gentoo.org/linux-patches/genpatches-2.6/trunk"
			gentoo_src=${user_gentoo_src:-$gentoo_def_src}
			gentoo_url="http://dev.gentoo.org/~mpagano/genpatches"
			gentoo_inf="Gentoo patches - ${gentoo_url}"
			HOMEPAGE="${HOMEPAGE} ${gentoo_url}"
			;;
		grsec)	grsec_ver=${user_grsec_ver:-$KMV}
			grsec_def_src="git://git.overlays.gentoo.org/proj/hardened-patchset.git"
			grsec_src=${user_grsec_src:-$grsec_def_src}
			grsec_url="http://hardened.gentoo.org"

			grsecp_ver=${user_grsecp_ver:-$KMV}
			grsecp_def_src="http://grsecurity.net/test/grsecurity-${grsecp_ver}.patch"
			grsecp_src=${user_grsecp_src:-$grsecp_def_src}
			grsecp_url="http://grsecurity.net"

			grsec_inf="GrSecurity patches - ${grsec_url} ${grsecp_url}"
			HOMEPAGE="${HOMEPAGE} ${grsec_url}"
			RDEPEND="${RDEPEND}
				grsec?	( >=sys-apps/gradm-2.2.2 )"
			;;
		ice)	ice_ver=${user_ice_ver:-$KMV}
			ice_def_src="https://github.com/NigelCunningham/tuxonice-kernel/compare/vanilla-${ice_ver/KMV/$KMV}...tuxonice-${ice_ver/KMV/$KMV}.diff"
			ice_src=${user_ice_src:-$ice_def_src}
			ice_url="http://tuxonice.net"
			ice_inf="TuxOnIce - ${ice_url}"
			HOMEPAGE="${HOMEPAGE} ${ice_url}"
			RDEPEND="${RDEPEND}
				ice?	( >=sys-apps/tuxonice-userui-1.0
						( || ( >=sys-power/hibernate-script-2.0 sys-power/pm-utils ) ) )"
			;;
		lqx)	lqx_ver=${user_lqx_ver:-$KMV}
			lqx_def_src="http://liquorix.net/sources/${lqx_ver/KMV/$KMV}.patch.gz"
			lqx_src=${user_lqx_src:-$lqx_def_src}
			lqx_url="http://liquorix.net"
			lqx_inf="Liquorix patches - ${lqx_url}"
			HOMEPAGE="${HOMEPAGE} ${lqx_url}"
			SRC_URI="${SRC_URI}
				lqx?			( ${lqx_src} )"
			;;
		mageia) mageia_ver=${user_mageia_ver:-$KMV}
			mageia_def_src="svn://svn.mageia.org/svn/packages/cauldron/kernel"
			mageia_src=${user_mageia_src:-$mageia_def_src}
			mageia_url="http://www.mageia.org"
			mageia_inf="Mageia - ${mageia_url}"
			HOMEPAGE="${HOMEPAGE} ${mageia_url}"
			;;
		pax)	pax_ver=${user_pax_ver:-$KMV}
			pax_def_src="http://grsecurity.net/test/pax-linux-${pax_ver/KMV/$KMV}.patch"
			pax_src=${user_pax_src:-$pax_def_src}
			pax_url="http://pax.grsecurity.net"
			pax_inf="PAX patches - ${pax_url}"
			HOMEPAGE="${HOMEPAGE} ${pax_url}"
			SRC_URI="${SRC_URI}
				pax?			( ${pax_src} )"
			;;
		pf)	pf_ver=${user_pf_ver:-$KMV}
			pf_def_src="http://pf.natalenko.name/sources/${KMV}/patch-${pf_ver/KMV/$KMV}.bz2"
			pf_src=${user_pf_src:-$pf_def_src}
			pf_url="http://pf.natalenko.name"
			pf_inf="pf-kernel patches - ${pf_url}"
			HOMEPAGE="${HOMEPAGE} ${pf_url}"
			SRC_URI="${SRC_URI}
				pf?			( ${pf_src} )"
			;;
		reiser4) reiser4_ver=${user_reiser4_ver:-$KMV}
			reiser4_def_src="mirror://sourceforge/project/reiser4/reiser4-for-linux-3.x/reiser4-for-${reiser4_ver/PV/$PV}.patch.gz"
			reiser4_src=${user_reiser4_src:-$reiser4_def_src}
			reiser4_url="http://sourceforge.net/projects/reiser4"
			reiser4_inf="ReiserFS v4 - ${reiser4_url}"
			HOMEPAGE="${HOMEPAGE} ${reiser4_url}"
			SRC_URI="${SRC_URI}
				reiser4?	( ${reiser4_src} )"
			;;
		rt)	rt_ver=${user_rt_ver:-$KMV}
			rt_def_src="http://www.kernel.org/pub/linux/kernel/projects/rt/${KMV}/patch-${rt_ver/KMV/$KMV}.patch.xz"
			rt_src=${user_rt_src:-$rt_def_src}
			rt_url="http://www.kernel.org/pub/linux/kernel/projects/rt"
			rt_inf="Ingo Molnar's realtime preempt patches - ${rt_url}"
			HOMEPAGE="${HOMEPAGE} ${rt_url}"
			SRC_URI="${SRC_URI}
				rt?		( ${rt_src} )"
			;;
		suse)	suse_ver=${user_suse_ver:-stable}
			suse_def_src="git://kernel.opensuse.org/kernel-source.git"
			suse_src=${user_suse_src:-$suse_def_src}
			suse_url="http://www.opensuse.org"
			suse_inf="OpenSuSE - ${suse_url}"
			HOMEPAGE="${HOMEPAGE} ${suse_url}"
			;;
		uksm)	uksm_ver=${user_uksm_ver:-$KMV}
			uksm_name=${user_uksm_name:-uksm-${uksm_ver}-for-v${KMV}.ge.1}
			uksm_def_src="http://kerneldedup.org/download/uksm/${uksm_ver}/${uksm_name}.patch"
			uksm_src=${user_uksm_src:-$uksm_def_src}
			uksm_url="http://kerneldedup.org"
			uksm_inf="Ultra Kernel Samepage Merging - ${uksm_url}"
			HOMEPAGE="${HOMEPAGE} ${uksm_url}"
			;;
		zfs)	spl_ver=${user_spl_ver:-$KMV}
			spl_src=${user_spl_src:-spl_def_src}
			zfs_ver=${user_zfs_ver:-KMV}
			zfs_src=${user_zfs_src:-zfs_def_src}
			zfs_url="http://zfsonlinux.org"
			zfs_inf="Native ZFS on Linux - ${zfs_url}"
			HOMEPAGE="${HOMEPAGE} ${zfs_url}"
			LICENSE="${LICENSE} GPL-3"
			RDEPEND="${RDEPEND}
				zfs?	( sys-fs/zfs[kernel-builtin] )"
			;;
	esac
}

for I in ${SUPPORTED_USES}; do
	USEKnown "${I}"
done

# @FUNCTION: in_iuse
# @USAGE: <flag>
# @DESCRIPTION:
# Determines whether the given flag is in IUSE. Strips IUSE default prefixes
# as necessary.
#
# Note that this function should not be used in the global scope.
in_iuse() {
	debug-print-function ${FUNCNAME} "${@}"
	[[ ${#} -eq 1 ]] || die "Invalid args to ${FUNCNAME}()"

	local flag=${1}
	local liuse=( ${IUSE} )

	has "${flag}" "${liuse[@]#[+-]}"
}

# @FUNCTION: use_if_iuse
# @USAGE: <flag>
# @DESCRIPTION:
# Return true if the given flag is in USE and IUSE.
#
# Note that this function should not be used in the global scope.
use_if_iuse() {
	in_iuse $1 || return 1
	use $1
}

# @FUNCTION: get_from_url
# @USAGE:
# @DESCRIPTION:
get_from_url() {
	local url="$1"
	local release="$2"
	shift
	wget -nd --no-parent --level 1 -r -R "*.html*" --reject "$release" \
	"$url/$release" > /dev/null 2>&1
}

# @FUNCTION: git_get_all_branches
# @USAGE:
# @DESCRIPTION:
git_get_all_branches(){
	for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
		git branch --track ${branch##*/} ${branch} > /dev/null 2>&1
	done
}

# @FUNCTION: get_or_bump
# @USAGE:
# @DESCRIPTION:
get_or_bump() {
	local patch=$1
	local CSD="${GEEK_STORE_DIR}/${patch}";
	shift
	if [ -d ${CSD} ]; then
		cd "${CSD}"
		if [ -e ".git" ]; then # git
			git fetch --all && git pull --all;
		elif [ -e ".svn" ]; then # subversion
			svn up
		fi
	else
		case "${patch}" in
		aufs) git clone "${aufs_src}" "${CSD}" > /dev/null 2>&1; cd "${CSD}"; git_get_all_branches ;;
		fedora) git clone "${fedora_src}" "${CSD}" > /dev/null 2>&1; cd "${CSD}"; git_get_all_branches ;;
		gentoo) svn co "${gentoo_src}" "${CSD}" > /dev/null 2>&1;;
		grsec) git clone "${grsec_src}" "${CSD}" > /dev/null 2>&1; cd "${CSD}"; git_get_all_branches ;;
		mageia) svn co "${mageia_src}" "${CSD}" > /dev/null 2>&1;;
		suse) git clone "${suse_src}" "${CSD}" > /dev/null 2>&1; cd "${CSD}"; git_get_all_branches ;;
		esac
	fi
}

# @FUNCTION: make_patch
# @USAGE:
# @DESCRIPTION:
make_patch() {
	local patch="$1"
	local CSD="${GEEK_STORE_DIR}/${patch}";
	local CWD="${T}/${patch}";
	local CTD="/tmp/${patch}"$$
	# Disable the sandbox for this dir
	addwrite "${CTD}"
	shift
	case "${patch}" in
	aufs)	cd "${CSD}";
		test -d "${CWD}" >/dev/null 2>&1 || mkdir -p "${CWD}";
		get_or_bump "${patch}" > /dev/null 2>&1;
		cp -r "${CSD}" "${CTD}";
		cd "${CTD}";
		dir=( "Documentation" "fs" "include" )
		local dest="${CWD}"/aufs3-${aufs_ver}-`date +"%Y%m%d"`.patch;

		git checkout origin/aufs"${aufs_ver}" > /dev/null 2>&1; git pull > /dev/null 2>&1;

		mkdir ../a ../b
		cp -r {Documentation,fs,include} ../b
		rm ../b/include/uapi/linux/Kbuild
		cd ..

		for i in "${dir[@]}";
			do diff -U 3 -dHrN -- a/ b/"${i}"/ >> "${dest}";
			sed -i "s:a/:a/"${i}"/:" "${dest}";
			sed -i "s:b:b:" "${dest}";
		done
		rm -rf a b;

		cp "${CTD}"/aufs3-base.patch "${CWD}"/aufs3-base-${aufs_ver}-`date +"%Y%m%d"`.patch;
		cp "${CTD}"/aufs3-standalone.patch "${CWD}"/aufs3-standalone-${aufs_ver}-`date +"%Y%m%d"`.patch;
		cp "${CTD}"/aufs3-kbuild.patch "${CWD}"/aufs3-kbuild-${aufs_ver}-`date +"%Y%m%d"`.patch;
		cp "${CTD}"/aufs3-proc_map.patch "${CWD}"/aufs3-proc_map-${aufs_ver}-`date +"%Y%m%d"`.patch;
		cp "${CTD}"/aufs3-loopback.patch "${CWD}"/aufs3-loopback-${aufs_ver}-`date +"%Y%m%d"`.patch;

		rm -rf "${CTD}";

		ls -1 "${CWD}" | grep ".patch" > "${CWD}"/patch_list;
	;;
	bfq)	test -d "${CWD}" >/dev/null 2>&1 || mkdir -p "${CWD}";
		cd "${CWD}";

		get_from_url "${bfq_src}" "${bfq_ver}" > /dev/null 2>&1;

		ls -1 "${CWD}" | grep ".patch" > "${CWD}"/patch_list;
	;;
	fedora) cd "${CSD}";
		test -d "${CWD}" >/dev/null 2>&1 || mkdir -p "${CWD}";
		get_or_bump "${patch}" > /dev/null 2>&1;

		cp -r "${CSD}" "${CTD}";
		cd "${CTD}";

		git checkout "${fedora_ver}" > /dev/null 2>&1; git pull > /dev/null 2>&1;

		ls -1 | grep ".patch" | xargs -I{} cp "{}" "${CWD}"

		cat kernel.spec | sed -n '/### BRANCH APPLY ###/ ,/# END OF PATCH APPLICATIONS/p' | sed 's/ApplyPatch //g' | sed 's/ApplyOptionalPatch //g' | sed 's/ pplyPatch //g' | sed -n '/%endif/ ,/%endif/!p' | sed -e '/^%/d' | sed 's/ -R//g' > "$CWD"/patch_list

		rm -rf "${CTD}"
	;;
	gentoo) cd "${CSD}";
		test -d "${CWD}" >/dev/null 2>&1 || mkdir -p "${CWD}";
		cd "${CWD}";

		get_or_bump "${patch}" > /dev/null 2>&1;

		cp -r "${CSD}" "${CTD}";
		cd "${CTD}"/${KMV};

		find -name .svn -type d -exec rm -rf {} \;
		find -type d -empty -delete

		ls -1 | grep "linux" | xargs -I{} rm -rf "{}";
		ls -1 | grep ".patch" > "$CWD"/patch_list;

		cp -r "${CTD}"/${KMV}/* "${CWD}"

		rm -rf "${CTD}"
	;;
	grsec) cd "${CSD}";
		test -d "${CWD}" >/dev/null 2>&1 || mkdir -p "${CWD}";
		get_or_bump "${patch}" > /dev/null 2>&1;

		cp -r "${CSD}" "${CTD}";

		cd "${CTD}"/"${grsec_ver}";

		ls -1 | grep "_linux-" | xargs rm
		ls -1 | grep "4420_grsecurity-" | xargs rm

		wget "${grsecp_src}" -O "4420_grsecurity-${grsecp_ver}.patch" > /dev/null 2>&1

		ls -1 | xargs -I{} cp "{}" "${CWD}";

		rm -rf "${CTD}";

		ls -1 "${CWD}" | grep ".patch" > "${CWD}"/patch_list;
	;;
	ice)	test -d "${CWD}" >/dev/null 2>&1 || mkdir -p "${CWD}";
		dest="${CWD}"/tuxonice-kernel-"${PV}"-`date +"%Y%m%d"`.patch;
		wget "${ice_src}" -O "${dest}" > /dev/null 2>&1;
		cd "${CWD}";
		ls -1 | grep ".patch" | xargs -I{} xz "{}" | xargs -I{} cp "{}" "${CWD}";
		ls -1 "${CWD}" | grep ".patch.xz" > "${CWD}"/patch_list;
	;;
	mageia) cd "${CSD}";
		test -d "${CWD}" >/dev/null 2>&1 || mkdir -p "${CWD}";
		get_or_bump "${patch}" > /dev/null 2>&1;

		cp -r "${CSD}" "${CTD}";
		cd "${CTD}"/releases/"${mageia_ver}"/PATCHES;

		find . -name "*.patch" | xargs -i cp "{}" "${CWD}";

		cat patches/series | sed 's/3rd-/#3rd-/g' > "${CWD}"/patch_list;

		rm -rf "${CTD}"
	;;
	suse)	cd "${CSD}";
		test -d "${CWD}" >/dev/null 2>&1 || mkdir -p "${CWD}";
		get_or_bump "${patch}" > /dev/null 2>&1;

		cp -r "${CSD}" "${CTD}";

		cd "${CTD}";

		git checkout "${suse_ver}" > /dev/null 2>&1; git pull > /dev/null 2>&1;

		[ -e "patches.kernel.org" ] && rm -rf patches.kernel.org > /dev/null 2>&1
		[ -e "patches.rpmify" ] && rm -rf patches.rpmify > /dev/null 2>&1

		cat series.conf | sed -n '/# Kernel patches configuration file/ ,/# own build environment./!p' | sed 's/+needs_update?/\#/g' | sed 's/+needs_update37/\#/g' | sed 's/+needs_updating-39/\#/g' | sed 's/+needs_update/\#/g' | sed 's/patches.kernel.org/\#patches.kernel.org/g' | sed 's/patches.rpmify/\#patches.rpmify/g' | sed 's/patches.xen/\#patches.xen/g' | sed 's/+trenn/\#/g' | sed 's/+hare/\#/g' | sed 's/+jeffm/\#/g' | sed 's/+jbeulich/\#/g' | sed 's/+update_xen/\#/g' | sed 's/+xen_needs_update/\#/g' | sed 's/[\t]//g' | sed 's/        //g' > patch_list

#		cp -r patches.*/ "${CWD}";
		cp -r * "${CWD}";

		rm -rf "${CTD}";
	;;
	esac

	cd "${S}"
}

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION:
geek-sources_src_unpack() {

	geek-sources_init_variables

	local SKIP_KERNEL_PATCH_UPDATE="lqx pf";
	for Current_Patch in $SKIP_KERNEL_PATCH_UPDATE; do
		if use_if_iuse "${Current_Patch}" ; then
		case "${Current_Patch}" in
			*) SKIP_UPDATE="1";
				;;
		esac
		else continue
		fi;
	done;

	linux-geek_src_unpack

}


# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION:
geek-sources_src_prepare() {

### BRANCH APPLY ###

	local _PATCHDIR="/etc/portage/patches" # for user patch
	local config_file="/etc/portage/kernel.conf"
	local DEFAULT_GEEKSOURCES_PATCHING_ORDER="pax lqx pf bfq ck gentoo grsec ice reiser4 rt bld uksm aufs mageia fedora suse zfs branding fix upatch";
	local xUserOrder=""
	local xDefOder=""
	if [ -e "${config_file}" ] ; then
		source "${config_file}"
		xUserOrder="$(echo -n "$GEEKSOURCES_PATCHING_ORDER" | tr '\n' ' ' | tr -s ' ' | tr ' ' '\n' | sort | tr '\n' ' ' | sed -e 's,^\s*,,' -e 's,\s*$,,')"
		xDefOrder="$(echo -n "$DEFAULT_GEEKSOURCES_PATCHING_ORDER" | tr '\n' ' ' | tr -s ' ' | tr ' ' '\n' | sort | tr '\n' ' ' | sed -e 's,^\s*,,' -e 's,\s*$,,')"

		if [ "x${xUserOrder}" = "x${xDefOrder}" ] ; then
			ewarn "Use GEEKSOURCES_PATCHING_ORDER=\"${GEEKSOURCES_PATCHING_ORDER}\" from ${config_file}"
		else
			ewarn "Use GEEKSOURCES_PATCHING_ORDER=\"${GEEKSOURCES_PATCHING_ORDER}\" from ${config_file}"
			ewarn "Not all USE flag present in GEEKSOURCES_PATCHING_ORDER from ${config_file}"
			difference=$(echo "${xDefOrder} ${xUserOrder}" | awk '{for(i=1;i<=NF;i++){_a[$i]++}for(i in _a){if(_a[i]==1)print i}}' ORS=" ")
			ewarn "The following flags are missing: ${difference}"
			ewarn "Probably that's the plan. In that case, never mind."
		fi
	else
		GEEKSOURCES_PATCHING_ORDER="${DEFAULT_GEEKSOURCES_PATCHING_ORDER}";
		ewarn "The order of patching is defined in file ${config_file} with the variable GEEKSOURCES_PATCHING_ORDER is its default value:
GEEKSOURCES_PATCHING_ORDER=\"${GEEKSOURCES_PATCHING_ORDER}\"
You are free to choose any order of patching.
For example, if you like the alphabetical order of patching you must set the variable:
echo 'GEEKSOURCES_PATCHING_ORDER=\"aufs bfq bld branding build ck deblob fedora gentoo grsec ice lqx mageia pax pf reiser4 rt suse symlink uksm zfs\"' > ${config_file}
Otherwise i will use the default value of GEEKSOURCES_PATCHING_ORDER!
And may the Force be with you…"
	fi

for Current_Patch in $GEEKSOURCES_PATCHING_ORDER; do
	if use_if_iuse "${Current_Patch}" || [[ "${Current_Patch}" == "fix" ]] || [[ "${Current_Patch}" == "upatch" ]] ; then
		if [ -e "${FILESDIR}/${PV}/${Current_Patch}/info" ] ; then
			echo
			cat "${FILESDIR}/${PV}/${Current_Patch}/info";
		fi
		test -d "${S}/patches" >/dev/null 2>&1 || mkdir -p "${S}/patches";
		case "${Current_Patch}" in
			aufs)	make_patch "${Current_Patch}"
				ApplyPatch "${T}/${Current_Patch}/patch_list" "${aufs_inf}";
				mv "${T}/${Current_Patch}" "${S}/patches/${Current_Patch}"
				;;
			bfq)	make_patch "${Current_Patch}"
				ApplyPatch "${T}/${Current_Patch}/patch_list" "${bfq_inf}";
				mv "${T}/${Current_Patch}" "${S}/patches/${Current_Patch}"
				;;
			bld)	echo;
				cd "${T}";
				unpack "bld-${bld_ver/KMV/$KMV}.tar.bz2";
				cp "${T}/bld-${bld_ver/KMV/$KMV}/BLD-${bld_ver/KMV/$KMV}.patch" "${S}/BLD-${bld_ver/KMV/$KMV}.patch";
				cd "${S}";
				ApplyPatch "BLD-${bld_ver/KMV/$KMV}.patch" "${bld_inf}";
				rm -f "BLD-${bld_ver/KMV/$KMV}.patch";
				rm -r "${T}/bld-${bld_ver/KMV/$KMV}"; # Clean temp
				;;
			branding) if [ -e "${FILESDIR}/${Current_Patch}/info" ] ; then
					echo
					cat "${FILESDIR}/${Current_Patch}/info";
				fi
				ApplyPatch "${FILESDIR}/${Current_Patch}/patch_list" "Branding";
				;;
			ck)	ApplyPatch "${DISTDIR}/patch-${ck_ver/KMV/$KMV}.lrz" "${ck_inf}";
				if [ -d "${FILESDIR}/${PV}/${Current_Patch}" ] ; then
					if [ -e "${FILESDIR}/${PV}/${Current_Patch}/patch_list" ] ; then
						ApplyPatch "${FILESDIR}/${PV}/${Current_Patch}/patch_list" "CK Fix";
					fi
				fi
				# Comment out EXTRAVERSION added by CK patch:
				sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "Makefile"
				;;
			fedora) make_patch "${Current_Patch}"
				ApplyPatch "${T}/${Current_Patch}/patch_list" "${fedora_inf}";
				mv "${T}/${Current_Patch}" "${S}/patches/${Current_Patch}"
				;;
			fix)	ApplyPatch "${FILESDIR}/${PV}/${Current_Patch}/patch_list" "Fixes for current kernel"
				;;
			gentoo) make_patch "${Current_Patch}"
				ApplyPatch "${T}/${Current_Patch}/patch_list" "${gentoo_inf}";
				mv "${T}/${Current_Patch}" "${S}/patches/${Current_Patch}"
				;;
			grsec) make_patch "${Current_Patch}"
				ApplyPatch "${T}/${Current_Patch}/patch_list" "${grsec_inf}";
				mv "${T}/${Current_Patch}" "${S}/patches/${Current_Patch}"
				;;
			ice)	make_patch "${Current_Patch}"
				ApplyPatch "${T}/${Current_Patch}/patch_list" "${ice_inf}";
				mv "${T}/${Current_Patch}" "${S}/patches/${Current_Patch}"
				;;
			lqx)	ApplyPatch "${DISTDIR}/${lqx_ver/KMV/$KMV}.patch.gz" "${lqx_inf}";
				;;
			mageia) make_patch "${Current_Patch}"
				ApplyPatch "${T}/${Current_Patch}/patch_list" "${mageia_inf}";
				mv "${T}/${Current_Patch}" "${S}/patches/${Current_Patch}"
				;;
			pax)	ApplyPatch "${DISTDIR}/pax-linux-${pax_ver/KMV/$KMV}.patch" "${pax_inf}";
				;;
			pf)	ApplyPatch "${DISTDIR}/patch-${pf_ver/KMV/$KMV}.bz2" "${pf_inf}";
				;;
			reiser4) ApplyPatch "${DISTDIR}/reiser4-for-${reiser4_ver}.patch.gz" "${reiser4_inf}";
				;;
			rt)	ApplyPatch "${DISTDIR}/patch-${rt_ver}.patch.xz" "${rt_inf}";
				;;
			suse)	make_patch "${Current_Patch}"
				ApplyPatch "${T}/${Current_Patch}/patch_list" "${suse_inf}";
				mv "${T}/${Current_Patch}" "${S}/patches/${Current_Patch}"
				;;
			uksm)	ApplyPatch "${FILESDIR}/${PV}/${Current_Patch}/patch_list" "${uksm_inf}";
				;;
			upatch) if [ -d "${_PATCHDIR}/${CATEGORY}/${PN}" ] ; then
					if [ -e "${_PATCHDIR}/${CATEGORY}/${PN}/info" ] ; then
						echo
						cat "${_PATCHDIR}/${CATEGORY}/${PN}/info";
					fi
					if [ -e "${_PATCHDIR}/${CATEGORY}/${PN}/patch_list" ] ; then
						ApplyPatch "${_PATCHDIR}/${CATEGORY}/${PN}/patch_list" "Applying user patches"
					else
						ewarn "File ${_PATCHDIR}/${CATEGORY}/${PN}/patch_list not found!"
						ewarn "Try to apply the patches if they are there…"
						for i in `ls ${_PATCHDIR}/${CATEGORY}/${PN}/*.{patch,gz,bz,bz2,lrz,xz,zip,Z} 2> /dev/null`; do
							ApplyPatch "${i}" "Applying user patches"
						done
					fi
				fi
				;;
			zfs)	if use_if_iuse "grsec" ; then
					[ -e "${FILESDIR}/${PV}/${Current_Patch}/grsec/info" ] && echo; cat "${FILESDIR}/${PV}/${Current_Patch}/grsec/info";
					[ -e "${FILESDIR}/${PV}/${Current_Patch}/grsec/patch_list" ] && ApplyPatch "${FILESDIR}/${PV}/${Current_Patch}/grsec/patch_list" "${zfs_inf}";
				else
					[ -e "${FILESDIR}/${PV}/${Current_Patch}/vanilla/info" ] && cat "${FILESDIR}/${PV}/${Current_Patch}/vanilla/info";
					[ -e "${FILESDIR}/${PV}/${Current_Patch}/vanilla/patch_list" ] && ApplyPatch "${FILESDIR}/${PV}/${Current_Patch}/vanilla/patch_list" "${zfs_inf}";
				fi;
				[ -e "${FILESDIR}/${PV}/${Current_Patch}/patch_list" ] && ApplyPatch "${FILESDIR}/${PV}/${Current_Patch}/patch_list" "${zfs_inf}";
				;;
		esac
	else continue
	fi;
done;

### END OF PATCH APPLICATIONS ###

	linux-geek_src_prepare
}

# @FUNCTION: src_compile
# @USAGE:
# @DESCRIPTION:
geek-sources_src_compile() {
	linux-geek_src_compile
}

# @FUNCTION: src_install
# @USAGE:
# @DESCRIPTION:
geek-sources_src_install() {
	linux-geek_src_install
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION:
geek-sources_pkg_postinst() {
	linux-geek_pkg_postinst
	einfo
	einfo "Wiki: https://github.com/init6/init_6/wiki/geek-sources"
	einfo
	einfo "For more info on this patchset, and how to report problems, see:"
	for Current_Patch in $GEEKSOURCES_PATCHING_ORDER; do
		if use_if_iuse "${Current_Patch}" || [[ "${Current_Patch}" == "fix" ]] || [[ "${Current_Patch}" == "upatch" ]] ; then
			case "${Current_Patch}" in
				aufs)	if ! has_version sys-fs/aufs-util; then
						ewarn
						ewarn "In order to use aufs FS you need to install sys-fs/aufs-util"
						ewarn
					fi
					;;
				grsec) local GRADM_COMPAT="sys-apps/gradm-2.9.1"
					ewarn
					ewarn "Hardened Gentoo provides three different predefined grsecurity level:"
					ewarn "[server], [workstation], and [virtualization].  Those who intend to"
					ewarn "use one of these predefined grsecurity levels should read the help"
					ewarn "associated with the level.  Because some options require >=gcc-4.5,"
					ewarn "users with more, than one version of gcc installed should use gcc-config"
					ewarn "to select a compatible version."
					ewarn
					ewarn "Users of grsecurity's RBAC system must ensure they are using"
					ewarn "${GRADM_COMPAT}, which is compatible with ${PF}."
					ewarn "It is strongly recommended that the following command is issued"
					ewarn "prior to booting a ${PF} kernel for the first time:"
					ewarn
					ewarn "emerge -na =${GRADM_COMPAT}*"
					ewarn
					ewarn
					;;
				ice)	ewarn
					ewarn "${P} has the following optional runtime dependencies:"
					ewarn "  sys-apps/tuxonice-userui"
					ewarn "    provides minimal userspace progress information related to"
					ewarn "    suspending and resuming process"
					ewarn "  sys-power/hibernate-script or sys-power/pm-utils"
					ewarn "    runtime utilites for hibernating and suspending your computer"
					ewarn
					ewarn "If there are issues with this kernel, please direct any"
					ewarn "queries to the tuxonice-users mailing list:"
					ewarn "http://lists.tuxonice.net/mailman/listinfo/tuxonice-users/"
					ewarn
					;;
				pf)	ewarn
					ewarn "Linux kernel fork with new features, including the -ck patchset (BFS), BFQ, TuxOnIce and UKSM"
					ewarn
					;;
				reiser4) if ! has_version sys-fs/reiser4progs; then
						ewarn
						ewarn "In order to use Reiser4 FS you need to install sys-fs/reiser4progs"
						ewarn
					fi
					;;
				esac
			else continue
		fi;
	done;
}

# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-sources.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (09 Jan 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building geek kernel.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# geek kernel with any patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-sources.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

case ${EAPI} in
	5)	: ;;
	*)	die "geek-sources.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

if [[ ${___ECLASS_ONCE_GEEK_SOURCES} != "recur -_+^+_- spank" ]]; then
___ECLASS_ONCE_GEEK_SOURCES="recur -_+^+_- spank"

inherit geek-linux geek-utils geek-fix geek-upatch geek-squeue geek-vars

KNOWN_USES="aufs bfq bld brand build cjktty ck deblob exfat fedora gentoo grsec hardened ice lqx mageia openvz openwrt optimize pax pf reiser4 rh rt rsbac suse symlink uek uksm zen zfs"

# internal function
#
# @FUNCTION: USEKnown
# @USAGE:
# @DESCRIPTION:
USEKnown() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${#} -ne 1 ]] && die "Invalid number of args to ${FUNCNAME}()";

	local USE=$1
	[ "${USE}" == "" ] && die "${RED}Feature not defined!${NORMAL}"

	expr index "${SUPPORTED_USES}" "${USE}" >/dev/null || die "${RED}${USE}${NORMAL} ${BLUE}is not supported in current kernel${NORMAL}"
	expr index "${KNOWN_USES}" "${USE}" >/dev/null || die "${RED}${USE}${NORMAL} ${BLUE}is not known${NORMAL}"
	IUSE="${IUSE} ${USE}"
}

for I in ${SUPPORTED_USES}; do
	USEKnown "${I}"
done

for use_flag in ${IUSE}; do
	case ${use_flag} in
		aufs		)	inherit geek-aufs ;;
		bfq		)	inherit geek-bfq ;;
		bld		)	inherit geek-bld ;;
		brand		)	inherit geek-brand ;;
		build		)	inherit geek-build ;;
		cjktty		)	inherit geek-cjktty ;;
		ck		)	inherit geek-ck ;;
		deblob		)	inherit geek-deblob ;;
		exfat		)	inherit geek-exfat ;;
		fedora		)	inherit geek-fedora ;;
		gentoo		)	inherit geek-gentoo ;;
		grsec		)	inherit geek-grsec ;;
		hardened	)	inherit geek-hardened ;;
		ice		)	inherit geek-ice ;;
		lqx		)	inherit geek-lqx ;;
		mageia		)	inherit geek-mageia ;;
		openvz		)	inherit geek-openvz ;;
		openwrt		)	inherit geek-openwrt ;;
		optimize	)	inherit geek-optimize ;;
		pax		)	inherit geek-pax ;;
		pf		)	inherit geek-pf ;;
		reiser4		)	inherit geek-reiser4 ;;
		rh		)	inherit geek-rh ;;
		rsbac		)	inherit geek-rsbac ;;
		rt		)	inherit geek-rt ;;
		suse		)	inherit geek-suse ;;
		uek		)	inherit geek-uek ;;
		uksm		)	inherit geek-uksm ;;
		zen		)	inherit geek-zen ;;
		zfs		)	inherit geek-spl geek-zfs ;;
	esac
done

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-sources_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	# Remove duplicates patches
	local rm_duplicates_cfg=$(source $cfg_file 2>/dev/null; echo ${rm_duplicates})
	: ${rm_duplicates:=${rm_duplicates_cfg:-yes}} # rm_duplicates=yes/no
	einfo "${BLUE}Remove duplicates patches -->${NORMAL} ${RED}$rm_duplicates${NORMAL}"

	: ${SKIP_KERNEL_PATCH_UPDATE:="lqx openvz pf rh uek zen"}
	: ${DEFAULT_GEEKSOURCES_PATCHING_ORDER:="zfs optimize pax lqx pf zen bfq ck cjktty gentoo grsec hardened rsbac ice rh uek openvz openwrt reiser4 exfat rt bld uksm aufs mageia fedora suse brand fix upatch squeue"}

	local xUserOrder=""
	local xDefOder=""
	if [ -e "${cfg_file}" ]; then
		source "${cfg_file}"
		if [ ! -z "$GEEKSOURCES_PATCHING_ORDER" ]; then
			xUserOrder="$(echo -n "$GEEKSOURCES_PATCHING_ORDER" | tr '\n' ' ' | tr -s ' ' | tr ' ' '\n' | sort | tr '\n' ' ' | sed -e 's,^\s*,,' -e 's,\s*$,,')"
			xDefOrder="$(echo -n "$DEFAULT_GEEKSOURCES_PATCHING_ORDER" | tr '\n' ' ' | tr -s ' ' | tr ' ' '\n' | sort | tr '\n' ' ' | sed -e 's,^\s*,,' -e 's,\s*$,,')"

			if [ "x${xUserOrder}" = "x${xDefOrder}" ]; then
				ewarn "${BLUE}Use${NORMAL} ${RED}GEEKSOURCES_PATCHING_ORDER=\"${GEEKSOURCES_PATCHING_ORDER}\"${NORMAL} ${BLUE}from${NORMAL} ${GREEN}${cfg_file}${NORMAL}"
			else
				difference=$(echo "${xDefOrder} ${xUserOrder}" | awk '{for(i=1;i<=NF;i++){_a[$i]++}for(i in _a){if(_a[i]==1)print i}}' ORS=" ")
				ewarn "${BLUE}Use${NORMAL} ${RED}GEEKSOURCES_PATCHING_ORDER=\"${GEEKSOURCES_PATCHING_ORDER}\"${NORMAL} ${BLUE}from${NORMAL} ${GREEN}${cfg_file}${NORMAL}${BR}
${BLUE}Not all USE flag present in GEEKSOURCES_PATCHING_ORDER from${NORMAL} ${GREEN}${cfg_file}${NORMAL}${BR}
${BLUE}The following flags are missing:${NORMAL} ${RED}${difference}${NORMAL}${BR}
${BLUE}Probably that"\'"s the plan. In that case, never mind.${NORMAL}${BR}"
			fi
		fi
	fi

	if [ -z "$GEEKSOURCES_PATCHING_ORDER" ]; then
		GEEKSOURCES_PATCHING_ORDER="${DEFAULT_GEEKSOURCES_PATCHING_ORDER}"
		ewarn "${BLUE}The order of patching is defined in file${NORMAL} ${GREEN}${cfg_file}${NORMAL} ${BLUE}with the variable GEEKSOURCES_PATCHING_ORDER is its default value:${NORMAL}
${RED}GEEKSOURCES_PATCHING_ORDER=\"${GEEKSOURCES_PATCHING_ORDER}\"${NORMAL}
${BLUE}You are free to choose any order of patching.${NORMAL}
${BLUE}For example, if you like the alphabetical order of patching you must set the variable:${NORMAL}
${RED}echo 'GEEKSOURCES_PATCHING_ORDER=\"`echo ${GEEKSOURCES_PATCHING_ORDER} | sed "s/ /\n/g" | sort | sed ':a;N;$!ba;s/\n/ /g'`\"' > ${cfg_file}${NORMAL}
${BLUE}Otherwise i will use the default value of GEEKSOURCES_PATCHING_ORDER!${NORMAL}
${BLUE}And may the Force be with you…${NORMAL}"
	fi

	debug-print "${FUNCNAME}: rm_duplicates=$rm_duplicates"
	debug-print "${FUNCNAME}: SKIP_KERNEL_PATCH_UPDATE=${SKIP_KERNEL_PATCH_UPDATE}"
	debug-print "${FUNCNAME}: DEFAULT_GEEKSOURCES_PATCHING_ORDER=${DEFAULT_GEEKSOURCES_PATCHING_ORDER}"
}

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-sources_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${BLUE}Crap patch -->${NORMAL} ${RED}$crap_patch${NORMAL}"
	einfo "${BLUE}Disable fixes -->${NORMAL} ${RED}$disable_fixes${NORMAL}"
	einfo "${BLUE}Remove unneeded architectures -->${NORMAL} ${RED}$rm_unneeded_arch${NORMAL}"
	einfo "${BLUE}Compile ${RED}gen_init_cpio${NORMAL} ${BLUE}-->${NORMAL} ${RED}$gen_init_cpio${NORMAL}"
	einfo "${BLUE}Running ${RED}make oldconfig${NORMAL} ${BLUE}-->${NORMAL} ${RED}$oldconfig${NORMAL}"
	einfo "${BLUE}Skip stable-queue -->${NORMAL} ${RED}$skip_squeue${NORMAL}"

	geek-sources_init_variables

	for Current_Patch in $SKIP_KERNEL_PATCH_UPDATE; do
		if use_if_iuse "${Current_Patch}"; then
		case "${Current_Patch}" in
			*) SKIP_UPDATE="1" skip_squeue="yes" ;;
		esac
		else continue
		fi
	done

	if use_if_iuse "rh"; then
		[[ ${KMV} = "3.10" ]] && geek-rh_src_unpack
	elif use_if_iuse "uek"; then
		geek-uek_src_unpack
	else
		geek-linux_src_unpack
	fi

	test -d "${WORKDIR}/linux-${KV_FULL}-patches" >/dev/null 2>&1 || mkdir -p "${WORKDIR}/linux-${KV_FULL}-patches"
	for Current_Patch in $GEEKSOURCES_PATCHING_ORDER; do
		if use_if_iuse "${Current_Patch}" || [ "${Current_Patch}" = "fix" ] || [ "${Current_Patch}" = "upatch" ] || [ "${Current_Patch}" = "squeue" ]; then
			einfo "Unpack - ${Current_Patch}"
			case "${Current_Patch}" in
				aufs		)	geek-aufs_src_unpack ;;
				bfq		)	geek-bfq_src_unpack ;;
				bld		)	geek-bld_src_unpack ;;
				cjktty		)	geek-cjktty_src_unpack ;;
				exfat		)	geek-exfat_src_unpack ;;
				fedora		)	geek-fedora_src_unpack ;;
				gentoo		)	geek-gentoo_src_unpack ;;
				hardened	)	geek-hardened_src_unpack ;;
				ice		)	geek-ice_src_unpack ;;
				mageia		)	geek-mageia_src_unpack ;;
				openwrt		)	geek-openwrt_src_unpack ;;
				optimize	)	geek-optimize_src_unpack ;;
				pf		)	geek-pf_src_unpack ;;
				rh		)	[[ ${KMV} = "2.6" ]] && geek-rh_src_unpack ;;
				squeue		)	geek-squeue_src_unpack ;;
				suse		)	geek-suse_src_unpack ;;
				uksm		)	geek-uksm_src_unpack ;;
				zen		)	geek-zen_src_unpack ;;
				zfs		)	geek-spl_src_unpack; geek-zfs_src_unpack ;;
			esac
		else continue
		fi
	done

	# Now find and remove all duplicates patches
	einfo "${YELLOW}Find and remove all duplicates patches ...${NORMAL}"
	for dubl_file in $(find ${T} -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate | cut -f3-100 -d ' ' | tr '\n.' '\t.' | sed 's/\t\t/\n/g' | cut -f2-100 | tr '\t' '\n' | perl -i -pe 's/([ (){}-])/\\$1/g' | perl -i -pe 's/'\''/\\'\''/g' | tr '\n' ' '); do
		if [ "${rm_duplicates}" = "yes" ]; then
			einfo "Remove - $dubl_file"
			rm -v "$dubl_file" >/dev/null 2>&1
			debug-print "${FUNCNAME}: $dubl_file"
		elif [ "${rm_duplicates}" = "no" ]; then
			debug-print "${FUNCNAME}: $dubl_file"
		fi
	done
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-sources_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	for Current_Patch in $GEEKSOURCES_PATCHING_ORDER; do
		if use_if_iuse "${Current_Patch}" || [ "${Current_Patch}" = "fix" ] || [ "${Current_Patch}" = "upatch" ] || [ "${Current_Patch}" = "squeue" ]; then
#			einfo "Prepare - ${Current_Patch}"
			case "${Current_Patch}" in
				aufs		)	geek-aufs_src_prepare ;;
				bfq		)	geek-bfq_src_prepare ;;
				bld		)	geek-bld_src_prepare ;;
				brand		)	geek-brand_src_prepare ;;
				cjktty		)	geek-cjktty_src_prepare ;;
				ck		)	geek-ck_src_prepare ;;
				exfat		)	geek-exfat_src_prepare ;;
				fedora		)	geek-fedora_src_prepare ;;
				fix		)	geek-fix_src_prepare ;;
				gentoo		)	geek-gentoo_src_prepare ;;
				grsec		)	geek-grsec_src_prepare ;;
				hardened	)	geek-hardened_src_prepare ;;
				ice		)	geek-ice_src_prepare ;;
				lqx		)	geek-lqx_src_prepare ;;
				mageia		)	geek-mageia_src_prepare ;;
				openvz		)	geek-openvz_src_prepare ;;
				openwrt		)	geek-openwrt_src_prepare ;;
				optimize	)	geek-optimize_src_prepare ;;
				pax		)	geek-pax_src_prepare ;;
				pf		)	geek-pf_src_prepare ;;
				reiser4		)	geek-reiser4_src_prepare ;;
				rh		)	geek-rh_src_prepare ;;
				rsbac		)	geek-rsbac_src_prepare ;;
				rt		)	geek-rt_src_prepare ;;
				squeue		)	geek-squeue_src_prepare ;;
				suse		)	geek-suse_src_prepare ;;
				uksm		)	geek-uksm_src_prepare ;;
				upatch		)	geek-upatch_src_prepare ;;
				zen		)	geek-zen_src_prepare ;;
				zfs		)	geek-spl_src_prepare; geek-zfs_src_prepare ;;
			esac
		else continue
		fi
	done

	if use_if_iuse "rh"; then
		[[ ${KMV} = "3.10" ]] && geek-rh_src_prepare
	elif use_if_iuse "uek"; then
		geek-uek_src_prepare
	else
		geek-linux_src_prepare
	fi
}

# @FUNCTION: src_compile
# @USAGE:
# @DESCRIPTION: Configure and build the package.
geek-sources_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	geek-linux_src_compile
}

# @FUNCTION: src_install
# @USAGE:
# @DESCRIPTION: Install a package to ${D}
geek-sources_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	geek-linux_src_install
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-sources_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	geek-linux_pkg_postinst
	einfo "${BR}${BLUE}Wiki:${NORMAL} ${RED}https://github.com/init6/init_6/wiki/geek-sources${NORMAL}${BR}
${BLUE}Bugs:${NORMAL} ${RED}https://github.com/init6/init_6/issues${NORMAL}${BR}
${BLUE}Donate:${NORMAL} ${RED}https://github.com/init6/init_6/wiki/donate${NORMAL}${BR}
${BLUE}For more info about patchset’s, and how to report problems, see:${NORMAL}${BR}"
	for Current_Patch in $GEEKSOURCES_PATCHING_ORDER; do
		if use_if_iuse "${Current_Patch}" || [[ "${Current_Patch}" == "fix" ]] || [[ "${Current_Patch}" == "upatch" ]]; then
			case "${Current_Patch}" in
				aufs		) geek-aufs_pkg_postinst ;;
				bfq		) geek-bfq_pkg_postinst ;;
				bld		) geek-bld_pkg_postinst ;;
				brand		) geek-brand_pkg_postinst ;;
				cjktty		) geek-cjktty_pkg_postinst ;;
				ck		) geek-ck_pkg_postinst ;;
				deblob		) geek-deblob_pkg_postinst ;;
				exfat		) geek-exfat_pkg_postinst ;;
				fedora		) geek-fedora_pkg_postinst ;;
				gentoo		) geek-gentoo_pkg_postinst ;;
				grsec		) geek-grsec_pkg_postinst ;;
				hardened	) geek-hardened_pkg_postinst ;;
				ice		) geek-ice_pkg_postinst ;;
				lqx		) geek-lqx_pkg_postinst ;;
				mageia		) geek-mageia_pkg_postinst ;;
				openvz		) geek-openvz_pkg_postinst ;;
				openwrt		) geek-openwrt_pkg_postinst ;;
				optimize 	) geek-optimize_pkg_postinst ;;
				pax		) geek-pax_pkg_postinst ;;
				pf		) geek-pf_pkg_postinst ;;
				reiser4		) geek-reiser4_pkg_postinst ;;
				rh		) geek-rh_pkg_postinst ;;
				rsbac		) geek-rsbac_pkg_postinst ;;
				rt		) geek-rt_pkg_postinst ;;
				squeue		) geek-squeue_pkg_postinst ;;
				suse		) geek-suse_pkg_postinst ;;
				uksm		) geek-uksm_pkg_postinst ;;
				zen		) geek-zen_pkg_postinst ;;
				zfs		) geek-spl_pkg_postinst; geek-zfs_pkg_postinst ;;
			esac
			else continue
		fi
	done
}

fi

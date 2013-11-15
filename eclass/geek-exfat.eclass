# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-exfat.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (20 Sep 2013)
# @BLURB: Eclass for building kernel with exfat patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with exfat patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-exfat.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

inherit geek-patch geek-utils geek-vars

EXPORT_FUNCTIONS src_unpack src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-exfat_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${EXFAT_VER:=${EXFAT_VER:-$KMV}}
	: ${EXFAT_SRC:=${EXFAT_SRC:-"https://github.com/damentz/zen-kernel/compare/torvalds:v${EXFAT_VER/KMV/$KMV}...${EXFAT_VER/KMV/$KMV}/exfat.diff"}}
	: ${EXFAT_URL:=${EXFAT_URL:-"http://opensource.samsung.com/reception/receptionSub.do?method=search&searchValue=exfat"}}
	: ${EXFAT_INF:=${EXFAT_INF:-"${YELLOW}Samsung’s exFAT fs Linux driver -${GREEN} ${EXFAT_URL}${NORMAL}"}}
}

geek-exfat_init_variables

HOMEPAGE="${HOMEPAGE} ${EXFAT_URL}"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-exfat_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CSD="${GEEK_STORE_DIR}/exfat"
	local CWD="${T}/exfat"
	local CTD="${T}/exfat"$$
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	dest="${CWD}"/exfat-"${PV}"-`date +"%Y%m%d"`.patch
	wget "${EXFAT_SRC}" -O "${dest}" > /dev/null 2>&1
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"
	ls -1 | grep ".patch" | xargs -I{} xz "{}" | xargs -I{} cp "{}" "${CWD}"
	ls -1 "${CWD}" | grep ".patch.xz" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-exfat_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/exfat/patch_list" "${EXFAT_INF}"
	mv "${T}/exfat" "${WORKDIR}/linux-${KV_FULL}-patches/exfat" || die "${RED}mv ${T}/exfat ${WORKDIR}/linux-${KV_FULL}-patches/exfat failed${NORMAL}"
#	rsync -avhW --no-compress --progress "${T}/exfat/" "${WORKDIR}/linux-${KV_FULL}-patches/exfat" || die "${RED}rsync -avhW --no-compress --progress ${T}/exfat/ ${WORKDIR}/linux-${KV_FULL}-patches/exfat failed${NORMAL}"

	local EXFAT_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/${PV}/exfat"
	test -d "${EXFAT_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${EXFAT_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for exfat patchset from${NORMAL} ${GREEN} ${EXFAT_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for exfat patchset from not existing${GREEN} ${EXFAT_FIX_PATCH_DIR}!${NORMAL}"
	local EXFAT_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/exfat"
	test -d "${EXFAT_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${EXFAT_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for exfat patchset from${NORMAL} ${GREEN} ${EXFAT_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for exfat patchset from not existing${GREEN} ${EXFAT_FIX_PATCH_DIR}!${NORMAL}"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-exfat_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${EXFAT_INF}"
}
